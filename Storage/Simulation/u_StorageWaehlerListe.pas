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
unit u_StorageWaehlerListe;

interface

uses
  i_Storage, System.JSON;

type
  TStorageWaehlerListe = class(TInterfacedObject, IStorageWaehlerListe )
    private
      FHome: string;

      procedure setHome( value : string );
      procedure writeLastchangeDate;
    public
      constructor create;
      Destructor Destroy; override;

      property Home: string read FHome write setHome;

      function upload( data : TJSONObject ) : boolean;
      function getWaehlerList : TJSONObject;
      function getChangeList : TJSONObject;
      function getChange( data : TJSONObject ) : TJSONObject;
      function getLastChangeDate : TJSONObject;

      procedure release;
  end;

implementation

uses
  system.IOUtils, System.SysUtils, u_wahlerlisteVergleich, System.Types, u_json;

{ TStorageWaehlerListe }

constructor TStorageWaehlerListe.create;
begin

end;

destructor TStorageWaehlerListe.Destroy;
begin

  inherited;
end;

function TStorageWaehlerListe.getChange(data: TJSONObject): TJSONObject;
var
  fname : string;
begin
  Result := NIL;

  fname := TPath.Combine(FHome, JString(data, 'file'));
  if FileExists(fname) then
    Result := loadJSON(fname);

  if Assigned(data) then
    data.Free;
end;

function TStorageWaehlerListe.getChangeList: TJSONObject;
var
  files : TStringDynArray;
  arr   : TJSONArray;
  i     : integer;
begin
  Result := TJSONObject.Create;
  arr    := TJSONArray.Create;


  files := TDirectory.GetFiles(FHome, '*_changes.json');
  for i := low(files) to high(files) do
  begin
    arr.Add(ExtractFileName(files[i]));
  end;
  JReplace( Result, 'files', arr);
  SetLength(files, 0);
end;

function TStorageWaehlerListe.getLastChangeDate: TJSONObject;
var
  fname : string;
begin
  Result := NIL;
  fname := TPath.Combine(FHome, 'lastChange.json');
  if FileExists(fname) then
    Result := loadJSON(fname);
end;

function TStorageWaehlerListe.getWaehlerList: TJSONObject;
var
  fname : string;
  data  : TJSONObject;
begin
  fname := TPath.Combine( FHome, 'waehlerliste.json');
  Result := loadJSON(fname);
  if Assigned(Result) then
  begin
    fname := TPath.Combine(FHome, 'lastChange.json');
    data := loadJSON(fname);
    if Assigned(data) then
      JReplace( Result, 'change', data);
  end;
end;

procedure TStorageWaehlerListe.release;
begin

end;

procedure TStorageWaehlerListe.setHome(value: string);
begin
  FHome := TPath.Combine(value, 'waehler');
  Forcedirectories(FHome );
end;

function TStorageWaehlerListe.upload(data: TJSONObject): boolean;
var
  cmp : TWaehlerlisteVergleich;
  fname : string;
begin
  fname := TPath.Combine( FHome, 'waehlerliste.json');
  cmp := TWaehlerlisteVergleich.create;
  cmp.execute(data, fname);

  Result := ( cmp.ResultList.Items.Count > 0 );

  if Result then
    cmp.ResultList.saveToFile(fname);

  fname := TPath.Combine( FHome, Format('%s_changes.json', [FormatDateTime('yyyyMMdd_hhmmss', now)]));
  cmp.WriteChangeLog(fname);

  cmp.Free;
  if Assigned(data) then
    data.Free;

  writeLastchangeDate;
end;

procedure TStorageWaehlerListe.writeLastchangeDate;
var
  data : TJSONObject;
  fname : string;
  fmt   : TFormatSettings;
begin
  fmt   := TFormatSettings.Create('de-DE');
  data  := TJSONObject.Create;
  fname := TPath.Combine(FHome, 'lastChange.json');

  JReplace(data, 'datetime', DateTimeToStr(now, fmt));
  saveJSON(data, fname);
  data.Free;
end;

end.
