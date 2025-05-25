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
unit u_StorageSimulation;

interface

uses
  i_Storage, System.JSON, u_StorageWahlDefinition;

type
  TStorageSimulation = class(TInterfacedObject, IStorage)
  private
    m_home : string;
    m_wahlPath : string;
    m_connected : boolean;

    m_wahlDef : IStorageWahlDefinition;
    function getWahlDefininition : IStorageWahlDefinition;
    function getWahlVorstand     : IStorageWahlVorstand;
    function getWahlListe        : IStorageWahlListe;

    procedure setPath;

  public
    constructor create;
    Destructor Destroy; override;

    function connect( info : TJSONObject ) : Boolean;
    function isConnected : boolean;

    function select : TJSONObject;

    function getWahlen : TJSONObject;
    function load( data : TJSONObject) :boolean;
    function new : boolean;

    procedure close;

    procedure release;


  end;

implementation

uses
  system.IOUtils, u_json, System.SysUtils, System.Types, u_WahlDef,
  f_simulation_load, System.Win.ComObj;

{ TStorageSimulation }

function createStorageSimulation : IStorage;
begin
  Result := TStorageSimulation.create;
end;

procedure TStorageSimulation.close;
begin
  m_wahlPath := '';
end;

function TStorageSimulation.connect(info: TJSONObject): Boolean;
begin
  Result := true;
  m_wahlPath := '';
  m_connected := true;

  if Assigned(info) then
    info.Free;
end;

constructor TStorageSimulation.create;
begin
  m_home := TPath.Combine(TPath.GetDocumentsPath, 'mitbestimmIT');
  m_wahlPath := '';
  m_connected := false;

  m_wahlDef := TStorageWahlDefinition.create;
end;

destructor TStorageSimulation.Destroy;
begin

  inherited;
end;

function TStorageSimulation.getWahlDefininition: IStorageWahlDefinition;
begin
  Result := m_wahlDef;
end;

function TStorageSimulation.getWahlen: TJSONObject;
var
  dirs : TStringDynArray;
  i    : integer;
  arr  : TJSONArray;
  row  : TJSONObject;

  def  : TWahlDef;
  fname: string;
  obj  : TJSONObject;
begin
  Result := TJSONObject.Create;
  arr    := TJSONArray.Create;

  dirs := TDirectory.GetDirectories(m_home, '{*}');

  for i := low(dirs) to High(dirs) do
  begin
    fname := TPath.Combine(dirs[i], 'info.json');
    if FileExists(fname) then
    begin
      obj := loadJSON(fname);
      if Assigned(obj) then
      begin
        def := TWahlDef.create;
        def.fromJSON(obj);
        row := TJSONObject.Create;

        JReplace( row, 'kurz', def.WahlKurzName);
        JReplace( row, 'name', def.WahlName);
        JReplace( row, 'id', ExtractFileName(dirs[i]));

        def.Free;
        obj.Free;

        arr.AddElement(row);
      end;
    end;
  end;
  SetLength(dirs, 0);

  JReplace( Result, 'items', arr);
end;

function TStorageSimulation.getWahlListe: IStorageWahlListe;
begin
  Result := NIL;
end;

function TStorageSimulation.getWahlVorstand: IStorageWahlVorstand;
begin
  Result := NIL;
end;

function TStorageSimulation.isConnected: boolean;
begin
  Result := m_connected;
end;

function TStorageSimulation.load(data: TJSONObject): boolean;
begin
  Result := false;
  if JExistsKey(data, 'id') and JBool( data, 'load') then
  begin

    m_wahlPath := TPath.Combine(m_home, JString(data, 'id'));
    if not TDirectory.Exists(m_wahlPath) and JBool( data, 'createpath') then
      ForceDirectories( m_wahlPath);

    setPath;

    Result := TDirectory.Exists(m_wahlPath);
  end;
end;

function TStorageSimulation.new: boolean;
begin
  m_wahlPath := TPath.Combine(m_home, CreateClassID);
  setPath;

  Result := true;
end;

procedure TStorageSimulation.release;
begin

end;

function TStorageSimulation.select: TJSONObject;
var
  data : TJSONObject;
begin
  data := self.getWahlen;
  Result := TSimulationLoadForm.Execute(data);
  data.Free;
end;

procedure TStorageSimulation.setPath;
begin
  ( m_wahlDef as TStorageWahlDefinition).home := m_wahlPath;
end;

initialization
  registerStorage('simulation', createStorageSimulation);

end.
