unit m_wahl;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider;

type
  TWahlMod = class(TDSServerModule)
    WAtab: TFDTable;
    WAtabWA_ID: TIntegerField;
    WAtabWA_TITLE: TStringField;
    WAtabWA_SIMU: TStringField;
    WAtabWA_ACTIVE: TStringField;
    WAtabWA_DATA: TBlobField;
    WahlList: TFDQuery;
    WahlListQry: TDataSetProvider;
    WahlListWA_ID: TIntegerField;
    WahlListWA_TITLE: TStringField;
    WahlListWA_SIMU: TStringField;
    WahlListWA_ACTIVE: TStringField;
    WahlListMA_ID: TIntegerField;
    CheckMAIDQry: TFDQuery;
    WahlDataQry: TFDQuery;
    procedure WahlListBeforeOpen(DataSet: TDataSet);
    procedure WahlListWA_SIMUGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure WahlListWA_ACTIVEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private-Deklarationen }
  public
    function getWahlData : TJSONObject;
    function saveWahlData( data : TJSONObject ) : TJSONObject;
    function setWahl( id : integer ) : Boolean;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_db, DSSession, u_json;

{$R *.dfm}

{ TWahlMod }

function TWahlMod.getWahlData: TJSONObject;
var
  session : TDSSession;
  wa_id : integer;
begin
  wa_id := 0;
  session := TDSSessionManager.GetThreadSession;
  if session.HasData('WA_ID') then
    wa_id := StrToIntDef(Session.GetData('WA_ID'), 0);

  Result := TJSONObject.Create;
  WahlDataQry.ParamByName('WA_ID').AsInteger := WA_ID;
  WahlDataQry.Open;
  if not WahlDataQry.IsEmpty  then
  begin
    JReplace(result, 'titel', WahlDataQry.FieldByName('WA_TITLE').AsString);
    JReplace(result, 'simulation', WahlDataQry.FieldByName('WA_SIMU').AsBoolean);
  end;
  WahlDataQry.Close;
end;

function TWahlMod.saveWahlData(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TWahlMod.setWahl(id: integer): Boolean;
var
  session : TDSSession;
begin
  result := false;
  session := TDSSessionManager.GetThreadSession;

  CheckMAIDQry.ParamByName('MA_ID').AsInteger := DBMod.UserID;;
  CheckMAIDQry.ParamByName('WA_ID').AsInteger := id;
  CheckMAIDQry.Open;
  if not CheckMAIDQry.IsEmpty then
  begin
    session.PutData('WA_ID', CheckMAIDQry.FieldByName('WA_ID').AsString);
    result := true;
  end;
  CheckMAIDQry.Close;
end;

procedure TWahlMod.WahlListBeforeOpen(DataSet: TDataSet);
begin
  WahlList.ParamByName('MA_ID').AsInteger := DBMod.UserID;
end;

procedure TWahlMod.WahlListWA_ACTIVEGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.AsString = 'T' then
    Text := 'Ja'
  else
    Text := 'Nein';
end;

procedure TWahlMod.WahlListWA_SIMUGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.AsString = 'T' then
    Text := 'Ja'
  else
    Text := 'Nein';

end;

end.

