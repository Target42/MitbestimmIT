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

unit u_StorageWahlDefinition;

interface

uses
  i_Storage, u_WahlDef;

type
  TStorageWahlDefinition = class( TInterfacedObject, IStorageWahlDefinition)
  private
    Fhome : string;
    m_def : TWahlDef;

    procedure setHome(const Value: string);
  public
    constructor Create;
    Destructor Destroy; override;

    property home: string read Fhome write setHome;

    function getData : TWahlDef;
    function saveData( value : TWahlDef ) : boolean;

    procedure release;

  end;

implementation

uses
  system.IOUtils, System.SysUtils, u_json, System.JSON;

{ TStorageWahlDefinition }

constructor TStorageWahlDefinition.Create;
begin
  m_def := TWahlDef.create;
end;

destructor TStorageWahlDefinition.Destroy;
begin
  if Assigned( m_def) then
    m_def.Free;

  inherited;
end;

function TStorageWahlDefinition.getData: TWahlDef;
var
  fname : string;
  data  : TJSONObject;
begin
  Result := m_def;
  fname := TPath.Combine(Fhome, 'info.json');
  if fileExists( fname ) then
  begin
    data := loadJSON(fname);
    Result.fromJSON(data);
    data.Free;
  end;
end;

procedure TStorageWahlDefinition.release;
begin
  FreeAndNil(m_def);
end;

function TStorageWahlDefinition.saveData(value: TWahlDef): boolean;
var
  fname : string;
  data  : TJSONObject;
begin
  fname := TPath.Combine(Fhome, 'info.json');
  data  := value.toJSON;
  saveJSON(data, fname, true);
  data.Free;

  Result := true;
end;
procedure TStorageWahlDefinition.setHome(const Value: string);
begin
  Fhome := value;
  ForceDirectories(Fhome);

end;

end.
