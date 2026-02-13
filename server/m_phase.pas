unit m_phase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, Datasnap.Provider;

type
  TPhasenMod = class(TDataModule)
    Phasen: TFDQuery;
    FDTransaction1: TFDTransaction;
    Data: TFDQuery;
    DataQry: TDataSetProvider;
    setPhaseQry: TFDQuery;
    procedure DataBeforeOpen(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    class function phaseActive( phase : string ) : Boolean;
    class function setPhaseActive( phase : string; active : boolean ) : Boolean;

    function checkPhase( phase : string ) : Boolean;
    function setPhase( phase : string; active : boolean) : Boolean;
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses m_db, Vcl.SvcMgr, DSSession, u_BRWahlFristen, m_glob;

{$R *.dfm}

{ TPhasenMod }

function TPhasenMod.checkPhase(phase: string): Boolean;
var
  list : TStringList;
  i    : integer;
begin
  Phasen.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  list := TStringList.Create;
  list.Delimiter := ',';
  list.DelimitedText := phase;
  result := false;

  for i := 0 to pred(list.Count) do
  begin
    Phasen.ParamByName('PHASE').AsString  := trim(list[i]);
    Phasen.Open;
    Result := not Phasen.IsEmpty;
    Phasen.Close;
    if Result then
      break;
  end;
  list.Free;
end;

procedure TPhasenMod.DataBeforeOpen(DataSet: TDataSet);
begin
  Data.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

class function TPhasenMod.phaseActive(phase: string): Boolean;
var
  PhasenMod: TPhasenMod;
begin
  Application.CreateForm(TPhasenMod, PhasenMod);
  Result := PhasenMod.checkPhase(phase);
  PhasenMod.Free;
end;

function TPhasenMod.setPhase(phase: string; active: boolean): Boolean;
begin
  setPhaseQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  setPhaseQry.ParamByName('wp_phase').AsString := phase;
  if active then
    setPhaseQry.ParamByName('WP_ACTIVE').AsString := 'T'
  else
    setPhaseQry.ParamByName('WP_ACTIVE').AsString := 'F';
  setPhaseQry.ExecSQL;

  Result := setPhaseQry.RowsAffected > 0;
end;

class function TPhasenMod.setPhaseActive(phase: string;
  active: boolean): Boolean;
var
  PhasenMod: TPhasenMod;
begin
  Application.CreateForm(TPhasenMod, PhasenMod);
  Result := PhasenMod.setPhase(phase, active);
  PhasenMod.Free;
end;

end.
