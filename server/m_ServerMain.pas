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
  FireDAC.Comp.DataSet, LogThread;

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
    GetUserQry: TFDQuery;
    DSWahlliste: TDSServerClass;
    DSBriefwahl: TDSServerClass;
    DsStat: TDSServerClass;
    DSUser: TDSServerClass;
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
    procedure DSWahllisteGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSBriefwahlGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DsStatGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSUserGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServer1Connect(DSConnectEventObject: TDSConnectEventObject);
  private
    function startServer : boolean;
    function stopServer : boolean;

    function validateAdmin( pwd : string; var UserRoles: TStrings ) : boolean;
    function validateUser( user, pwd : string; var UserRoles: TStrings ) : Boolean;

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
  m_vorstand, u_rollen, m_wahl_liste, m_brief, m_statMod, m_user, Data.DBXTransport,
  m_log;


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
    valid := validateAdmin(Password, UserRoles);
  end
  else
  begin
    valid := validateUser(User, Password, UserRoles);
  end;
end;

procedure TMitbestimmITSrv.DSAuthenticationManager1UserAuthorize(
  Sender: TObject; EventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
var
  i : integer;
begin
  valid := not Assigned(EventObject.AuthorizedRoles) or
           not Assigned(EventObject.DeniedRoles);

  if not valid and Assigned(EventObject.AuthorizedRoles) then
  begin
    for i := 0 to pred( EventObject.UserRoles.Count) do begin
      if EventObject.AuthorizedRoles.IndexOf(EventObject.UserRoles.Strings[i]) > -1 then
      begin
        valid := true;
        break;
      end;
    end;
  end;

  if not valid and Assigned(EventObject.DeniedRoles) then
  begin
    for i := 0 to pred( EventObject.UserRoles.Count) do
    begin
      if EventObject.DeniedRoles.IndexOf(EventObject.UserRoles.Strings[i]) > -1 then begin
        valid := false;
        break;
      end;
    end;
  end;
end;

procedure TMitbestimmITSrv.DSBriefwahlGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := m_brief.TBriefWahlMod;
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

procedure TMitbestimmITSrv.DSServer1Connect(
  DSConnectEventObject: TDSConnectEventObject);
var
  session : TDSSession;
  ClientInfo: TdbxClientInfo;
begin
  session := TDSSessionManager.GetThreadSession;
  ClientInfo := DSConnectEventObject.ChannelInfo.ClientInfo;
  if Assigned(session) then
  begin
    session.PutData('remoteip', ClientInfo.IpAddress);
  end;
end;

procedure TMitbestimmITSrv.DsStatGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := m_statMod.TStadMod;
end;

procedure TMitbestimmITSrv.DSUserGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := m_user.TUserMod;
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

procedure TMitbestimmITSrv.DSWahllisteGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := m_wahl_liste.TWahlListeMod;
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
  CreateLogthread;
end;

procedure TMitbestimmITSrv.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Stopped := DoStop;
  EndLogThread;
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

function TMitbestimmITSrv.validateAdmin(pwd: string; var UserRoles: TStrings): boolean;
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
    begin
      TDSSessionManager.GetThreadSession.PutData('UserID', '1');
      TDSSessionManager.GetThreadSession.PutData('UserName', 'Admin');
      UserRoles.Add(roAdmin);
    end;
  end;
  AdminTab.Close;

end;

function TMitbestimmITSrv.validateUser(user, pwd: string; var UserRoles: TStrings): Boolean;
var
  pwdHash : string;
  session : TDSSession;
begin
  Result := false;
  pwdHash := CalcPwdHash(pwd);
  session := TDSSessionManager.GetThreadSession;

  UserPWDQry.ParamByName('login').AsString := user;
  UserPWDQry.Open;
  if not UserPWDQry.IsEmpty then
  begin
    result := SameText(UserPWDQry.FieldByName('mw_pwd').AsString, pwdHash);
    if Result then
    begin
      session.PutData('UserID', UserPWDQry.FieldByName('MA_ID').AsString);
      UserRoles.DelimitedText := UserPWDQry.FieldByName('MW_ROLLE').AsString;

      GetUserQry.ParamByName('MA_ID').AsInteger := UserPWDQry.FieldByName('MA_ID').AsInteger;
      GetUserQry.Open;
      if not GetUserQry.IsEmpty then
      begin
        TDSSessionManager.GetThreadSession.PutData('UserName',
          format('%s %s', [
            GetUserQry.FieldByName('MA_VORNAME').AsString,
            GetUserQry.FieldByName('MA_NAME').AsString
          ]));
      end;
      GetUserQry.Close;
    end;

  end;
  UserPWDQry.Close;

  pwdHash := session.SessionName;

  if Result then
    SaveLog( false, 'Login ok', Format('user %s from %s', [user, session.GetData('remoteip')]))
  else
    SaveLog( false, 'Login FAIL', Format('user %s from %s', [user, session.GetData('remoteip')]));

end;

end.

