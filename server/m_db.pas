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
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    function openDB : boolean;
    function closeDB : boolean;
  end;

var
  DBMod: TDBMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  system.IOUtils;

function TDBMod.closeDB: boolean;
begin
  Result := false;
  try
    FDConnection1.Open;
    result := FDConnection1.Connected;
  except
    on e : exception do
    begin
      Writeln(e.ToString);
    end;

  end;
end;


procedure TDBMod.DataModuleCreate(Sender: TObject);
var
  fname : string;
begin

  fname := TPath.Combine(ExtractFilePath(ParamStr(0)), 'db\test.fdb');
  FDConnection1.Params.Values['Database'] := fname;
  FDConnection1.Params.Values['Server'] := '';
end;

function TDBMod.openDB: boolean;
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
