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
  SysUtils, DateUtils, System.JSON, System.Generics.Collections;

type
  TWahlVerfahren = (wvAllgemein = 0, wvVereinfacht = 1);
  TDatumTyp      = (dtKeines = 0, dtTag = 1, dtZeitraum = 2, dtZeitpunkte = 3);

  PTWahlPhase   = ^TWahlPhase;
  TWahlPhase    = record
    nr        : integer;
    titel     : string;
    start     : TDateTime;
    ende      : TDateTime;
    typ       : TDatumTyp;

    function toJson : TJSONObject;
    procedure fromJson( data : TJSONObject );
  end;

  TWahlPhasenListe = TList<PTWahlPhase>;
  PTWahlPhasenListe = ^TWahlPhasenListe;


  TRegelwahlStatus = record
    InWahlperiode: Boolean;
    Jahr: Word;
    Start: TDate;
    Ende: TDate;
  end;

function PruefeRegulaereWahlperiode(Heute: TDate): TRegelwahlStatus;


function getWahlPhasen( verfahren : TWahlVerfahren ): TWahlPhasenListe;
procedure releaseWahlPhasen( list : TWahlPhasenListe );

procedure AutoFillNormal( da : TDate; var list : TWahlPhasenListe );
procedure AutoFillEinfach( da : TDate; var list : TWahlPhasenListe );

function WahlphasenToJson( var list : TWahlPhasenListe ) : TJSONObject;
procedure JsonToWahlPhase( var list : TWahlPhasenListe; data: TJSONObject );

implementation


uses
  u_json;

function TWahlPhase.toJson : TJSONObject;
begin
  Result := TJSONObject.Create;
  JReplace(result, 'nr', nr);
  JReplace(result, 'titel',titel);
  JReplaceDouble(result, 'start',start);
  JReplaceDouble(result, 'ende',ende);
  JReplace( result, 'typ', integer(typ));

end;
procedure TWahlPhase.fromJson( data : TJSONObject );
begin
  nr := JInt( data, 'nr');
  titel := JString( data, 'titel');
  start := JDouble(data, 'start');
  ende  := JDouble( data, 'ende');
  typ   := TDatumTyp(JInt( data, 'typ'));
end;

function WahlphasenToJson( var list : TWahlPhasenListe ) : TJSONObject;
var
  i : integer;
  arr : TJSONArray;
begin
  Result := TJSONObject.Create;
  arr := TJSONArray.Create;
  for i := 0 to pred(list.Count) do
  begin
    arr.Add(list[i]^.toJson);
  end;
  JReplace( result, 'phasen', arr);
end;

procedure JsonToWahlPhase( var list : TWahlPhasenListe; data: TJSONObject );
var
  arr : TJSONArray;
  row : TJSONObject;
  i   : integer;
  ptr : PTWahlPhase;
begin
  arr := JArray( data, 'phasen');
  if not Assigned(arr) then
    exit;


  if arr.Count > 0 then
    releaseWahlPhasen(list);


  for i := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    new(ptr);
    list.Add(ptr);
    ptr^.fromJson(row);
  end;
end;

procedure AutoFillEinfach( da : TDate; var list : TWahlPhasenListe );
begin
  // Ende der Anfechtungsfrist'                    , dtZeitraum
  list[7]^.ende  := IncWeek( da, 2);
  list[7]^.start := da;
  // Bekanntgabe des Wahlergebnisses'              , dtTag
  list[6]^.start  := da;
  // Stimmauszählung'                              , dtTag
  list[5]^.start  := da;
  // Wahlversammlung (eigentliche Wahl)'           , dtZeitpunkte
  list[4]^.start := da + EncodeTime(8, 0, 0, 0);
  list[4]^.ende  := da + EncodeTime(12, 0, 0, 0);
  // Einreichungsfrist für Wahlvorschläge'         , dtZeitraum
  list[3]^.ende  := IncWeek( da, -1);
  list[3]^.start := IncWeek( da, -2 );
  // Wahlversammlung'                              , dtZeitpunkte
  list[2]^.start  := incDay(list[3]^.start,   -1) + EncodeTime(8, 0, 0, 0);;
  list[2]^.ende   := incDay(list[3]^.start,   -1) + EncodeTime(12, 0, 0, 0);;
  // Einladung zur 1. Wahlversammlung'             , dtTag
  list[1]^.start := IncWeek( list[2]^.start, -1 );
  // Bestellung oder Wahl des Wahlvorstands'       , dtTag
  list[0]^.start := IncWeek( list[1]^.start, -1 );


