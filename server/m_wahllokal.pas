unit m_wahllokal;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, m_db,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, Datasnap.Provider, u_rollen, System.JSON,
  CodeSiteLogging;

type
//  [ TRoleAuth(roWahlVorsitz + ' '+ roWahlVorstand + ' ' + roWahlHelfer)]
  TWahlLokalMod = class(TDSServerModule)
    Wahllokale: TFDQuery;
    FDTransaction1: TFDTransaction;
    WahllokaleQry: TDataSetProvider;
    MAListe: TFDQuery;
    MaListrQry: TDataSetProvider;
    CheckUserQry: TFDQuery;
    InsertUserQry: TFDQuery;
    GetTimestampQry: TFDQuery;
    FindUserQry: TFDQuery;
    MAListeMA_ID: TIntegerField;
    MAListeMA_PERSNR: TStringField;
    MAListeMA_NAME: TStringField;
    MAListeMA_VORNAME: TStringField;
    MAListeMA_GENDER: TStringField;
    MAListeMA_ABTEILUNG: TStringField;
    MAListeMA_GEB: TDateField;
    MAListeWL_BAU: TStringField;
    MAListeWL_STOCKWERK: TStringField;
    MAListeWL_RAUM: TStringField;
    MAListeWL_TIMESTAMP: TSQLTimeStampField;
    WAUpdate: TFDQuery;
    WAUpdateQry: TDataSetProvider;
    procedure WahllokaleBeforeOpen(DataSet: TDataSet);
    procedure FDQuery1BeforeOpen(DataSet: TDataSet);
    procedure MAListeBeforeOpen(DataSet: TDataSet);
    procedure WAUpdateBeforeOpen(DataSet: TDataSet);
  private
    function findUser( wa_id, ma_id, wl_id : integer ) : Boolean;
  public
    function start( data : TJSONObject ) : TJSONObject;
    function ende( data : TJSONObject ) : TJSONObject;
    function wahl( data : TJSONObject ) : TJSONObject;
    function invalid(data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  u_json, DSSession;

{$R *.dfm}

function TWahlLokalMod.ende(data: TJSONObject): TJSONObject;
var
  session : TDSSession;
begin
  CodeSite.EnterMethod('ende');
  CodeSite.send(formatJSON(data));

  Result := TJSONObject.Create;

  session := TDSSessionManager.GetThreadSession;
  session.RemoveData('helferid');
  session.RemoveData('lokalid');

  JResult( result, true, 'Der Wahlhelfer wurde abgemeldet.');

  CodeSite.ExitMethod('ende');
end;

procedure TWahlLokalMod.FDQuery1BeforeOpen(DataSet: TDataSet);
begin
  MAListe.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

function TWahlLokalMod.findUser(wa_id, ma_id, wl_id: integer): Boolean;
begin
  FindUserQry.ParamByName('WL_ID').AsInteger := wl_id;
  FindUserQry.ParamByName('WA_ID').AsInteger := wa_id;
  FindUserQry.ParamByName('MA_ID').AsInteger := ma_id;
  FindUserQry.Open;
  result := not FindUserQry.IsEmpty;
  FindUserQry.Close;
end;

function TWahlLokalMod.invalid(data: TJSONObject): TJSONObject;
begin
  CodeSite.EnterMethod('invalid');
  CodeSite.send(formatJSON(data));


  Result := TJSONObject.Create;

  CodeSite.ExitMethod('invalid');
end;

procedure TWahlLokalMod.MAListeBeforeOpen(DataSet: TDataSet);
begin
  CodeSite.EnterMethod('MAListeBeforeOpen');
  try
    MAListe.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    CodeSite.send('wahl: %d', [DBMod.WahlID]);
  except
    on e : exception do
    begin
      CodeSite.SendError(e.toString);
    end;
  end;
  CodeSite.ExitMethod('MAListeBeforeOpen');

end;

function TWahlLokalMod.start(data: TJSONObject): TJSONObject;
var
  wlid : integer;
  maid : integer;
  ok   : boolean;
  session : TDSSession;
begin
  CodeSite.EnterMethod('start');
  CodeSite.send(formatJSON(data));

  Result := TJSONObject.Create;

  wlid := JInt(data, 'lokalid' );
  maid := JInt( data, 'maid');
  if maid < 1 then
    maid := DBMod.UserID;

  CheckUserQry.ParamByName('wa_id').AsInteger := DBMod.WahlID;
  CheckUserQry.ParamByName('ma_id').AsInteger := maid;
  CheckUserQry.ParamByName('WL_ID').AsInteger := wlid;

  CheckUserQry.Open;
  ok := CheckUserQry.RecordCount = 1;
  CheckUserQry.Close;

  session := TDSSessionManager.GetThreadSession;
  if ok then
  begin
    session.PutData('helferid', IntToSTr(maid));
    session.PutData('lokalid', IntToStr(wlid));
    JResult( result, ok, '');
  end
  else
  begin
    session.RemoveData('helferid');
    session.RemoveData('lokalid');

    JResult( result, false, 'Der Wahlhelfer wurde nicht gefunden.');
  end;

  CodeSite.ExitMethod('start');
end;

function TWahlLokalMod.wahl(data: TJSONObject): TJSONObject;
var
  waid : integeR;
  maid : integer;
  wlid : integer;
  session : TDSSession;
  ok      : boolean;
  s       :  string;
begin
  CodeSite.EnterMethod('wahl');
  CodeSite.send(formatJSON(data));

  Result := TJSONObject.Create;

  session := TDSSessionManager.GetThreadSession;
  maid := JInt( data, 'maid');

  if session.HasData('lokalid') then
  begin
    wlid := StrToInt(session.GetData('lokalid'));
    waid := DBMod.WahlID;

    ok := false;
    if not findUser( waid, maid, wlid) then
    begin
      InsertUserQry.ParamByName('WL_ID').AsInteger := wlid;
      InsertUserQry.ParamByName('MA_ID').AsInteger := maid;
      InsertUserQry.ParamByName('WA_ID').AsInteger := waid;
      InsertUserQry.ExecSQL;
      ok := InsertUserQry.RowsAffected = 1;
    end;

    GetTimestampQry.ParamByName('WL_ID').AsInteger := wlid;
    GetTimestampQry.ParamByName('MA_ID').AsInteger := maid;
    GetTimestampQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    GetTimestampQry.Open;
    if not GetTimestampQry.IsEmpty then
    begin
      s := FormatDateTime( 'dd.MM.yyyy hh:mm', GetTimestampQry.FieldByName('WL_TIMESTAMP').AsDateTime);
      JReplace( result, 'bau', GetTimestampQry.FieldByName('WL_BAU').AsString );
      JReplace( result, 'stockwerk', GetTimestampQry.FieldByName('WL_STOCKWERK').AsString );
      JReplace( result, 'raum', GetTimestampQry.FieldByName('WL_RAUM').AsString );
      JReplace( result, 'stamp', s);
    end;
    GetTimestampQry.Close;

    if ok then
      JResult( result, ok, 'ok')
    else
      JResult( result, ok, Format('Es wurde schon um %s gewählt.', [s]));
  end
  else
  begin
    JResult( result, false, 'Das Wahllokal konnte nicht identifiziert werden,');
  end;
  CodeSite.ExitMethod('wahl');
end;

procedure TWahlLokalMod.WahllokaleBeforeOpen(DataSet: TDataSet);
begin
  CodeSite.EnterMethod('WahllokaleBeforeOpen');
  try
    Wahllokale.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    Wahllokale.ParamByName('MA_ID').AsInteger := DBMod.UserID;
    CodeSite.send('wahl: %d maid : %d', [DBMod.WahlID, DBMod.UserID]);
  except
    on e : exception do
    begin
      CodeSite.SendError(e.toString);
    end;
  end;
  CodeSite.ExitMethod('WahllokaleBeforeOpen');
end;

procedure TWahlLokalMod.WAUpdateBeforeOpen(DataSet: TDataSet);
begin
  WAUpdate.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

end.

