{* This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>. *}

unit u_config;

interface

type
  TConfig = class
    private
      m_isLoading : boolean;
      FAdminPwd: string;
      procedure setAdminPwd( value : string );
    public

      constructor create;
      Destructor Destroy; override;

      property AdminPwd: string read FAdminPwd write setAdminPwd;

      procedure load;
      procedure save;
  end;

var
  Config : TConfig;
implementation

uses
  System.SysUtils, System.IniFiles;

{ TConfig }

constructor TConfig.create;
begin
  m_isLoading := false;
  FAdminPwd   := '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918';
end;

destructor TConfig.Destroy;
begin

  inherited;
end;

procedure TConfig.load;
var
  fname : string;
  ini   : TiniFile;
begin
  fname := ParamStr(0)+'.ini';
  if not FileExists(fname) then
    exit;

  m_isLoading := true;
  ini := TIniFile.Create(fname);

  FAdminPwd := ini.ReadString('admin', 'pwd', FAdminPwd);
  ini.Free;
  m_isLoading := false;

end;

procedure TConfig.save;
var
  fname : string;
  ini   : TIniFile;
begin
  fname := ParamStr(0)+'.ini';

  ini := TIniFile.Create(fname);

  ini.WriteString('admin', 'pwd', FAdminPwd);
  ini.Free;

end;

procedure TConfig.setAdminPwd(value: string);
begin
  FAdminPwd := value;
  if not m_isLoading then
    save;

end;

initialization
  Config := TConfig.create;
  config.load;

finalization
  config.Free;
end.
