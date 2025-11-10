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

unit u_BER_Berechnungen;
{
  Diese Unit stellt Funktionen zur Berechnung verschiedener Aspekte der Zusammensetzung
  und Anforderungen eines Betriebsrats basierend auf der Anzahl der Beschäftigten und der Geschlechterverteilung bereit.

  Typen:
    - TGender: Enumeration, die das Geschlecht repräsentiert (gUnknown, gMale, gFemale, gDiverse).

  Funktionen:
    - Minderheitengeschlecht(AnzahlMaenner, AnzahlFrauen: Integer): TGender
        Bestimmt das Minderheitengeschlecht basierend auf der Anzahl von Männern und Frauen.
        Gibt gUnknown zurück, wenn die Zahlen gleich sind, gMale, wenn Männer die Minderheit sind,
        und gFemale, wenn Frauen die Minderheit sind.

    - MindestanzahlMinderheitengeschlecht(AnzahlMaenner, AnzahlFrauen, Betriebsratsgroesse: Integer): Integer
        Berechnet die Mindestanzahl der Vertreter des Minderheitengeschlechts
        im Betriebsrat basierend auf der Gesamtzahl von Männern, Frauen und der Größe des Betriebsrats.
        Verwendet den Anteil des Minderheitengeschlechts und rundet auf die nächste ganze Zahl auf.

    - BerechneBetriebsratsgroesse(AnzahlBeschaeftigte: Integer): Integer
        Berechnet die Größe des Betriebsrats basierend auf der Anzahl der Beschäftigten.
        Gibt 0 zurück, wenn kein Betriebsrat erforderlich ist, oder die entsprechende Größe basierend auf vordefinierten Schwellenwerten.

    - BerechneAnzahlFreistellungen(Betriebsratsgroesse: Integer): Integer
        Bestimmt die Anzahl der erforderlichen Freistellungen (Vollzeitfreistellungen) für Betriebsratsmitglieder
        basierend auf der Größe des Betriebsrats. Gibt 0 zurück, wenn keine Freistellungen erforderlich sind, oder die entsprechende
        Anzahl basierend auf vordefinierten Schwellenwerten.
}

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TGender = (gUnknown, gMale, gFemale, gDiverse);


function Minderheitengeschlecht(male, female: Integer): TGender;
function MindestanzahlMinderheitengeschlecht(
  male, female, gremium: Integer): Integer;
function BerechneBetriebsratsgroesse(AnzahlBeschaeftigte: Integer): Integer;
function BerechneAnzahlFreistellungen(AnzahlBeschaeftigte: Integer): Integer;
function GenderToString(Gender: TGender): string;
function StringToGender(const GenderStr: string): TGender;


implementation

uses
  Math;

{
  TSitze:
  Ein Record-Typ, der Sitzberechnungen mit den folgenden Feldern darstellt:
  
  - min: Integer
    Die minimale Anzahl an Sitzen.
  
  - max: Integer
    Die maximale Anzahl an Sitzen.
  
  - anz: Integer
    Die aktuelle oder berechnete Anzahl an Sitzen.
}
type
  TSitze = record
    min, max, anz: Integer;
  end;

{
  /**
   * Determines the minority gender based on the number of males and females.
   *
   * @param male The number of males.
   * @param female The number of females.
   * @return TGender The gender that is in the minority.
   */
}
function Minderheitengeschlecht(male, female: Integer): TGender;
begin
  if (male = female) then
    Result := gUnknown
  else if (male < female) then
    Result := gMale
  else
    Result := gFemale;
end;

{
  /**
   * Berechnet die Mindestanzahl der Mitglieder des Minderheitengeschlechts, die in einem Gremium erforderlich sind.
   *
   * @param male Die Anzahl der männlichen Mitglieder.
   * @param female Die Anzahl der weiblichen Mitglieder.
   * @param gremium Die Gesamtanzahl der Mitglieder im Gremium.
   * @return Die Mindestanzahl der Mitglieder des Minderheitengeschlechts, die erforderlich sind.
   */
}
function MindestanzahlMinderheitengeschlecht(
  male, female, gremium: Integer): Integer;
var
  Minderheit: TGender;
  Minderheitenanteil, Gesamtzahl: Double;
begin
  Gesamtzahl := male + female;

  if Gesamtzahl = 0 then
  begin
    Result := 0;
    Exit;
  end;

  Minderheit := Minderheitengeschlecht(male, female);

  case Minderheit of
    gMale:
      Minderheitenanteil := male / Gesamtzahl;
    gFemale:
      Minderheitenanteil := female / Gesamtzahl ;
  else
    Minderheitenanteil := 0;
  end;

  // Anteil mal Betriebsratsgröße, dann aufrunden
  Result := Ceil(Minderheitenanteil * gremium);
end;


