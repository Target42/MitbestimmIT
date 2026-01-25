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
    Doppelt: TFDQuery;
    MarkDoppeltQry: TFDQuery;
    Mark: TFDQuery;
    BriefDaten: TFDQuery;
    BriefdatenQry: TDataSetProvider;
    GetBriefStreamQry: TFDQuery;
    SetBriefStreamQry: TFDQuery;
    procedure DataBeforeOpen(DataSet: TDataSet);
    procedure DoppeltBeforeOpen(DataSet: TDataSet);
    procedure MarkDoppeltQryBeforeOpen(DataSet: TDataSet);
    procedure MarkBeforeOpen(DataSet: TDataSet);
    procedure BriefDatenBeforeOpen(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    function start( data : TJSONObject ) :  TJSONObject;
    function ende( data : TJSONObject ) :  TJSONObject;

    function startCount( data : TJSONObject ) :  TJSONObject;
    function endeCount( data : TJSONObject ) :  TJSONObject;

    function wahlzettel( data : TJSONObject ) :  TJSONObject;

    function getBriefText( data : TJSONObject ) : TJSONObject;
    function saveBriefText( data :TJSONObject) :TJSONObject;

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses u_json, m_phase, u_BRWahlFristen, m_db, u_json_db;

{$R *.dfm}

{ TAuswertungsmod }


procedure TAuswertungsmod.BriefDatenBeforeOpen(DataSet: TDataSet);
begin
  BriefDaten.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

procedure TAuswertungsmod.DataBeforeOpen(DataSet: TDataSet);
begin
  Data.ParamByName('WA_ID').AsInteger := DBMod .WahlID;
end;

procedure TAuswertungsmod.DoppeltBeforeOpen(DataSet: TDataSet);
begin
  Doppelt.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
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

function TAuswertungsmod.getBriefText(data: TJSONObject): TJSONObject;
var
  mem : TMemoryStream;
begin
  Result := NIL;

  GetBriefStreamQry.ParamByName('BW_ID').AsInteger := JInt( data,'id');
  GetBriefStreamQry.ParamByName('WA_Id').AsInteger := DBMod.WahlID;
  GetBriefStreamQry.Open;

  if not GetBriefStreamQry.Eof then
  begin
    mem := TMemoryStream.Create;
    (GetBriefStreamQry.FieldByName('BW_DATA') as TBlobField).SaveToStream(mem);
    mem.Position := 0;
    Result := loadJSON(mem);
    mem.Free;
  end;

end;

procedure TAuswertungsmod.MarkBeforeOpen(DataSet: TDataSet);
begin
  Mark.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

procedure TAuswertungsmod.MarkDoppeltQryBeforeOpen(DataSet: TDataSet);
begin
  MarkDoppeltQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

function TAuswertungsmod.saveBriefText(data: TJSONObject): TJSONObject;
var
  mem : TMemoryStream;
  bw_id : integer;
  ma_id : integer;
begin
  Result := TJSONObject.Create;

  bw_id := JInt( data, 'bw_id');
  ma_id := JInt( data, 'ma_id');

  JRemove(data, 'bw_id');
  JRemove( data, 'ma_id');

  mem := TMemoryStream.Create;
  saveJSON(data, mem);

  try
    SetBriefStreamQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    SetBriefStreamQry.ParamByName('BW_ID').AsInteger := bw_id;
    SetBriefStreamQry.ParamByName('MA_ID').AsInteger := ma_id;
    SetBriefStreamQry.ParamByName('BW_ERROR').AsString := JString( data, 'status');
    SetBriefStreamQry.ParamByName('BW_DATA').AsStream  := mem;

    SetBriefStreamQry.ExecSQL;

    if SetBriefStreamQry.RowsAffected =1  then
      JResult(result, true, 'Die Daten wurden gespeichert.')
    else
      JResult( result, false, 'Der Datensatz wurde nicht gefünden!');
  except
    on e : exception do
    begin
      JResult( result, false, e.ToString)
    end;
  end;
  mem.Free;

end;

function TAuswertungsmod.start(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  if not TPhasenMod.phaseActive(SAZ) then
  begin
    JResult( result, false, 'Die Auswertung ist nicht aktiv!');
    exit;
  end;

  // unvollständige unterlagen
  Mark.ExecSQL;
  // doppelt Wähler.
  MarkDoppeltQry.ExecSQL;

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

