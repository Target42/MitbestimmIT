unit m_phase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet;

type
  TPhasenMod = class(TDataModule)
    PhasenQry: TFDQuery;
    FDTransaction1: TFDTransaction;
  private
    { Private-Deklarationen }
  public
    class function phaseActive( phase : string ) : Boolean;

    function checkPhase( phase : string ) : Boolean;
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses m_db, Vcl.SvcMgr, DSSession;

{$R *.dfm}

{ TPhasenMod }

function TPhasenMod.checkPhase(phase: string): Boolean;
begin
  PhasenQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  PhasenQry.ParamByName('PHASE').AsString  := phase;
  PhasenQry.Open;
  Result := not PhasenQry.IsEmpty;
  PhasenQry.Close;

end;

class function TPhasenMod.phaseActive(phase: string): Boolean;
var
  PhasenMod: TPhasenMod;
  session : TDSSession;
begin
  session := TDSSessionManager.GetThreadSession;

  result := session.HasData('Simulation');
  if not Result  then
  begin
    Application.CreateForm(TPhasenMod, PhasenMod);
    Result := PhasenMod.checkPhase(phase);
    PhasenMod.Free;
  end;
end;

end.
