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
  u_Waehlerliste, System.JSON, i_waehlerliste;

type
  TWaehlerlisteVergleich = class
    private
      m_result : IWaehlerListe;

      m_new : IWaehlerListe;
      m_old : IWaehlerListe;

      m_add : IWaehlerListe;
      m_del : IWaehlerListe;
      m_chg : IWaehlerListe;

      procedure clear;
      procedure findDeleted;
      procedure findAdded;
      procedure findChanged;

    public
      constructor create;
      Destructor Destroy; override;

      property ResultList : IWaehlerListe read m_result;


      property AddList : IWaehlerListe read m_add;
      property DelList : IWaehlerListe read m_del;
      property ChgList : IWaehlerListe read m_chg;

      procedure execute( newList, oldList : TWaehlerListe ); overload;
      procedure execute( newList : TJSONObject; fname : string ); overload;

      procedure WriteChangeLog( fname : string );

  end;

implementation

uses
  system.IOUtils, u_json;

{ TWaehlerlisteVergleich }

procedure TWaehlerlisteVergleich.clear;
begin
  m_result.clear;

  m_new.clear;
  m_old.clear;

  m_add.clear;
  m_del.clear;
  m_chg.clear;

end;

constructor TWaehlerlisteVergleich.create;
begin
  m_result  := TWaehlerListe.create;

  m_new     := TWaehlerListe.create;
  m_old     := TWaehlerListe.create;

  m_add     := TWaehlerListe.create;
  m_del     := TWaehlerListe.create;
  m_chg     := TWaehlerListe.create;

end;

destructor TWaehlerlisteVergleich.Destroy;
begin
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
  clear;

  m_old.loadFromFile(fname);
  m_new.fromJSON(newList);


  m_result.Assign(m_old);

  findAdded;
  findDeleted;
  findChanged;
end;

procedure TWaehlerlisteVergleich.execute(newList, oldList: TWaehlerListe);
begin
  clear;

  m_old.Assign(oldList);
  m_new.Assign(newList);


  m_result.Assign(oldList);

  findAdded;
  findDeleted;
  findChanged;

end;

procedure TWaehlerlisteVergleich.findAdded;
var
  nw : IWaehler;
begin
  for nw in m_new.Items do
  begin
    if not m_old.hasWaehler(nw.PersNr) then
    begin
      m_result.add(nw.clone);
      m_add.add(nw.clone);
    end;
  end;
end;

procedure TWaehlerlisteVergleich.findChanged;
var
  new, old : IWaehler;
begin
  for old in m_result.Items do
  begin
    new := m_new.getWaehler(old.PersNr);
    if Assigned(new) then
    begin
      if not old.compare(new) then
      begin
        m_chg.add(new.clone);
        m_chg.add(old.clone);
        old.Assign(new);
      end;
    end;
  end;
end;

procedure TWaehlerlisteVergleich.findDeleted;
var
  ow : IWaehler;
begin
  for ow in m_old.Items do
  begin
    if not m_new.hasWaehler(ow.PersNr) then
    begin
      m_del.add(ow.clone);
      m_result.delete(ow.PersNr)
    end;
  end;
end;

procedure TWaehlerlisteVergleich.WriteChangeLog( fname : string );
var
  Result : TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace(Result, 'add', m_add.toSimpleJSON);
  JReplace(Result, 'del', m_del.toSimpleJSON);
  JReplace(Result, 'change', m_chg.toSimpleJSON);

  saveJSON(Result, fname);
  Result.Free;
end;

end.
