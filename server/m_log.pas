unit m_log;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TLogMod = class(TDataModule)
    AddLogQry: TFDQuery;
  private
    { Private-Deklarationen }
  public
    procedure addLog( titel, text : string );

    class procedure log( titel, text : string );
  end;

var
  LogMod: TLogMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_db, System.SysUtils, Datasnap.DSSession;

{$R *.dfm}

{ TLogMod }

procedure TLogMod.addLog(titel, text: string);
begin
  AddLogQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  AddLogQry.ParamByName('LG_DATA').AsString := text;
  AddLogQry.ParamByName('LG_USER').AsString := TDSSessionManager.GetThreadSession.getData('UserName' );
  AddLogQry.ParamByName('LG_TITEL').AsString:= titel;
  AddLogQry.ExecSQL;

  AddLogQry.close;
end;

class procedure TLogMod.log(titel, text: string);
var
  lg : TLogMod;
begin
  lg := TLogMod.Create(NIL);
  lg.addLog(titel, text);
  lg.free;
end;

end.
