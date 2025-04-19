{
  This unit provides functions for calculating various aspects of Betriebsrat (works council) composition
  and requirements based on the number of employees and gender distribution.

  Types:
    - TGender: Enumeration representing gender (gUnknown, gMale, gFemale, gDiverse).

  Functions:
    - Minderheitengeschlecht(AnzahlMaenner, AnzahlFrauen: Integer): TGender
        Determines the minority gender based on the number of men and women.
        Returns gUnknown if the numbers are equal, gMale if men are the minority,
        and gFemale if women are the minority.

    - MindestanzahlMinderheitengeschlecht(AnzahlMaenner, AnzahlFrauen, Betriebsratsgroesse: Integer): Integer
        Calculates the minimum number of representatives required for the minority gender
        in the works council based on the total number of men, women, and the council size.
        Uses the minority gender proportion and rounds up to the nearest integer.

    - BerechneBetriebsratsgroesse(AnzahlBeschaeftigte: Integer): Integer
        Computes the size of the works council based on the number of employees.
        Returns 0 if no council is required, or the appropriate size based on predefined thresholds.

    - BerechneAnzahlFreistellungen(Betriebsratsgroesse: Integer): Integer
        Determines the number of required full-time releases (freistellungen) for works council members
        based on the size of the council. Returns 0 if no releases are required, or the appropriate
        number based on predefined thresholds.
}
unit u_BER_Berechnungen;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TGender = (gUnknown, gMale, gFemale, gDiverse);


{
  /**
   * Determines the minority gender based on the number of men and women.
   *
   * @param male The number of men.
   * @param femal The number of women.
   * @return TGender The minority gender:
   *         - gUnknown if the numbers are equal.
   *         - gMale if the number of men is less than the number of women.
   *         - gFemale if the number of women is less than the number of men.
   */
}
function Minderheitengeschlecht(male, female: Integer): TGender;
{
  This function calculates the minimum number of representatives of the minority gender
  required in a works council based on the given number of men, women, and the total
  size of the works council.

  @param male The number of men in the group.
  @param female The number of women in the group.
  @param gremium The total size of the works council.
  @return The minimum number of representatives of the minority gender required.
}
function MindestanzahlMinderheitengeschlecht(
  male, female, gremium: Integer): Integer;
{
  /**
   * Berechnet die Größe des Betriebsrats basierend auf der Anzahl der Beschäftigten.
   *
   * @param AnzahlBeschaeftigte Die Anzahl der Beschäftigten im Unternehmen.
   * @return Die Anzahl der Mitglieder im Betriebsrat. Gibt 0 zurück, wenn kein Betriebsrat erforderlich ist.
   *
   * Die Berechnung erfolgt nach den folgenden Regeln:
   * - Bis 5 Beschäftigte: Kein Betriebsrat erforderlich (0 Mitglieder).
   * - 6 bis 20 Beschäftigte: 1 Mitglied.
   * - 21 bis 50 Beschäftigte: 3 Mitglieder.
   * - 51 bis 100 Beschäftigte: 5 Mitglieder.
   * - 101 bis 200 Beschäftigte: 7 Mitglieder.
   * - 201 bis 400 Beschäftigte: 9 Mitglieder.
   * - 401 bis 700 Beschäftigte: 11 Mitglieder.
   * - 701 bis 1000 Beschäftigte: 13 Mitglieder.
   * - Über 1000 Beschäftigte: 15 Mitglieder plus 2 zusätzliche Mitglieder für jede weiteren 500 Beschäftigten.
   */
}
function BerechneBetriebsratsgroesse(AnzahlBeschaeftigte: Integer): Integer;
{
  This function calculates the number of exemptions (Freistellungen) required
  based on the size of the works council (Betriebsratsgroesse).

  @param AnzahlBeschaeftigte Integer - The size of the company.
  @return Integer - The number of exemptions required.

  The calculation is based on the following rules:
  - If the size is 7 or less, no exemptions are required.
  - If the size is between 8 and 15, 1 exemption is required.
  - If the size is between 16 and 31, 2 exemptions are required.
  - If the size is between 32 and 51, 3 exemptions are required.
  - If the size is between 52 and 71, 4 exemptions are required.
  - For sizes greater than 71, 5 exemptions are required plus an additional
    exemption for every 20 members above 71.
}
function BerechneAnzahlFreistellungen(AnzahlBeschaeftigte: Integer): Integer;

function GenderToString(Gender: TGender): string;
function StringToGender(const GenderStr: string): TGender;


implementation

uses
  Math;

type
  TSitze = record
    min, max, anz: Integer;
  end;

function Minderheitengeschlecht(male, female: Integer): TGender;
begin
  if (male = female) then
    Result := gUnknown
  else if (male < female) then
    Result := gMale
  else
    Result := gFemale;
end;

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
      Minderheitenanteil := female / Gesamtzahl;
  else
    Minderheitenanteil := 0;
  end;

  // Anteil mal Betriebsratsgröße, dann aufrunden
  Result := Ceil(Minderheitenanteil * gremium);
end;


function BerechneBetriebsratsgroesse(AnzahlBeschaeftigte: Integer): Integer;
const
  // Array for calculating Betriebsratsgroesse based on AnzahlBeschaeftigte.
  // Note: This array has a range of [0..17].
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

function BerechneAnzahlFreistellungen(AnzahlBeschaeftigte: Integer): Integer;
const
  // Array for calculating exemptions (Freistellungen) based on Betriebsratsgroesse.
  // Note: This array has a range of [0..12].
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
