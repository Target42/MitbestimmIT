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
    FDQuery1: TFDQuery;
    WahlList: TFDQuery;
    WahlListQry: TDataSetProvider;
    WahlListWA_ID: TIntegerField;
    WahlListWA_TITLE: TStringField;
    WahlListWA_SIMU: TStringField;
    WahlListWA_ACTIVE: TStringField;
    WahlListMA_ID: TIntegerField;
    procedure WahlListBeforeOpen(DataSet: TDataSet);
    procedure WahlListWA_SIMUGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure WahlListWA_ACTIVEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private-Deklarationen }
  public
    function getWahlData( waid : integer) : TJSONObject;
    function saveWahlData( data : TJSONObject ) : TJSONObject;
    function setWahl( id : integer ) : Boolean;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_db, DSSession;

{$R *.dfm}

{ TWahlMod }

function TWahlMod.getWahlData(waid : integer): TJSONObject;
begin
  Result := TJSONObject.Create;

end;

function TWahlMod.saveWahlData(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TWahlMod.setWahl(id: integer): Boolean;
begin

end;

procedure TWahlMod.WahlListBeforeOpen(DataSet: TDataSet);
var
  session : TDSSession;
  ma_id : integeR;
begin
  ma_id := 0;

  session := TDSSessionManager.GetThreadSession;
  if session.HasData('UserID') then
    ma_id := StrToIntDef(Session.GetData('UserID'), 0);

  WahlList.ParamByName('MA_ID').AsInteger := ma_id;
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

