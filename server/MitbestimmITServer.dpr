{*
 * MitbestimmITServer
 *
 * Copyright (C) 2025 Stephan Winter
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *}

program MitbestimmITServer;

{$ifdef DEBUG}
  {$APPTYPE CONSOLE}
{$endif}

uses
  Vcl.SvcMgr,
  m_ServerMain in 'm_ServerMain.pas' {MitbestimmITSrv: TService},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDSServerModule},
  System.SysUtils {ServerMethods1: TDSServerModule},
  u_BER_Berechnungen in '..\berechnungen\u_BER_Berechnungen.pas',
  u_BRWahlFristen in '..\berechnungen\u_BRWahlFristen.pas',
  u_WahlfristenICS in '..\berechnungen\u_WahlfristenICS.pas',
  u_config in 'u_config.pas',
  u_json in '..\lib\u_json.pas',
  m_db in 'm_db.pas' {DBMod: TDataModule},
  m_db_create in 'm_db_create.pas' {CreateDBMode: TDataModule},
  u_helper in '..\lib\u_helper.pas';

{$R *.RES}



{$ifdef DEBUG}
var
  MyDummyBoolean  : Boolean;
  s : string;
{$ENDIF}

{$IFDEF DEBUG}
//{$e console.exe}
{$ELSE}
{$e service.exe}
{$ENDIF}

begin
{$ifdef DEBUG}
  try
    ReportMemoryLeaksOnShutdown := true;
    // In debug mode the server acts as a console application.
    WriteLn('Archivserver DEBUG mode');
    Writeln('q = quit');

    // Create the TService descendant manually.
    MitbestimmITSrv := TMitbestimmITSrv.Create(nil);
    DBMod      := TDBMod.Create(MitbestimmITSrv);

//    CreateDBMode := TCreateDBMode.Create(MitbestimmITSrv);
//    CreateDBMode.createDB;

    // Simulate service start.
    MitbestimmITSrv.ServiceStart(MitbestimmITSrv, MyDummyBoolean);
    // Keep the console box running (ServerContainer1 code runs in the background)
    repeat
      ReadLn(s);
      s := trim(s);
    until s = 'q';
    MitbestimmITSrv.ServiceStop(MitbestimmITSrv, MyDummyBoolean);
    // On exit, destroy the service object.
    FreeAndNil(MitbestimmITSrv);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      WriteLn('Press enter to exit.');
      ReadLn;
    end;
  end;
{$else}
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;

  Application.CreateForm(TMitbestimmITSrv, MitbestimmITSrv);
  Application.Run;
{$endif}
end.

