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

unit u_Waehlerliste;

interface

uses
  System.JSON, System.Generics.Collections, i_waehlerliste;

type
  TWaehler = class( TInterfacedObject, IWaehler)
    public
      const
        WPersNr = 'persnr';
        WName   = 'name';
        WVorname= 'vorname';
        WAnrede = 'anrede';
        Wabteilung = 'abteilung';

    private
      FPersNr: String;
      FName: string;
      FVorname: string;
      FAnrede: string;
      FAbteilung: string;

      function getPersNr : string;
      procedure setPersNr( value : string );
      function getName : string;
      procedure setName( value : string );
      function getVorname : string;
      procedure setVorname( value : string );
      function getAnrede : string;
      procedure setAnrede( value : string );
      function getAbteilung : string;
      procedure setAbteilung( value : string );
    public
      constructor create;
      Destructor Destroy; override;

      procedure fromJSON( data : TJSONObject ); overload;
      procedure fromJSON( arr : TJSONArray ); overload;

      function toJSON : TJSONObject;
      function toSimpleJSON : TJSONArray;

      function compare( value : IWaehler ) : Boolean;

      function clone : IWaehler;
      procedure Assign( value : IWaehler );

      procedure release;

  end;

  TWaehlerListe = class( TInterfacedObject, IWaehlerListe)
    private
      const
        WLItems   = 'items';
        WLCOLUMNS = 'columns';
        WLROWS    = 'rows';
    private
      m_items : TList<IWaehler>;
      m_index : TDictionary<string, IWaehler>;
      procedure fromSimpleJSON( data : TJSONObject );
      procedure fromFullJSON( data : TJSONObject );

      function getitems: TList<IWaehler>;
    public
      constructor create;
      Destructor Destroy; override;


      function new : IWaehler;
      function add( data : TJSONObject) : IWaehler; overload;
      function add( arr : TJSONArray) : IWaehler; overload;
      procedure add( waehler : IWaehler); overload;

      function getWaehler( prsnr : string ) : IWaehler;
      function hasWaehler( prsnr : string ) : boolean;

      procedure fromJSON( data : TJSONObject );   overload;
      function loadFromFile( filename : string ) : boolean;

      function toJSON : TJSONObject;
      function toSimpleJSON : TJSONObject;
      function saveToFile( fname : string ) : Boolean;

      procedure Assign( src : IWaehlerListe );
      procedure clear;

      procedure delete( persnr : string );

      procedure release;

  end;

implementation

{ TWaehler }

uses u_json, System.SysUtils;

procedure TWaehler.Assign(value: IWaehler);
begin
  FPersNr     := value.PersNr;
  FName       := value.Name;
  FVorname    := value.Vorname;
  FAnrede     := value.Anrede;
  FAbteilung  := value.Abteilung;
end;

function TWaehler.clone: IWaehler;
begin
  Result := TWaehler.create;

  Result.PersNr := FPersNr;
  Result.Name   := FName;
  Result.Vorname:= FVorname;
  Result.Anrede := FAnrede;
  Result.Abteilung:= FAbteilung;

end;

function TWaehler.compare(value: IWaehler): Boolean;
begin
  Result := SameText( FPersNr, value.PersNr );
  Result := Result and SameText( FName, value.Name );
  Result := Result and SameText( FVorname, value.Vorname );
  Result := Result and SameText( FAnrede, value.Anrede );
  Result := Result and SameText( FAbteilung, value.Abteilung );
end;

constructor TWaehler.create;
begin

end;

destructor TWaehler.Destroy;
begin

  inherited;
end;

procedure TWaehler.fromJSON(arr: TJSONArray);
var
  anz : Integer;
begin
  if not Assigned(arr) then
    exit;
  anz := arr.Count;
  if anz >= 1 then FPersNr     := arr.Items[0].Value;
  if anz >= 2 then FName       := arr.Items[1].Value;
  if anz >= 3 then FVorname    := arr.Items[2].Value;
  if anz >= 4 then FAnrede     := arr.Items[3].Value;
  if anz >= 5 then FAbteilung  := arr.Items[4].Value;
end;


function TWaehler.getAbteilung: string;
begin
  Result := FAbteilung;
end;

function TWaehler.getAnrede: string;
begin
  Result := FAnrede;
end;

function TWaehler.getName: string;
begin
  Result := FName;
end;

function TWaehler.getPersNr: string;
begin
  Result := FPersNr;
end;

function TWaehler.getVorname: string;
begin
  Result := FVorname;
end;

procedure TWaehler.release;
begin

end;

procedure TWaehler.setAbteilung(value: string);
begin
  FAbteilung := value;
end;

procedure TWaehler.setAnrede(value: string);
begin
  FAnrede := value;;
end;

procedure TWaehler.setName(value: string);
begin
  FName  := value;
end;

procedure TWaehler.setPersNr(value: string);
begin
  FPersNr := value;
end;

procedure TWaehler.setVorname(value: string);
begin
  FVorname := value;
end;

procedure TWaehler.fromJSON(data: TJSONObject);
begin
  FPersNr := JString( data, WPersNr);
  FName   := JString( data, WName);
  FVorname:= JString( data, WVorname);
  FAnrede := JString( data, WAnrede);
  FAbteilung:= JString( data, Wabteilung);
end;


