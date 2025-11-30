unit m_db_create;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.Stan.Async,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.IBWrapper, FireDAC.Phys.IBBase;

type
  TCreateDBMode = class(TDataModule)
    FDScript1: TFDScript;
    FDConnection1: TFDConnection;
    FDTransaction1: TFDTransaction;
    ExecQry: TFDQuery;
    ExistsQry: TFDQuery;
  private
    FDBName: string;
    FDBUser :string;
    FDBPasswort: string;
    FUseScripts: boolean;
    FEmbedded: boolean;
    FHost: string;
    FAdminPwd: string;
    FAdminSecret: string;
    FUserPwd: string;
    FPwdCheck: string;

    function existsUser(name : string ) : Boolean;
  public
    // sysdba
    property DBUser: string read FDBUser write FDBUser;
    property DBPasswort: string read FDBPasswort write FDBPasswort;

    property DBName: string read FDBName write FDBName;
    property UseScripts: boolean read FUseScripts write FUseScripts;
    property Embedded: boolean read FEmbedded write FEmbedded;
    property Host: string read FHost write FHost;
    property PwdCheck: string read FPwdCheck write FPwdCheck;

    // admin
    property AdminPwd: string read FAdminPwd write FAdminPwd;
    property AdminSecret: string read FAdminSecret write FAdminSecret;
    property UserPwd: string read FUserPwd write FUserPwd;

    // chpwduser

    function createDB : boolean;
    function testConnection : Boolean;
  end;

var
  CreateDBMode: TCreateDBMode;

implementation

uses
  u_helper, vcl.Dialogs, system.IOUtils, system.Hash, u_pwd, u_glob;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }
function SaveRCDataToList( const ResName: string; lines : TStrings ) : boolean;
var
  mem : TStream;
begin
  Result := false;
  lines.Clear;
  mem := TMemoryStream.Create;
  try
    LoadRCDataToStream( ResName, mem );
    mem.Position := 0;

    lines.Clear;
    lines.LoadFromStream(mem);

    Result := true;
  except

  end;
  mem.Free;
end;

function TCreateDBMode.createDB: boolean;
begin

  FDConnection1.DriverName := 'FB';
  FDConnection1.LoginPrompt:= false;

  if SameText('localhost', FHost) or sameText('127.0.0.1', FHost) or FEmbedded then
  begin
    ForceDirectories(ExtractFilePath(FDBName));
  end;

//  FDConnection1.Params.Values['Protocol']  := 'tpc/ip';
  FDConnection1.Params.Values['Server']    := FHost;
  FDConnection1.Params.Values['Database']  := FDBName;
  FDConnection1.Params.Values['UserName']  := FDBUser;
  FDConnection1.Params.Values['Password']  := FDBPasswort;
  FDConnection1.Params.Values['SQLDialect']:= '3';
  FDConnection1.Params.Values['PageSize']  := '4096';
  FDConnection1.Params.Values['OpenMode'] := 'Create';
  FDConnection1.Connected := true;

  result := false;

  try
    FDScript1.ValidateAll;
    FDScript1.ExecuteAll;

    if FDScript1.Transaction.Active then
      FDScript1.Transaction.Commit;


    if existsUser('ADMIN_USER') then
    begin
      ExecQry.SQL.Text := 'drop user ADMIN_USER;';
      ExecQry.ExecSQL;
    end;

    ExecQry.SQL.Text := format('create user ADMIN_USER password ''%s''; ', [FAdminPwd]);
    ExecQry.ExecSQL;

    ExecQry.SQL.Text := 'grant APPADMIN to ADMIN_USER;';
    ExecQry.ExecSQL;

    if existsUser('STEPHAN') then
    begin
      ExecQry.SQL.Text := 'drop user STEPHAN;';
      ExecQry.ExecSQL;
    end;

    ExecQry.SQL.Text := format('create user STEPHAN password ''%s''; ', [FUserPwd]);
    ExecQry.ExecSQL;

    ExecQry.SQL.Text := 'grant APPUSER to STEPHAN;';
    ExecQry.ExecSQL;

    // pwdcheck
    if existsUser('pwdcheck') then
    begin
      ExecQry.SQL.Text := 'drop user pwdcheck;';
      ExecQry.ExecSQL;
    end;

    ExecQry.SQL.Text := format('create user pwdcheck password ''%s''; ', [FPwdCheck]);
    ExecQry.ExecSQL;

    ExecQry.SQL.Text := 'grant apppwd to pwdcheck;';
    ExecQry.ExecSQL;


    // add the admin
    ExecQry.SQL.Text := format('insert into AD_ADMIN(AD_SECRET, AD_PWD) values(''%s'', ''%s'' );', [FAdminSecret, CalcPwdHash(FAdminPwd, Glob.ServerSecret)]);
    ExecQry.ExecSQL;

    if FDTransaction1.Active then
      FDTransaction1.Commit;

    FDConnection1.Close;
    Result := true;
  except

  end;

end;

function TCreateDBMode.existsUser(name: string): Boolean;
begin
  ExecQry.SQL.Text := format('SELECT COUNT(*) FROM SEC$USERS WHERE SEC$USER_NAME = ''%s''', [UpperCase(name)]);
  ExecQry.Open;
  Result := ( ExecQry.FieldByName('count').AsInteger > 0 );
  ExecQry.Close;
end;

function TCreateDBMode.testConnection: Boolean;
begin
  result := false;

  with FDConnection1 do
  begin
    FDConnection1.Params.Values['OpenMode'] := '';

    Params.Values['Database']  := FDBName;
    Params.Values['User_Name'] := 'admin_user';
    Params.Values['Password']  := FAdminPwd;

    if FEmbedded then
    begin
      Params.Values['Server'] := '';
      Params.Values['Protocol']  := 'local';
    end
    else
    begin
      Params.Values['Server'] :=FHost;
    end;


    LoginPrompt := false;

    try
      Connected := true;
      Result := Connected;
    except

    end;
    FDConnection1.Close;
  end;

end;

end.
