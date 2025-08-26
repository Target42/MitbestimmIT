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
  DbxCompressionFilter;

type
  TMitbestimmITSrv = class(TService)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    DSHTTPService2: TDSHTTPService;
    DSCertFiles1: TDSCertFiles;
    DSAuthenticationManager1: TDSAuthenticationManager;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSCertFiles1GetPEMFileSBPasskey(ASender: TObject;
      APasskey: TStringBuilder);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private-Deklarationen }
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
  system.Hash,
  ServerMethodsUnit1, u_config;


procedure TMitbestimmITSrv.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit1.TServerMethods1;
end;

procedure TMitbestimmITSrv.DSAuthenticationManager1UserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
var
  hash : string;
begin
  valid := false;
  if SameText(User, 'admin') then
  begin
    hash := THashSHA2.GetHashString(Password);
    valid := SameText( hash, Config.AdminPwd);
  end
  else
  begin

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
    APasskey.Append('Wahl2026');
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
  DSServer1.Start;
end;

procedure TMitbestimmITSrv.DoInterrogate;
begin
  inherited;
end;

function TMitbestimmITSrv.DoPause: Boolean;
begin
  DSServer1.Stop;
  Result := inherited;
end;

function TMitbestimmITSrv.DoStop: Boolean;
begin
  DSServer1.Stop;
  Result := true;
end;

procedure TMitbestimmITSrv.ServiceStart(Sender: TService; var Started: Boolean);
begin
  DSServer1.Start;
end;

procedure TMitbestimmITSrv.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Stopped := DoStop;
end;

end.