function TWaehler.toJSON: TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace( Result, WPersNr,  FPersNr);
  JReplace( Result, WName ,   FName);
  JReplace( Result, WVorname, FVorname);
  JReplace( Result, WAnrede,  FAnrede);
  JReplace( Result, Wabteilung, FAbteilung);
end;

function TWaehler.toSimpleJSON: TJSONArray;
begin
  Result := TJSONArray.Create;
  Result.Add(FPersNr);
  Result.Add(FName);
  Result.Add(FVorname);
  Result.Add(FAnrede);
  Result.Add(FAbteilung);
end;

{ TWaehlerListe }

function TWaehlerListe.add(data: TJSONObject): IWaehler;
begin
  Result := self.new;
  Result.fromJSON(data);
  add(Result);
end;

procedure TWaehlerListe.add(waehler: IWaehler);
begin
  if m_items.IndexOf(waehler) = -1 then
    m_items.Add(waehler);
  m_index.AddOrSetValue(waehler.PersNr, waehler)
end;

function TWaehlerListe.add(arr: TJSONArray): IWaehler;
begin
  Result := self.new;
  Result.fromJSON(arr);
  add(Result);
end;

procedure TWaehlerListe.Assign(src: IWaehlerListe);
var
  w : IWaehler;
begin
  clear;
  for w in src.Items do
    self.add(w.clone)
end;

procedure TWaehlerListe.clear;
var
  waehler : IWaehler;
begin
  for waehler in m_items do
    waehler.release;
  m_items.Clear;
  m_index.Clear;
end;

constructor TWaehlerListe.create;
begin
  m_items := TList<IWaehler>.Create;
  m_index := TDictionary<string, IWaehler>.Create;
end;

procedure TWaehlerListe.delete(persnr: string);
var
  w : IWaehler;
begin
  if m_index.TryGetValue(persnr, w) then
  begin
    m_index.Remove(persnr);
    m_items.Remove(w);
    w.release;
  end;

end;

destructor TWaehlerListe.Destroy;
var
  waehler : IWaehler;
begin
  for waehler in m_items do
    waehler.release;

  m_items.Free;
  m_index.Free;

  inherited;
end;

procedure TWaehlerListe.fromFullJSON(data: TJSONObject);
var
  iter : TArrayIterator;
begin
  iter := TArrayIterator.Create(JArray(data, WLItems));
  while iter.Next do
  begin
    add(iter.CurrentItem);
  end;
  iter.Free;
end;

procedure TWaehlerListe.fromJSON(data: TJSONObject);
begin
  if JExistsKey( data, 'rows') then
    fromSimpleJSON(data)
  else
    fromFullJSON(data);
end;

procedure TWaehlerListe.fromSimpleJSON(data: TJSONObject);
var
  arr : TJSONArray;
  sub : TJSONArray;
  i   : integer;
begin

  arr := JArray(data, WLROWS);
  if Assigned(arr) then
  begin
    for i := 0 to pred(arr.Count) do
    begin
      sub := arr.Items[i] as TJSONArray;
      add(sub);
    end;
  end;
end;

function TWaehlerListe.getitems: TList<IWaehler>;
begin
  Result := m_items;
end;

function TWaehlerListe.getWaehler(prsnr: string): IWaehler;
begin
  Result := NIL;

  m_index.TryGetValue(prsnr, Result);
end;

function TWaehlerListe.hasWaehler(prsnr: string): boolean;
begin
  Result := Assigned(getWaehler(prsnr));
end;

function TWaehlerListe.loadFromFile(filename: string) : boolean;
var
  data : TJSONObject;
begin
  Result := false;
  if not FileExists(filename) then
    exit;
  data := loadJSON(filename);
  fromJSON(data);

  Result := Assigned(data);

  if Result then
    data.Free;

end;

function TWaehlerListe.new: IWaehler;
begin
  Result := TWaehler.create;
end;

procedure TWaehlerListe.release;
var
  w : IWaehler;
begin
  for w in m_items do
    w.release;
  m_items.Clear;
  m_index.Clear;

end;

function TWaehlerListe.saveToFile(fname: string): Boolean;
var
  data : TJSONObject;
begin
  data := self.toSimpleJSON;
  Result := saveJSON(data, fname);
  data.Free;
end;

function TWaehlerListe.toJSON: TJSONObject;
var
  Arr : TJSONArray;
  waehler : IWaehler;
begin
  Result := TJSONObject.Create;
  Arr := TJSONArray.Create;

  for waehler in m_items do
    arr.AddElement(waehler.toJSON);
  JReplace( Result, WLItems, arr);
end;


function TWaehlerListe.toSimpleJSON: TJSONObject;
  function createNames: TJSONArray;
  begin
    Result := TJSONArray.Create;
    Result.Add(TWaehler.WPersNr);
    Result.Add(TWaehler.WName);
    Result.Add(TWaehler.WVorname);
    Result.Add(TWaehler.WAnrede);
    Result.Add(TWaehler.Wabteilung);
  end;
var
  rows : TJSONArray;
  waehler : IWaehler;
begin
  Result := TJSONObject.Create;
  JReplace( Result, WLCOLUMNS, createNames);

  rows := TJSONArray.Create;
  for waehler in m_items do
    rows.Add(waehler.toSimpleJSON);

  JReplace( Result, WLROWS, rows);
end;

end.


