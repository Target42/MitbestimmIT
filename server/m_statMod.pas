unit m_statMod;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TStadMod = class(TDSServerModule)
    MAQry: TFDQuery;
    ListenQry: TFDQuery;
    LokaleQry: TFDQuery;
    WahlQry: TFDQuery;
  private
    function getMAData : TJSONObject;
    function getWahlListen : TJSONArray;
    function getLokale : TJSONArray;
    function getWahl : TJSONArray;
  public
    function getStats : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses m_db, u_BER_Berechnungen, u_json;

{$R *.dfm}

{ TStadMod }

function TStadMod.getLokale: TJSONArray;
var
  row : TJSONObject;
begin
  Result := TJSONArray.Create;
  LokaleQry.ParamByName('wa_id').AsInteger := DBMod.WahlID;
  LokaleQry.open;
  while not LokaleQry.Eof do
  begin
    row := TJSONObject.Create;

    JReplace( row, 'bau',       LokaleQry.FieldByName('WL_BAU').AsString);
    JReplace( row, 'stockwerk', LokaleQry.FieldByName('WL_STOCKWERK').AsString);
    JReplace( row, 'raum',      LokaleQry.FieldByName('WL_RAUM').AsString);
    JReplace( row, 'count',     LokaleQry.FieldByName('count').AsString);
    result.Add(row);

    LokaleQry.Next;
  end;
  LokaleQry.Close;
end;

function TStadMod.getMAData: TJSONObject;
var
  m, w : integer;
  sitze : integer;
begin
  Result := TJSONObject.Create;

  m := 0;
  w := 0;

  MAQry.ParamByName('wa_id').AsInteger := DBMod.WahlID;
  MAQry.Open;
  while not MAQry.Eof do
  begin
    if MAQry.FieldByName('MA_GENDER').AsString = 'w' then
      w := MAQry.FieldByName('count').AsInteger
    else
      m := MAQry.FieldByName('count').AsInteger;

    MAQry.Next;
  end;
  MAQry.Close;

  JReplace( result, 'w', w );
  JReplace( result, 'm', m );
  JReplace( result, 'summe', m + w);

  sitze := BerechneBetriebsratsgroesse( m + w);
  JReplace( result, 'gremium',        sitze);
  JReplace( result, 'freistellungen', BerechneAnzahlFreistellungen( m + w ));
  JReplace( result, 'minmin',         MindestanzahlMinderheitengeschlecht( m, w, sitze ));

  if Minderheitengeschlecht(m, w) = gMale then
    JReplace( result, 'minderheit', 'Männer')
  else
    JReplace( result, 'minderheit', 'Frauen');

end;

function TStadMod.getStats: TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace( Result, 'ma',     getMAData);
  JReplace( Result, 'listen', getWahlListen);
  JReplace( result, 'lokale', getLokale);
  JReplace( result, 'wahl',   getWahl );
end;

function TStadMod.getWahl: TJSONArray;
var
  row : TJSONObject;
begin
  Result := TJSONArray.Create;
  WahlQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  WahlQry.Open;
  while not WahlQry.Eof do
  begin
    row := TJSONObject.Create;

    JReplace(row, 'titel', WahlQry.FieldByName('WF_TITEL').AsString);
    JReplace(row, 'typ', WahlQry.FieldByName('WF_TYP').AsInteger);
    JReplaceDouble( row, 'start', WahlQry.FieldByName('WF_START').AsDateTime);
    if WahlQry.FieldByName('WF_TYP').AsInteger > 1 then
      JReplaceDouble( row, 'ende', WahlQry.FieldByName('WF_ENDE').AsDateTime)
    else
      JReplaceDouble( row, 'ende', 0.0 );

    result.Add(row);
    WahlQry.Next;
  end;
  WahlQry.Close;
end;

function TStadMod.getWahlListen: TJSONArray;
var
  row : TJSONObject;
begin
  Result := TJSONArray.Create;
  ListenQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  ListenQry.Open;
  while not ListenQry.Eof do
  begin
    row := TJSONObject.Create;

    JReplace( row, 'name', ListenQry.FieldByName('WT_NAME').AsString);
    JReplace( row, 'kurz', ListenQry.FieldByName('WT_kurz').AsString);
    JReplace( row, 'count', ListenQry.FieldByName('count').AsString);
    result.Add(row);
    ListenQry.Next;
  end;
  ListenQry.Close;
end;

end.

