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

end.

