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
    CreateDBQry: TFDQuery;
    FDTransaction1: TFDTransaction;
  private
    FDBName: string;
    FDBUser :string;
    FDBPasswort: string;
    FUseScripts: boolean;
    FEmbedded: boolean;
    FHost: string;
  public
    property DBName: string read FDBName write FDBName;
    property DBUser: string read FDBUser write FDBUser;
    property DBPasswort: string read FDBPasswort write FDBPasswort;
    property UseScripts: boolean read FUseScripts write FUseScripts;
    property Embedded: boolean read FEmbedded write FEmbedded;
    property Host: string read FHost write FHost;

    function createDB : boolean;
    function testConnection : Boolean;
  end;

var
  CreateDBMode: TCreateDBMode;

implementation

uses
  u_helper, vcl.Dialogs, system.IOUtils;

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
    Result := true;
  except

  end;

end;

function TCreateDBMode.testConnection: Boolean;
begin
  result := false;

  with FDConnection1 do
  begin
    FDConnection1.Params.Values['OpenMode'] := '';

    Params.Values['Database']  := FDBName;
    Params.Values['User_Name'] := FDBUser;
    Params.Values['Password']  := FDBPasswort;

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
