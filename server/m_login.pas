unit m_login;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, System.JSON,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TLoginMod = class(TDSServerModule)
    FDConnection1: TFDConnection;
    WATab: TFDTable;
    FDTransaction1: TFDTransaction;
    WATabWA_ID: TIntegerField;
    WATabWA_TITLE: TStringField;
    WATabWA_SIMU: TStringField;
    WATabWA_ACTIVE: TStringField;
    PwdQry: TFDQuery;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure WATabWA_SIMUGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure WATabWA_SIMUSetText(Sender: TField; const Text: string);
  private
    { Private-Deklarationen }
  public
    function getWahlListe : TJSONObject;
    function checkLogin( data : TJSONObject ) : TJSONObject;
    function checkTOTP( code : string; utctime : TDateTime ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  u_glob, u_json, u_json_db, u_pwd;

{$R *.dfm}

function TLoginMod.checkLogin(data: TJSONObject): TJSONObject;
var
  login : string;
  hash  : string;

begin
  Result := TJSONObject.Create;

  login := LowerCase(JString( data, 'login').Trim());

  JReplace(result, 'login', login);

  PwdQry.ParamByName('login').AsString := login;
  PwdQry.Open;
  if not PwdQry.IsEmpty then
  begin
    hash:= CalcPwdHash(JString( data, 'pwd'));
  end;
  PwdQry.Close;
end;

function TLoginMod.checkTOTP(code: string; utctime: TDateTime): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

procedure TLoginMod.DSServerModuleCreate(Sender: TObject);
begin
  with FDConnection1.Params as TFDPhysFBConnectionDefParams do
  begin
    Server   := Glob.DBHost;
    Database := glob.DBName;
    UserName := 'PWDCHECK';
    RoleName := 'apppwd;';
    Password := glob.DBPwdCheck
  end;
end;

function TLoginMod.getWahlListe: TJSONObject;
begin
  WATab.Open();
  Result := DataSourceToJson( WATab, false );
  WATab.Close;
end;

procedure TLoginMod.WATabWA_SIMUGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.AsString = 'T' then
    Text := 'Ja'
  else
    Text := 'Nein';

end;

procedure TLoginMod.WATabWA_SIMUSetText(Sender: TField; const Text: string);
begin
  if SameText(Text, 'ja') then
    Sender.AsString := 'T'
  else
    Sender.AsString := 'F';
end;

end.

