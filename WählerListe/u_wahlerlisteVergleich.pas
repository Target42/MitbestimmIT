{
  This file is part of the MitbestimmIT project.

  Copyright (C) 2025 Stephan Winter

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <https://www.gnu.org/licenses/>.
}
unit u_wahlerlisteVergleich;

interface

uses
  u_Waehlerliste, System.JSON, i_waehlerliste, System.Classes;

type
  // Klasse zum Vergleichen von Wählerlisten und Erzeugen der Änderungslisten
  TWaehlerlisteVergleich = class
    private
      // Ergebnisliste nach Anwendung der Änderungen auf die alte Liste
      m_result : IWaehlerListe;

      // Temporäre Referenzen für neue und alte Liste
      m_new : IWaehlerListe;
      m_old : IWaehlerListe;

      // Listen mit Differenzen
      m_add : IWaehlerListe; // hinzugefügt
      m_del : IWaehlerListe; // gelöscht
      m_chg : IWaehlerListe; // geändert

      // Hilfsroutinen zur Durchführung des Vergleichs
      procedure clear;           // leert alle internen Listen
      procedure findDeleted;     // ermittelt gelöschte Einträge
      procedure findAdded;       // ermittelt hinzugekommene Einträge
      procedure findChanged;     // ermittelt geänderte Einträge

      procedure updateIDs;       // überträgt IDs von alter auf neue Liste

    public
      constructor create;
      Destructor Destroy; override;

      property ResultList : IWaehlerListe read m_result;

      // Zugriff auf die Änderungslisten
      property AddList : IWaehlerListe read m_add;
      property DelList : IWaehlerListe read m_del;
      property ChgList : IWaehlerListe read m_chg;

      // Vergleichsoperationen (Overloads)
      procedure execute( newList, oldList : IWaehlerListe ); overload;
      procedure execute( newList : TJSONObject; fname : string ); overload;

      // Änderungsprotokoll schreiben (als Datei oder in einen Stream)
      procedure WriteChangeLog( fname : string ); overload;
      procedure WriteChangeLog( st: TStream ); overload;

  end;

implementation

uses
  system.IOUtils, u_json;

{
  Diese Unit vergleicht zwei Wählerlisten (alt und neu) und ermittelt
  hinzugekommene, gelöschte und geänderte Einträge. Sie stellt außerdem
  Funktionen zum Erzeugen eines Änderungsprotokolls (ChangeLog) bereit.

  Klassenübersicht:
    - TWaehlerlisteVergleich
        Vergleicht zwei IWaehlerListe-Instanzen bzw. eine neue Liste und
        eine aus Datei geladene alte Liste. Ergebnislisten:
          * ResultList - Ergebnis nach Anwendung der Änderungen auf die alte Liste
          * AddList    - neu hinzugekommene Wähler
          * DelList    - gelöschte Wähler
          * ChgList    - geänderte Wähler

  Wichtige Methoden:
    - execute(newList, oldList) / execute(newList, fname)
        Führt den Vergleich durch. Die Overload mit fname lädt die alte
        Liste aus einer Datei.

    - findAdded, findDeleted, findChanged
        Interne Hilfsroutinen, die die jeweiligen Differenzen ermitteln.

    - updateIDs
        Überträgt vorhandene IDs von der alten Liste auf die neue Liste,
        sofern PersNr in beiden Listen übereinstimmt.

    - WriteChangeLog
        Schreibt die Add/Del/Change-Listen als JSON in einen Stream oder in
        eine Datei.

  Hinweise zur Nutzung:
    - Die Klasse arbeitet mit den Schnittstellen IWaehlerListe / IWaehler.
      Die Methoden clone, Assign, getWaehler, hasWaehler, etc. müssen
      von den Implementierungen bereitgestellt werden.
}

{ TWaehlerlisteVergleich }

procedure TWaehlerlisteVergleich.clear;
begin
  // Alle internen Listen leeren, damit ein neuer Vergleich sauber startet
  m_result.clear;

  m_new.clear;
  m_old.clear;

  m_add.clear;
  m_del.clear;
  m_chg.clear;

end;

constructor TWaehlerlisteVergleich.create;
begin
  // Erzeugen der Listen-Objekte (Implementierung liefert IWaehlerListe)
  m_result  := TWaehlerListe.create;

  m_new     := TWaehlerListe.create;
  m_old     := TWaehlerListe.create;

  m_add     := TWaehlerListe.create;
  m_del     := TWaehlerListe.create;
  m_chg     := TWaehlerListe.create;

