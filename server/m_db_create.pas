unit m_db_create;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.Stan.Async,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TCreateDBMode = class(TDataModule)
    FDScript1: TFDScript;
    FDConnection1: TFDConnection;
  private
    { Private-Deklarationen }
  public
    function createDB( name : string; useScripte : boolean = false) : boolean;
  end;

var
  CreateDBMode: TCreateDBMode;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TCreateDBMode.createDB( name : string; useScripte : boolean ): boolean;
begin
  result := false;

  with FDConnection1 do
  begin
    Params.Values['Database'] := 'D:\DelphiBin\MitbestimmIT\Server\db\neueDatenbank.fdb';
    Params.Values['User_Name'] := 'SYSDBA';
    Params.Values['Password'] := 'masterkey';
    Params.Values['Server'] := ''; // wichtig für embedded
    Params.Values['CreateDatabase'] := 'Yes'; // wichtig
    LoginPrompt := false;

    Connected := true;

    if not useScripte then
    begin
      FDScript1.ExecuteAll;
    end;

    FDConnection1.Close;
  end;


end;

end.
