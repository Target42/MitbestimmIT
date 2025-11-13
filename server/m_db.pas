unit m_db;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TDBMod = class(TDataModule)
    FDConnection1: TFDConnection;
    FDTransaction1: TFDTransaction;
  private
    { Private-Deklarationen }
  public
    function openDB : boolean;
    function closeDB : boolean;

    function UserID : integer;
    function WahlID : integer;

    function AddRole( newRole : string; oldRoles : string ) : string;
    function RemoveRole( delRole, oldRoles : string ) : string;
  end;

var
  DBMod: TDBMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  system.IOUtils, u_glob, DSSession;

function TDBMod.openDB: boolean;
begin
  Result := false;
  try
    with FDConnection1.Params as TFDPhysFBConnectionDefParams do
    begin
      Server   := Glob.DBHost;
      Database := glob.DBName;
      UserName := 'stephan';
      RoleName := 'appuser';
      Password := glob.UserPWD;
    end;

    FDConnection1.Open;
    result := FDConnection1.Connected;
  except
    on e : exception do
    begin
      Writeln(e.ToString);
    end;

  end;
end;

function TDBMod.RemoveRole(delRole, oldRoles: string): string;
var
  list : TStringList;
  inx : integer;
begin
  list := TStringList.Create;
  list.StrictDelimiter := true;
  list.Delimiter := ',';
  list.DelimitedText := oldRoles;

  inx := list.IndexOf(delRole);
  if inx <> -1 then
    list.Delete(inx);

  Result := list.DelimitedText;

  list.Free;
end;

function TDBMod.UserID: integer;
var
  session : TDSSession;
begin
  result := 0;

  session := TDSSessionManager.GetThreadSession;
  if session.HasData('UserID') then
    result := StrToIntDef(Session.GetData('UserID'), 0);

end;

function TDBMod.WahlID: integer;
var
  session : TDSSession;
begin
  result := 0;

  session := TDSSessionManager.GetThreadSession;
  if session.HasData('WahlID') then
    result := StrToIntDef(Session.GetData('WahlID'), 0);

end;

function TDBMod.AddRole(newRole, oldRoles: string): string;
var
  list : TStringList;
begin
  list := TStringList.Create;
  list.DelimitedText := oldRoles;

  if list.IndexOf(newRole) = -1 then
    list.Add(newRole);

  Result := list.DelimitedText;

  list.Free;
end;

function TDBMod.closeDB: boolean;
begin
  Result := false;
  try
    FDConnection1.Close;
    result := (FDConnection1.Connected = false );
  except
    on e : exception do
    begin
      Writeln(e.ToString);
    end;

  end;

end;

end.