end;

destructor TWaehlerlisteVergleich.Destroy;
begin
  // Freigeben der Referenzen (release erwartet, dass die Implementierung die Freigabe
  // intern regelt, z.B. Referenzzählung oder Ressourcenfreigabe)
  m_result.release;

  m_new.release;
  m_old.release;

  m_add.release;
  m_del.release;
  m_chg.release;

  inherited;
end;


procedure TWaehlerlisteVergleich.execute(newList: TJSONObject; fname : string);
begin
  // Variante: neue Liste als JSON übergeben, alte Liste aus Datei laden
  clear;

  m_old.loadFromFile(fname);
  m_new.fromJSON(newList);

  // IDs aus alter Liste auf neue Liste übertragen (sofern PersNr gleich)
  updateIDs;

  // Ergebnis beginnt als Kopie der alten Liste
  m_result.Assign(m_old);

  // Differenzen ermitteln
  findAdded;
  findDeleted;
  findChanged;
end;

procedure TWaehlerlisteVergleich.execute(newList, oldList: IWaehlerListe);
begin
  // Variante: beide Listen als IWaehlerListe übergeben
  clear;

  m_old.Assign(oldList);
  m_new.Assign(newList);

  updateIDs;

  m_result.Assign(oldList);

  findAdded;
  findDeleted;
  findChanged;

end;

procedure TWaehlerlisteVergleich.findAdded;
var
  nw : IWaehler;
  ow : IWaehler;
begin
  // Durchlaufen der neuen Liste: Einträge, die in der alten Liste nicht vorhanden sind,
  // gelten als hinzugefügt.
  for nw in m_new.Items do
  begin
    ow := m_old.getWaehler(nw.PersNr);

    if not Assigned(ow) then
    begin
      // Neu gefundenen Eintrag zu Ergebnis- und Add-Liste hinzufügen (als Kopie)
      m_result.add(nw.clone);
      m_add.add(nw.clone);
    end
    else
    begin
      // Existierende Einträge erhalten die ID aus der alten Liste
      nw.ID := ow.ID;
    end;
  end;
end;

procedure TWaehlerlisteVergleich.findChanged;
var
  new, old : IWaehler;
begin
  // Vergleicht die Einträge der Ergebnisliste mit der neuen Liste.
  // Wenn ein Eintrag existiert, aber sich inhaltlich unterscheidet,
  // wird er in die Chg-Liste aufgenommen und im Ergebnis aktualisiert.
  for old in m_result.Items do
  begin
    new := m_new.getWaehler(old.PersNr);
    if Assigned(new) then
    begin
      if not old.compare(new) then
      begin
        m_chg.add(new.clone);
        old.Assign(new);
      end;
    end;
  end;
end;

procedure TWaehlerlisteVergleich.findDeleted;
var
  ow : IWaehler;
begin
  // Einträge, die in der alten Liste vorhanden sind, aber in der neuen nicht,
  // gelten als gelöscht.
  for ow in m_old.Items do
  begin
    if not m_new.hasWaehler(ow.PersNr) then
    begin
      m_del.add(ow.clone);
      m_result.delete(ow.PersNr)
    end;
  end;
end;

procedure TWaehlerlisteVergleich.updateIDs;
var
  nma : IWaehler;
  oma : IWaehler;
begin
  // Überträgt IDs von der alten auf die neue Liste basierend auf PersNr,
  // damit neue Objekte nach dem Vergleich die korrekten IDs behalten.
  for nma in m_new.Items do
  begin
    oma := m_old.getWaehler(nma.PersNr);
    if Assigned(oma) then
    begin
      nma.ID := oma.ID;
    end;
  end;

end;

procedure TWaehlerlisteVergleich.WriteChangeLog(st: TStream);
var
  Result : TJSONObject;
begin
  // Erstellt ein JSON-Objekt mit den drei Differenzlisten und schreibt es in den Stream
  Result := TJSONObject.Create;

  JReplace(Result, 'add', m_add.toSimpleJSON);
  JReplace(Result, 'del', m_del.toSimpleJSON);
  JReplace(Result, 'change', m_chg.toSimpleJSON);

  saveJSON(Result, st);
  Result.Free;
end;

procedure TWaehlerlisteVergleich.WriteChangeLog( fname : string );
var
  st : TStream;
begin
  // Schreibt das Änderungsprotokoll in eine Datei (Datei wird neu erzeugt)
  st := TFileStream.Create(fname, fmCreate);
  WriteChangeLog( st);
  st.Free;
end;

end.