end;
procedure AutoFillNormal( da : TDate; var list : TWahlPhasenListe );
begin
  // Bestellung/Wahl des Wahlvorstands             , dtTag
  list[0]^.start := IncWeek(da, -10);
  // Erstellung der Wählerliste'                   , dtTag));
  list[1]^.start := IncWeek(list[0]^.start);
  // Erlass und Aushang des Wahlausschreibens'     , dtTag));
  list[2]^.start := IncWeek(da, -6);
  // Einspruchsfrist gegen Wählerliste'            , dtZeitraum));
  list[3]^.start := list[1]^.start;
  list[3]^.ende  := IncWeek(list[2]^.start, 2);
  // Einreichung der Wahlvorschläge'               , dtZeitraum));
  list[4]^.start := list[2]^.start;
  list[4]^.ende  := IncWeek(list[2]^.start, 2);
  // Prüfung und Zulassung der Wahlvorschläge'     , dtTag));
  list[5]^.start := incDay(list[4]^.ende);

  // Vorbereitung der Wahl'                        , dtZeitraum));
  list[6]^.start := IncDay(List[5]^.start, 1);
  list[6]^.Ende  := IncDay(da, -7);

  // Stimmabgabe (Wahltag/e)'                      , dtZeitpunkte));
  list[7]^.start := da  + EncodeTime( 8, 0, 0, 0);
  list[7]^.Ende:= da  + EncodeTime( 16, 0, 0, 0);
  // Stimmauszählung'                              , dtTag));
  list[8]^.start := da;
  // Bekanntgabe des Wahlergebnisses'              , dtTag));
  list[9]^.start := da;

  // Ende der Anfechtungsfrist'                    , dtZeitraum));
  list[10]^.start := da;
  list[10]^.ende  := IncDay(da, 14);
end;

procedure releaseWahlPhasen( list : TWahlPhasenListe );
var
  i : integer;
begin
  if not Assigned(list) then
    exit;
  for i := 0 to pred(list.Count) do
  begin
    Dispose(list[i]);
  end;
  list.Clear;
  list.Free;
end;

function FillPhase( nr : integer; title : string; typ : TDatumTyp) :  PTWahlPhase;
begin
  new(result);
  Result^.nr        := nr;
  Result^.titel     := title;
  Result^.typ       := typ;
  Result^.start     := 0.0;
  Result^.ende      := 0.0;
end;

function createNornmal : TWahlPhasenListe;
var
  fmt : TFormatSettings;
begin
  fmt := TFormatSettings.Create('de-DE');

  Result := TList<PTWahlPhase>.create();
  Result.add(FillPhase( 1, 'Bestellung/Wahl des Wahlvorstands'            , dtTag));
  Result.add(FillPhase( 2, 'Erstellung der Wählerliste'                   , dtTag));
  Result.add(FillPhase( 3, 'Erlass und Aushang des Wahlausschreibens'     , dtTag));
  Result.add(FillPhase( 4, 'Einspruchsfrist gegen Wählerliste'            , dtZeitraum));
  Result.add(FillPhase( 5, 'Einreichung der Wahlvorschläge'               , dtZeitraum));
  Result.add(FillPhase( 6, 'Prüfung und Zulassung der Wahlvorschläge'     , dtTag));
  Result.add(FillPhase( 7, 'Vorbereitung der Wahl'                        , dtZeitraum));
  Result.add(FillPhase( 8, 'Stimmabgabe (Wahltag/e)'                      , dtZeitpunkte));
  Result.add(FillPhase( 9, 'Stimmauszählung'                              , dtTag));
  Result.add(FillPhase(10, 'Bekanntgabe des Wahlergebnisses'              , dtTag));
  Result.add(FillPhase(11, 'Ende der Anfechtungsfrist'                    , dtZeitraum));

  AutoFillNormal( EncodeDate(2026, 5, 15), Result );
end;

function createEinfach : TWahlPhasenListe;
begin
  Result := TList<PTWahlPhase>.create();
  Result.add(FillPhase( 1, 'Bestellung oder Wahl des Wahlvorstands'       , dtTag));
  Result.add(FillPhase( 2, 'Einladung zur 1. Wahlversammlung'             , dtTag));
  Result.add(FillPhase( 3, 'Wahlversammlung'                              , dtZeitpunkte));
  Result.add(FillPhase( 4, 'Einreichungsfrist für Wahlvorschläge'         , dtZeitraum));
  Result.add(FillPhase( 5, 'Wahlversammlung (eigentliche Wahl)'           , dtZeitpunkte));
  Result.add(FillPhase( 6, 'Stimmauszählung'                              , dtTag));
  Result.add(FillPhase( 7, 'Bekanntgabe des Wahlergebnisses'              , dtTag));
  Result.add(FillPhase( 8, 'Ende der Anfechtungsfrist'                    , dtZeitraum));

  AutoFillEinfach(EncodeDate(2026, 5, 15), Result );
end;

function getWahlPhasen( verfahren : TWahlVerfahren ): TWahlPhasenListe;
begin
  Result := nil;
  case verfahren of
    wvAllgemein:   Result := createNornmal;
    wvVereinfacht: Result := createEinfach;
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


