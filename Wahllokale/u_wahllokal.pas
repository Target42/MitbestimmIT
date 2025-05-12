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
  System.JSON, u_json;

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

end.
