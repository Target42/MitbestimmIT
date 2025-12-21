unit m_auswertung;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, u_rollen, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, Datasnap.Provider;

type
  [TRoleAuth(roWahlVorstand)]
  TAuswertungsmod = class(TDSServerModule)
    Data: TFDQuery;
    FDTransaction1: TFDTransaction;
    DataQry: TDataSetProvider;
    procedure DataBeforeOpen(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    function start( data : TJSONObject ) :  TJSONObject;
    function ende( data : TJSONObject ) :  TJSONObject;

    function startCount( data : TJSONObject ) :  TJSONObject;
    function endeCount( data : TJSONObject ) :  TJSONObject;

    function wahlzettel( data : TJSONObject ) :  TJSONObject;

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses u_json, m_phase, u_BRWahlFristen, m_db;

{$R *.dfm}

{ TAuswertungsmod }


procedure TAuswertungsmod.DataBeforeOpen(DataSet: TDataSet);
begin
  Data.ParamByName('WA_ID').AsInteger := DBMod .WahlID;
end;

function TAuswertungsmod.ende(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  if not TPhasenMod.phaseActive(SAZ) then
  begin
    JResult( result, false, 'Die Auswertung ist nicht aktiv!');
    exit;
  end;
end;

function TAuswertungsmod.endeCount(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  if not TPhasenMod.phaseActive(SAZ) then
  begin
    JResult( result, false, 'Die Auswertung ist nicht aktiv!');
    exit;
  end;

end;

function TAuswertungsmod.start(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  if not TPhasenMod.phaseActive(SAZ) then
  begin
    JResult( result, false, 'Die Auswertung ist nicht aktiv!');
    exit;
  end;

end;

function TAuswertungsmod.startCount(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  if not TPhasenMod.phaseActive(SAZ) then
  begin
    JResult( result, false, 'Die Auswertung ist nicht aktiv!');
    exit;
  end;

end;

function TAuswertungsmod.wahlzettel(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  if not TPhasenMod.phaseActive(SAZ) then
  begin
    JResult( result, false, 'Die Auswertung ist nicht aktiv!');
    exit;
  end;

end;

end.

