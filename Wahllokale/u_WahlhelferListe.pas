﻿{
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
unit u_WahlhelferListe;

interface

uses
  SysUtils, Classes, Generics.Collections, u_Wahlhelfer, System.JSON;

type
  TWahlhelferListe = class(TObject)
  private
    FWahlhelferList: TObjectList<TWahlhelfer>;

    function GetWahlhelfer(Index: Integer): TWahlhelfer;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddWahlhelfer(AWahlhelfer: TWahlhelfer);
    function RemoveWahlhelfer(AWahlhelfer: TWahlhelfer): Boolean;

    property Items[Index: Integer]: TWahlhelfer read GetWahlhelfer; default;
    property Count: Integer read GetCount;

    function toJSON : TJSONObject;
    procedure fromJSON( data : TJSONObject );
  end;

implementation

uses u_json;

constructor TWahlhelferListe.Create;
begin
  inherited Create;
  FWahlhelferList := TObjectList<TWahlhelfer>.Create(True); // True bedeutet, dass die Liste die Objekte freigibt
end;

destructor TWahlhelferListe.Destroy;
begin
  FWahlhelferList.Free;
  inherited Destroy;
end;

procedure TWahlhelferListe.fromJSON(data: TJSONObject);
var
  i : integer;
  arr : TJSONArray;
  row : TJSONObject;
  helfer : TWahlhelfer;
begin
  if not Assigned(data) then
    exit;

  arr := JArray( data, 'helfer');
  if not Assigned(arr) then
    exit;

  for i := 0 to pred( arr.Count) do
  begin
    row := getRow( arr, i);

    helfer := TWahlhelfer.Create;
    helfer.fromJSON(row);
    AddWahlhelfer(helfer);

  end;
end;

procedure TWahlhelferListe.AddWahlhelfer(AWahlhelfer: TWahlhelfer);
begin
  FWahlhelferList.Add(AWahlhelfer);
end;

function TWahlhelferListe.GetWahlhelfer(Index: Integer): TWahlhelfer;
begin
  Result := FWahlhelferList[Index];
end;

function TWahlhelferListe.GetCount: Integer;
begin
  Result := FWahlhelferList.Count;
end;

function TWahlhelferListe.RemoveWahlhelfer(AWahlhelfer: TWahlhelfer): Boolean;
begin
  Result := FWahlhelferList.Remove(AWahlhelfer) <> -1;
end;

function TWahlhelferListe.toJSON: TJSONObject;
var
  arr : TJSONArray;
  helfer : TWahlhelfer;
begin
  Result := TJSONObject.Create;
  arr := TJSONArray.Create;

  for helfer in FWahlhelferList do
  begin
    arr.AddElement(helfer.toJSON);
  end;
  JReplace(Result, 'helfer', arr);
end;

end.
