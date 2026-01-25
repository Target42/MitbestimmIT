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
    Helfer: TFDQuery;
    HelferQry: TDataSetProvider;
    procedure WahllokaleBeforeOpen(DataSet: TDataSet);
    procedure FDQuery1BeforeOpen(DataSet: TDataSet);
    procedure MAListeBeforeOpen(DataSet: TDataSet);
    procedure WAUpdateBeforeOpen(DataSet: TDataSet);
    procedure HelferBeforeOpen(DataSet: TDataSet);
  private
    function findUser( wa_id, ma_id, wl_id : integer ) : Boolean;
  public
    function start( data : TJSONObject ) : TJSONObject;
    function ende( data : TJSONObject ) : TJSONObject;
    function wahl( data : TJSONObject ) : TJSONObject;
    function invalid(data : TJSONObject ) : TJSONObject;

    function wechsel(data : TJSONObject ) : TJSONObject;
    function getHelfer : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  u_json, DSSession, u_helper, u_pwd, u_glob, m_pwd, m_phase, u_BRWahlFristen;

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

function TWahlLokalMod.getHelfer: TJSONObject;
var
  ma_id : integer;
  session : TDSSession;
begin
  Result := TJSONObject.Create;
  session := TDSSessionManager.GetThreadSession;

  if session.HasData('helferid') then
  begin
    ma_id := StrToIntDef(session.GetData('helferid'), -1);

    if ma_id <> -1 then
    begin
      Helfer.Open;
      JResult( Result, false, 'Kein Helfer gefunden!');
      while not Helfer.Eof do
      begin
        if Helfer.FieldByName('MA_ID').AsInteger = ma_id then
        begin
          JReplace( result, 'name', Helfer.FieldByName('ma_name').AsString);
          JReplace( result, 'vorname', Helfer.FieldByName('ma_vorname').AsString);
          JReplace( result, 'abteilung', Helfer.FieldByName('ma_abteilung').AsString);
          JResult( Result, true, 'Helfer gefunden!');
          break;
        end;

        Helfer.Next;
      end;
      Helfer.Close;
    end
    else
      JResult( Result, false, 'Kein Helfer gefunden!');
  end
  else
    JResult( Result, false, 'Es ist niemand angemeldet');
end;

procedure TWahlLokalMod.HelferBeforeOpen(DataSet: TDataSet);
begin
  Helfer.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
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
  if not TPhasenMod.phaseActive(BBW) then
  begin
    JResult( result, false, 'Es können keinen Änderungen mehr an den Wahllisten vorgenommen werden!');
    CodeSite.SendError('Die Wahlphase ist abgeschlossen');
    CodeSite.ExitMethod('wahl');
    exit;
  end;

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

function TWahlLokalMod.wechsel(data: TJSONObject): TJSONObject;
var
  wl_id : integer;
  ma_id : integer;
  ok    : boolean;
  pwd   : string;
  oldpwd : string;
  session : TDSSession;
begin
  ok := false;
  Result := TJSONObject.Create;
  session := TDSSessionManager.GetThreadSession;

  wl_id  := -1;
  ma_id  := JInt( data,    'maid', -1);
  pwd    := JString( data, 'pwd');
  oldpwd := JString( data, 'oldpwd');

  if session.HasData('lokalid') then
  begin
    wl_id := StrToIntDef(session.getData('lokalid'), -1);
  end;


  if wl_id <> -1 then
  begin
    CheckUserQry.ParamByName('wa_id').AsInteger := DBMod.WahlID;
    CheckUserQry.ParamByName('ma_id').AsInteger := ma_id;
    CheckUserQry.ParamByName('WL_ID').AsInteger := wl_id;

    CheckUserQry.Open;
    ok := CheckUserQry.RecordCount = 1;
    CheckUserQry.Close;

      if ok then
      begin
        case TPwdCheckMod.checkUserMod(ma_id, pwd) of
          TPwdCheckMod.TResultTyp.rtUnknown:
          begin
            JResult(result, ok, 'Irgendwas ist falsch !!');
            session.putData('helferid', intToStr(ma_id));
          end;
          TPwdCheckMod.TResultTyp.rtNoUser:       JResult(result, ok, 'Der User isnt ubekannt!');
          TPwdCheckMod.TResultTyp.rtWrongPwd:     JResult(result, ok, 'Das neue Passwort ist falsch!');
          TPwdCheckMod.TResultTyp.rtOldPwdWrong:  JResult(result, ok, 'Der Passwort des alten Besitzers ist falsch!');
          TPwdCheckMod.TResultTyp.rtOk:
          begin
            JResult(result, ok, 'Der Wahlhelfer wurde gewechselt!');
            session.PutData('helferid', IntToSTr(ma_id));
          end;
        end;
    end;
  end
  else
    JResult(result, ok, 'Kein passendes Wahllokal gefunden!');
end;

end.

