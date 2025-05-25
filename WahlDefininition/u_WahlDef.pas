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

unit u_WahlDef;

interface

uses
  u_BRWahlFristen, System.JSON;

type
  TWahlDef = class

    private
    const
        wdWahlKurz = 'kurz';
        wdWahlLang = 'name';
        wdAdminPassword = 'passwort';

        wdTermine = 'termine';
    var
      FWahlKurzName: string;
      FWahlName: string;
      FAdminPasswort: string;
    public
      WahlFristen : TWahlFristen;

      constructor create;
      Destructor Destroy; override;

      property WahlKurzName: string read FWahlKurzName write FWahlKurzName;
      property WahlName: string read FWahlName write FWahlName;
      property AdminPasswort: string read FAdminPasswort write FAdminPasswort;

      procedure fromJSON( data : TJSONObject );
      function toJSON : TJSONObject;

  end;

implementation

{ TWahlDef }

uses u_json;

constructor TWahlDef.create;
begin

end;

destructor TWahlDef.Destroy;
begin

  inherited;
end;

procedure TWahlDef.fromJSON(data: TJSONObject);
begin
  if not Assigned(data) then
    exit;

  FWahlKurzName := JString( data, wdWahlKurz);
  FWahlName     := JString( data, wdWahlLang);
  FAdminPasswort:= JString( data, wdAdminPassword);

  WahlFristen.fromJSON(JObject( data, wdTermine));
end;

function TWahlDef.toJSON: TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace( Result, wdWahlKurz,       FWahlKurzName);
  JReplace( Result, wdWahlLang,       FWahlName);
  JReplace( Result, wdAdminPassword,  FAdminPasswort);

  JReplace( Result, wdTermine, WahlFristen.toJSON);
end;

end.