{
  /**
   * Berechnet die Größe des Betriebsrats basierend auf der Anzahl der Beschäftigten.
   *
   * @param AnzahlBeschaeftigte Die Anzahl der Beschäftigten im Unternehmen.
   * @return Die berechnete Größe des Betriebsrats als Integer-Wert.
   */
}
function BerechneBetriebsratsgroesse(AnzahlBeschaeftigte: Integer): Integer;
const
  // Array zur Berechnung der Betriebsratsgröße basierend auf der Anzahl der Beschäftigten.
  // Hinweis: Dieses Array hat einen Bereich von [0..17].
  FreistellungenTabelle : array[0..17] of TSitze =
  (
    (min:0;     max:4;      anz :0 ),
    (min:5;     max:20;     anz :1 ),
    (min:21;    max:50;     anz :3 ),
    (min:51;    max:100;    anz :5 ),
    (min:101;   max:200;    anz :7 ),
    (min:201;   max:400;    anz :9 ),
    (min:401;   max:700;    anz :11 ),
    (min:701;   max:1000;   anz :13 ),
    (min:1001;  max:1500;   anz :15 ),
    (min:1501;  max:2000;   anz :17 ),
    (min:2001;  max:2500;   anz :19 ),
    (min:2501;  max:3000;   anz :21 ),
    (min:3001;  max:3500;   anz :23 ),
    (min:3501;  max:4000;   anz :25 ),
    (min:4001;  max:5000;   anz :29 ),
    (min:5001;  max:6000;   anz :31 ),
    (min:6001;  max:7000;   anz :33 ),
    (min:7001;  max:9000;   anz :35 )
  );
var
  i : integer;
begin
  Result := -1;

  for i := low(FreistellungenTabelle) to High(FreistellungenTabelle) do
  begin
    if (AnzahlBeschaeftigte >= FreistellungenTabelle[i].min) and
       (AnzahlBeschaeftigte <= FreistellungenTabelle[i].max) then
     begin
      Result := FreistellungenTabelle[i].anz;
      break;
     end;
  end;
  
  if Result = -1 then
  begin
    Result := 35 + ((( AnzahlBeschaeftigte - 9000 ) div 3000) +1 ) * 2;
  end;

end;

{
  /**
   * Berechnet die Anzahl der Freistellungen basierend auf der Anzahl der Beschäftigten.
   *
   * @param AnzahlBeschaeftigte Die Anzahl der Beschäftigten, die als Grundlage für die Berechnung dient.
   * @return Die berechnete Anzahl der Freistellungen.
   */
}
function BerechneAnzahlFreistellungen(AnzahlBeschaeftigte: Integer): Integer;
const
  // Array zur Berechnung der Freistellungen basierend auf der Betriebsratsgröße.
  // Hinweis: Dieses Array hat einen Bereich von [0..12].
  FreistellungenTabelle : array[0..12] of TSitze =
  (
    (min:0;     max:199;    anz :0 ),
    (min:200;   max:500;    anz :1 ),
    (min:501;   max:900;    anz :2 ),
    (min:901;   max:1500;   anz :3 ),
    (min:1501;  max:2000;   anz :4 ),
    (min:2001;  max:3000;   anz :5 ),
    (min:3001;  max:4000;   anz :6 ),
    (min:4001;  max:5000;   anz :7 ),
    (min:5001;  max:6000;   anz :8 ),
    (min:6001;  max:7000;   anz :9 ),
    (min:7001;  max:8000;   anz :10 ),
    (min:8001;  max:9000;   anz :11 ),
    (min:9001;  max:10000;  anz :12 )
  );
var
  i : integer;
begin
  Result := -1;

  for i := low(FreistellungenTabelle) to High(FreistellungenTabelle) do
  begin
    if (AnzahlBeschaeftigte >= FreistellungenTabelle[i].min) and
       (AnzahlBeschaeftigte <= FreistellungenTabelle[i].max) then
     begin
      Result := FreistellungenTabelle[i].anz;
      break;
     end;
  end;

  if Result = -1 then
  begin
    Result := 12 + ((( AnzahlBeschaeftigte - 10000 ) div 2000) +1 );
  end;
end;

{
  Konvertiert einen TGender-Wert in seine entsprechende String-Darstellung.

  @param Gender Der TGender-Wert, der konvertiert werden soll.
  @return Eine String-Darstellung des angegebenen TGender-Werts.
}
function GenderToString(Gender: TGender): string;
begin
  case Gender of
    gUnknown: Result := 'Unknown';
    gMale: Result := 'Male';
    gFemale: Result := 'Female';
    gDiverse: Result := 'Diverse';
  else
    Result := 'Invalid';
  end;
end;

{
  Konvertiert eine String-Darstellung eines Geschlechts in einen TGender-Enumerationswert.

  @param GenderStr Die String-Darstellung des Geschlechts. Erwartete Werte sollten den
                   vordefinierten Geschlechts-Strings der Anwendung entsprechen.
  @return          Der entsprechende TGender-Enumerationswert.
  @raises          Exception, wenn der Eingabestring keinem gültigen Geschlecht entspricht.
}
function StringToGender(const GenderStr: string): TGender;
begin
  if SameText(GenderStr, 'Unknown') then
    Result := gUnknown
  else if SameText(GenderStr, 'Male') then
    Result := gMale
  else if SameText(GenderStr, 'Female') then
    Result := gFemale
  else if SameText(GenderStr, 'Diverse') then
    Result := gDiverse
  else
    raise Exception.CreateFmt('Invalid gender string: %s', [GenderStr]);
end;

end.
