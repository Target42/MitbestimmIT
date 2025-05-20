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
unit u_wahllokal;

interface

uses
  System.JSON, u_json, System.Generics.Collections;

type
  TWahlLokal = class
    private
      FBuilding: string;
      FRaum: string;
      FStockwerk: string;
      FVon: TDateTime;
      FBis: TDateTime;
    public
      const
        WLBUILDING = 'gebaeude';
        WLROOM     = 'raum';
        WLSTOCKWERK= 'stockwerk';
        WLVON      = 'von';
        WLBIS      = 'bis';
    public
      constructor create;
      Destructor Destroy; override;

      property Building: string read FBuilding write FBuilding;
      property Raum: string read FRaum write FRaum;
      property Stockwerk: string read FStockwerk write FStockwerk;
      property Von: TDateTime read FVon write FVon;
      property Bis: TDateTime read FBis write FBis;

      function toJSON : TJSONObject;
      procedure fromJSON( data : TJSONObject );
  end;

  TWahlLokalListe = class
    private
      m_items : TList<TWahlLokal>;
    public
      const
        WLLItems = 'items';
    public
      constructor create;
      Destructor Destroy; override;

      property Items : TList<TWahlLokal> read m_items;

      procedure add( value : TWahlLokal ); overload;
      function add : TWahlLokal; overload;
      function add( data : TJSONObject) : TWahlLokal; overload;

      procedure remove( value : TWahlLokal );

      procedure clear;

      function toJSON : TJSONObject;
      procedure fromJSON( data : TJSONObject );


      function clone : TWahlLokalListe;
      procedure assign( liste : TWahlLokalListe);

  end;

implementation

uses
  System.SysUtils;

{ TWahlLokal }

constructor TWahlLokal.create;
begin

end;

destructor TWahlLokal.Destroy;
begin

  inherited;
end;

procedure TWahlLokal.fromJSON(data: TJSONObject);
var
  fmt : TFormatSettings;
begin
  fmt := TFormatSettings.Create('de-DE');

  FBuilding  := JString(data, WLBUILDING);
  FRaum      := JString(data, WLROOM);
  FStockwerk := JString(data, WLSTOCKWERK);
  FVon       := StrToDateTime( JString( data, WLVON), fmt);
  FBis       := StrToDateTime( JString( data, WLBIS), fmt);

end;

function TWahlLokal.toJSON: TJSONObject;
var
  fmt : TFormatSettings;
begin
  fmt := TFormatSettings.Create('de-DE');

  Result := TJSONObject.Create;
  JReplace( Result, WLBUILDING, FBuilding);
  JReplace( Result, WLROOM, FRaum);
  JReplace( Result, WLSTOCKWERK, FStockwerk);
  JReplace(Result, WLVON, DateTimeToStr(FVon, fmt));
  JReplace(Result, WLBIS, DateTimeToStr(FBis, fmt));
end;

{ TWahlLokalListe }

procedure TWahlLokalListe.add(value: TWahlLokal);
begin
  if m_items.IndexOf(value) = -1 then
    m_items.Add(value);
end;

function TWahlLokalListe.add: TWahlLokal;
begin
  Result := TWahlLokal.create;
  m_items.Add(Result);
end;

function TWahlLokalListe.add(data: TJSONObject): TWahlLokal;
begin
  Result := add;
  Result.fromJSON(data);
end;

procedure TWahlLokalListe.assign(liste: TWahlLokalListe);
var
  data  : TJSONObject;
  i     : integer;
begin
  liste.clear;
  for i := 0 to pred(liste.Items.Count) do
  begin
    data := liste.Items[i].toJSON;
    add( data );
    data.Free;
  end;
end;

procedure TWahlLokalListe.clear;
var
  i : integer;
begin
  for i := 0 to pred(m_items.Count) do
    m_items[i].Free;
  m_items.Clear;
end;

function TWahlLokalListe.clone: TWahlLokalListe;
var
  lokal : TWahlLokal;
  data  : TJSONObject;
  i     : integer;
begin
  Result := TWahlLokalListe.create;

  for i := 0 to pred(m_items.Count) do
  begin
    data := m_items[i].toJSON;
    lokal := Result.add;
    lokal.fromJSON(data);
    data.Free;
  end;
end;

constructor TWahlLokalListe.create;
begin
  m_items := TList<TWahlLokal>.Create;
end;

destructor TWahlLokalListe.Destroy;
begin
  clear;
  m_items.Free;

  inherited;
end;

procedure TWahlLokalListe.fromJSON(data: TJSONObject);
var
  arr : TJSONArray;
  i   : integer;
  row : TJSONObject;
  lokal : TWahlLokal;
begin
  arr := JArray(data, WLLItems);
  if not Assigned(arr) then
    exit;

  for i := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    lokal := add;
    lokal.fromJSON(row);
  end;

end;

procedure TWahlLokalListe.remove(value: TWahlLokal);
begin
  m_items.Remove(value);
  value.Free;
end;

function TWahlLokalListe.toJSON: TJSONObject;
var
 arr : TJSONArray;
 lokal : TWahlLokal;
begin
  Result := TJSONObject.Create;
  arr := TJSONArray.Create;

  for lokal in m_items do
    arr.AddElement(lokal.toJSON);

  JReplace(Result, WLLItems, arr);
end;

end.
