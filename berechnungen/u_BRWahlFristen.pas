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
unit u_BRWahlFristen;

interface

uses
  SysUtils, DateUtils;

type
  {
    TWahlVerfahren:
    Enumeration, die den Typ des Wahlverfahrens darstellt.

    Werte:
      - wvAllgemein: Stellt das allgemeine Wahlverfahren dar.
      - wvVereinfacht: Stellt das vereinfachte Wahlverfahren dar.
  }
  TWahlVerfahren = (wvAllgemein, wvVereinfacht);

  PTWahlFristen = ^TWahlFristen;
  {
    TWahlFristen ist ein Record, der verschiedene Termine und Fristen im Zusammenhang mit einem Wahlprozess darstellt.

    Felder:
      - Wahltag: TDate
          Das Datum der Wahl.

      - Verfahren: TWahlVerfahren
          Der Typ oder das Verfahren der Wahl.

      - SpaetesterWahlvorstand: TDate
          Das späteste Datum, bis zu dem der Wahlvorstand gebildet sein muss.

      - WahlausschreibenDatum: TDate
          Das Datum, an dem die Wahlausschreibung erfolgt.

      - VorschlagsfristEnde: TDate
          Die Frist für die Einreichung von Vorschlägen oder Nominierungen.

      - BekanntgabeVorschlaege: TDate
          Das Datum, an dem die Vorschläge oder Nominierungen bekannt gegeben werden.

      - BekanntgabeErgebnis: TDate
          Das Datum, an dem die Wahlergebnisse bekannt gegeben werden.

      - AnfechtungsfristEnde: TDate
          Die Frist für die Anfechtung der Wahlergebnisse.
  }
  TWahlFristen = record
    Wahltag: TDate;
    Verfahren: TWahlVerfahren;

    SpaetesterWahlvorstand: TDate;
    WahlausschreibenDatum: TDate;
    VorschlagsfristEnde: TDate;
    BekanntgabeVorschlaege: TDate;
    BekanntgabeErgebnis: TDate;
    AnfechtungsfristEnde: TDate;
  end;


  {
    TRegelwahlStatus:
    Dieser Record repräsentiert den Status einer regulären Wahlperiode. Er enthält die folgenden Felder:

    - InWahlperiode (Boolean): Gibt an, ob das aktuelle Datum innerhalb der Wahlperiode liegt.
    - Jahr (Word): Das Jahr, das mit der Wahlperiode verbunden ist.
    - Start (TDate): Das Startdatum der Wahlperiode.
    - Ende (TDate): Das Enddatum der Wahlperiode.
  }
  TRegelwahlStatus = record
    InWahlperiode: Boolean;
    Jahr: Word;
    Start: TDate;
    Ende: TDate;
  end;

function PruefeRegulaereWahlperiode(Heute: TDate): TRegelwahlStatus;
function BerechneWahlFristen(Wahltag: TDate; Verfahren: TWahlVerfahren): TWahlFristen;
function PruefeWahlFristen( fristen : TWahlFristen; var msg : string ) : Boolean;

implementation

{
  /**
   * Berechnet die Fristen für eine Wahl basierend auf dem Wahltag und dem Wahlverfahren.
   *
   * @param Wahltag Das Datum des Wahltags (TDate).
   * @param Verfahren Das Wahlverfahren, das angewendet wird (TWahlVerfahren).
   * @return Ein TWahlFristen-Objekt, das die berechneten Fristen enthält.
   */
}
function BerechneWahlFristen(Wahltag: TDate; Verfahren: TWahlVerfahren): TWahlFristen;
begin
  Result.Wahltag := Wahltag;
  Result.Verfahren := Verfahren;
  Result.BekanntgabeErgebnis := Wahltag;
  Result.AnfechtungsfristEnde := IncDay(Wahltag, 14);

  if Verfahren = wvAllgemein then
  begin
    Result.WahlausschreibenDatum  := IncDay(Wahltag, -42); // 6 Wochen vor Wahl
    Result.VorschlagsfristEnde    := IncDay(Result.WahlausschreibenDatum, 14); // 2 Wochen danach
    Result.BekanntgabeVorschlaege := IncDay(Result.VorschlagsfristEnde, 1);
    Result.SpaetesterWahlvorstand := IncDay(Wahltag, -70); // 10 Wochen vor Wahl
  end
  else // Vereinfachtes Verfahren
  begin
    Result.SpaetesterWahlvorstand := IncDay(Wahltag, -14); // mindestens 14 Tage vorher
    Result.WahlausschreibenDatum  := IncDay(Wahltag, -7);   // spätestens 7 Tage vor Wahl
    Result.VorschlagsfristEnde    := IncDay(Wahltag, -6);     // spätestens 6 Tage vor Wahl
    Result.BekanntgabeVorschlaege := IncDay(Result.VorschlagsfristEnde, 1); // optional
  end;
end;

