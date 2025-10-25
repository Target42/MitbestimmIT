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

unit m_ServerMain;

interface

uses System.SysUtils, System.Classes,
  Vcl.SvcMgr,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSHTTPCommon, Datasnap.DSHTTP,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth, DbxSocketChannelNative,
  DbxCompressionFilter, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TMitbestimmITSrv = class(TService)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    DSHTTPService2: TDSHTTPService;
    DSCertFiles1: TDSCertFiles;
    DSAuthenticationManager1: TDSAuthenticationManager;
    DSAdmin: TDSServerClass;
    DSLogin: TDSServerClass;
    UserPWDQry: TFDQuery;
    AdminTab: TFDTable;
    DSWahl: TDSServerClass;
    DSWaehler: TDSServerClass;
    DSLokale: TDSServerClass;
    DSVorstand: TDSServerClass;
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSCertFiles1GetPEMFileSBPasskey(ASender: TObject;
      APasskey: TStringBuilder);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure DSAdminGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ServiceCreate(Sender: TObject);
    procedure DSLoginGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSWahlGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSWaehlerGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSLokaleGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSVorstandGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    function startServer : boolean;
    function stopServer : boolean;

    function validateAdmin( pwd : string ) : boolean;
    function validateUser( user, pwd : string ) : Boolean;

  protected
    function DoStop: Boolean; override;
    function DoPause: Boolean; override;
    function DoContinue: Boolean; override;
    procedure DoInterrogate; override;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  MitbestimmITSrv: TMitbestimmITSrv;

implementation


{$R *.dfm}

uses
  Winapi.Windows,
  system.Hash, DSSession,
  m_admin, u_config, u_glob, m_db, m_login, u_pwd, m_wahl, m_waehler, m_lokale,
  m_vorstand;


procedure TMitbestimmITSrv.DSAdminGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass :=  m_admin.TAdminMod;
end;

procedure TMitbestimmITSrv.DSAuthenticationManager1UserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
begin
{$ifdef DEBUG}
  if (user = 'stephan') and (Password = '251169') then
  begin
    valid := true;
    exit;
  end;

{$endif}

  valid := false;
  if SameText('admin_user', user ) then
  begin
    valid := validateAdmin(Password);
    if valid then
      UserRoles.Add('admim');
  end
  else
  begin
    valid := validateUser(User, Password);
    if valid then
      UserRoles.Add('user');
  end;
end;

procedure TMitbestimmITSrv.DSAuthenticationManager1UserAuthorize(
  Sender: TObject; EventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
begin
  { TODO : Autorisieren Sie einen Benutzer zum Ausführen einer Methode.
    Verwenden Sie Werte von EventObject, wie z.B. UserName, UserRoles, AuthorizedRoles und DeniedRoles.
    Verwenden Sie DSAuthenticationManager1.Roles zum Definieren von 'Authorized'- und 'Denied'-Rollen
    für bestimmte Servermethoden. }
  valid := True;
end;

procedure TMitbestimmITSrv.DSCertFiles1GetPEMFileSBPasskey(ASender: TObject; APasskey: TStringBuilder);
begin
  if APasskey <> nil then
    APasskey.Append('Wahl');
end;

procedure TMitbestimmITSrv.DSLoginGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := m_login.TLoginMod;
end;

procedure TMitbestimmITSrv.DSLokaleGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := m_lokale.TLokaleMod;
end;

procedure TMitbestimmITSrv.DSVorstandGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := m_vorstand.TVortandMod;
end;

procedure TMitbestimmITSrv.DSWaehlerGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := m_waehler.TWaehlerMod;
end;

procedure TMitbestimmITSrv.DSWahlGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := m_wahl.TWahlMod;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  MitbestimmITSrv.Controller(CtrlCode);
end;

function TMitbestimmITSrv.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

function TMitbestimmITSrv.DoContinue: Boolean;
begin
  Result := inherited;
  Result := startServer and Result;
end;

procedure TMitbestimmITSrv.DoInterrogate;
begin
  inherited;
end;

function TMitbestimmITSrv.DoPause: Boolean;
begin
  Result := stopServer;
  Result := inherited and Result;
end;

function TMitbestimmITSrv.DoStop: Boolean;
begin
  Result := stopServer;
end;

procedure TMitbestimmITSrv.ServiceCreate(Sender: TObject);
begin
  Glob.readData;

  DSHTTPService2.CertFiles.KeyFile      := glob.KeyFile;
  DSHTTPService2.CertFiles.CertFile     := glob.CertFile;
  DSHTTPService2.CertFiles.RootCertFile := glob.CertFile;

end;

procedure TMitbestimmITSrv.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Started := startServer;
end;

procedure TMitbestimmITSrv.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Stopped := DoStop;
end;

function TMitbestimmITSrv.startServer: boolean;
begin
  DSHTTPService2.Server := NIL;
  DSServer1.Start;
  try
    DSHTTPService2.Server := DSServer1;
  except
    on e : exception do
    begin
      Writeln('SSL-Error');
      DSHTTPService2.Server := NIL;
    end;
  end;

  DBMod.openDB;
  result := DSServer1.Started and DBMod.FDConnection1.Connected;
end;

function TMitbestimmITSrv.stopServer: boolean;
begin
  DSServer1.Stop;
  DSHTTPService2.Server := NIL;
  DBMod.closeDB;

  result := (DBMod.FDConnection1.Connected = false );
end;

function TMitbestimmITSrv.validateAdmin(pwd: string): boolean;
var
  pwdHash : string;
begin
  pwdHash := CalcPwdHash(pwd);
  result  := false;
  AdminTab.Open;
  if not AdminTab.IsEmpty then
  begin
    result := SameText(AdminTab.FieldByName('AD_PWD').AsString , pwdHash);
    if result then
        TDSSessionManager.GetThreadSession.PutData('UserID', '1');
  end;
  AdminTab.Close;

end;

function TMitbestimmITSrv.validateUser(user, pwd: string): Boolean;
var
  pwdHash : string;
begin
  Result := false;
  pwdHash := CalcPwdHash(pwd);
  UserPWDQry.ParamByName('login').AsString := user;
  UserPWDQry.Open;
  if not UserPWDQry.IsEmpty then
  begin
    result := SameText(UserPWDQry.FieldByName('mw_pwd').AsString, pwdHash);
    if Result then
      TDSSessionManager.GetThreadSession.PutData('UserID', UserPWDQry.FieldByName('MA_ID').AsString);

  end;
  UserPWDQry.Close;

end;

end.

