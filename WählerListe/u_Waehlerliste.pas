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
  System.JSON, System.Generics.Collections;

type
  TWaehler = class
    private
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
    public
      constructor create;
      Destructor Destroy; override;

      property PersNr: String read FPersNr write FPersNr;
      property Name: string read FName write FName;
      property Vorname: string read FVorname write FVorname;
      property Anrede: string read FAnrede write FAnrede;
      property Abteilung: string read FAbteilung write FAbteilung;


      procedure fromJSON( data : TJSONObject );
      function toJSON : TJSONObject;
  end;

  TWaehlerListe = class
    private
      const
        WLItems = 'items';
    private
      m_items : TList<TWaehler>;
    public
      constructor create;
      Destructor Destroy; override;

      function add : TWaehler; overload;
      function add( data : TJSONObject) : TWaehler; overload;

      procedure fromJSON( data : TJSONObject );
      function toJSON : TJSONObject;
  end;

implementation

{ TWaehler }

uses u_json;

constructor TWaehler.create;
begin

end;

destructor TWaehler.Destroy;
begin

  inherited;
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

{ TWaehlerListe }

function TWaehlerListe.add(data: TJSONObject): TWaehler;
begin
  Result := self.add;
  Result.fromJSON(data);
end;

function TWaehlerListe.add: TWaehler;
begin
  Result := TWaehler.create;
  m_items.Add(Result);
end;

constructor TWaehlerListe.create;
begin
  m_items := TList<TWaehler>.Create;
end;

destructor TWaehlerListe.Destroy;
var
  waehler : TWaehler;
begin
  for waehler in m_items do
    waehler.Free;

  m_items.Free;
  inherited;
end;

procedure TWaehlerListe.fromJSON(data: TJSONObject);
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

function TWaehlerListe.toJSON: TJSONObject;
var
  Arr : TJSONArray;
  waehler : TWaehler;
begin
  Result := TJSONObject.Create;
  Arr := TJSONArray.Create;

  for waehler in m_items do
    arr.AddElement(waehler.toJSON);
  JReplace( Result, WLItems, arr);
end;

end.