{
  /**
   * Überprüft die reguläre Wahlperiode basierend auf dem angegebenen Datum.
   *
   * @param Heute Das aktuelle Datum, um die Wahlperiode zu bewerten.
   * @return Ein Wert vom Typ TRegelwahlStatus, der den Status der regulären Wahlperiode angibt.
   */
}
function PruefeRegulaereWahlperiode(Heute: TDate): TRegelwahlStatus;
var
  Jahr, Monat, Tag: Word;
  WahlJahr: Word;
begin
  DecodeDate(Heute, Jahr, Monat, Tag);

  // Berechne letztes reguläres Wahljahr (2022, 2026, 2030, …)
  WahlJahr := 2022;
  while WahlJahr + 4 <= Jahr do
    Inc(WahlJahr, 4);

  Result.Start := EncodeDate(WahlJahr, 3, 1);
  Result.Ende  := EncodeDate(WahlJahr, 5, 31);
  Result.Jahr  := WahlJahr;
  Result.InWahlperiode := (Heute >= Result.Start) and (Heute <= Result.Ende);
end;

function PruefeWahlFristen( fristen : TWahlFristen; var msg : string ) : Boolean;
var
  days : Integer;
begin
  Result := true;

  if fristen.Verfahren = wvVereinfacht then
  begin
    days := DaysBetween(fristen.Wahltag, fristen.SpaetesterWahlvorstand);
    if days < 14 then
    begin
      Result := false;
      msg := msg + Format('Der Wahlvorstand muss mindestens 14 Tage vor der Wahl bestellt werden, es sind aber nur %d%s', [days, #13]);
    end;

    days := DaysBetween(fristen.WahlausschreibenDatum, fristen.SpaetesterWahlvorstand);
    if days < 7  then
    begin
      Result := false;
      msg := msg + Format('Das Wahlsausschreiben muss 7 nach der Bestllung des  Wahlvorstandesausgehängt werden werden, es sind aber nur %d%s', [days, #13]);
    end;

    days := DaysBetween(fristen.VorschlagsfristEnde, fristen.Wahltag);
    if days < 6 then
    begin
      Result := false;
      msg := msg + Format('Die Einreichungsfrist der Wahlvorschläge endet 6 Tage  vor der Wal, hier sind es sind aber %d%s', [days, #13]);
    end;

  end
  else
  begin
    days := DaysBetween(fristen.Wahltag, fristen.SpaetesterWahlvorstand);
    if days < 10 * 7 then
    begin
      Result := false;
      msg := msg + Format('Der Wahlvorstand muss 70 Tage vor der Wahl bestellt werden, es sind aber nur %d%s', [days, #13]);
    end;
    days := DaysBetween(fristen.Wahltag, fristen.WahlausschreibenDatum);
    if days < 6 * 7 then
    begin
      Result := false;
      msg := msg + Format('Das Wahlsausschreiben muss 60 Tage vor der Wahl ausgehängt werden werden, es sind aber nur %d%s', [days, #13]);
    end;
    days := DaysBetween(fristen.VorschlagsfristEnde, fristen.WahlausschreibenDatum);
    if days < 14 then
    begin
      Result := false;
      msg := msg + Format('Die Einreichungsfrist der Wahlvorschläge endet 14 Tage nach dem Aushang des Wahlausschreibens. hier sind es sind aber %d%s', [days, #13]);
    end;

    days := DaysBetween(fristen.VorschlagsfristEnde, fristen.BekanntgabeVorschlaege);
    if (days <> 1) then
    begin
      Result := false;
      msg := msg + Format('Die Bekanntgabe der gültigen Wahlvorschläge hat am Tag nach dem Ende der Einreichungsfrist zu erfolgen%s', [#13]);
    end;
    if fristen.VorschlagsfristEnde > fristen.BekanntgabeVorschlaege then
    begin
      Result := false;
      msg := msg + Format('Die Bekanntgabe der Vorschkläge kann nicht vor dem Vorschlagsendeerfolgen.%s', [#13]);
    end;

    days := DaysBetween(fristen.BekanntgabeVorschlaege, fristen.Wahltag);
    if days < 7  then
    begin
      Result := false;
      msg := msg + Format('Der Wahltag darf frühstens 1 Woche nach bekanntgabe der gültigen Wahlvorschläge sein %s', [#13]);
    end;
  end;

  if fristen.Wahltag <> fristen.BekanntgabeErgebnis then
  begin
    Result := false;
    msg := msg + Format('Die Wahlergebnisse müssen am Wahltag bekanntgegeben werden', [#13]);
  end;
  days := DaysBetween(fristen.Wahltag, fristen.AnfechtungsfristEnde);
  if days <> 14  then
  begin
    Result := false;
    msg := msg + Format('die Frist für due Anfechtung der Wahlergebnisse liegt bei genau 14 Tagen! %s', [#13]);
  end;


end;

end.

