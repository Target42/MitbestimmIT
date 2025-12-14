unit m_wahl;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, u_rollen, u_imageinfo;

type
  [TRoleAuth(roWahlVorsitz)]
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
    WAtabWA_TYP: TIntegerField;
    WahlListWA_TYP: TIntegerField;
    UpdateTypeQry: TFDQuery;
    DeletePhasenQry: TFDQuery;
    FDTransaction1: TFDTransaction;
    WFTab: TFDTable;
    WFTabWA_ID: TIntegerField;
    WFTabWF_ID: TIntegerField;
    WFTabWF_TITEL: TStringField;
    WFTabWF_START: TSQLTimeStampField;
    WFTabWF_ENDE: TSQLTimeStampField;
    WFTabWF_TYP: TIntegerField;
    PhasenQrx: TFDQuery;
    FDTransaction2: TFDTransaction;
    WAtabWA_PIC_NAME: TStringField;
    FristenCount: TFDQuery;
    UpdateFristQry: TFDQuery;
    procedure WahlListBeforeOpen(DataSet: TDataSet);
    procedure WahlListWA_SIMUGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure WahlListWA_ACTIVEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private-Deklarationen }
  public
    [TRoleAuth(roPublic)]
    function getWahlData : TJSONObject;

    function saveWahlData( data : TJSONObject ) : TJSONObject;
    function updateWahlData( data : TJSONObject ) : TJSONObject;
    function loadWahlData : TJSONObject;
    function uploadImage(info : TImageInfo) : TJSONObject;

    [TRoleAuth(roPublic)]
    function setWahl( id : integer ) : Boolean;
    [TRoleAuth(roPublic)]
    function getLogo : TImageInfo;

    function hasWahl : boolean;

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_db, DSSession, u_json, m_log;

{$R *.dfm}

{ TWahlMod }

function TWahlMod.getLogo: TImageInfo;
var
  mem: TMemoryStream;
begin
  Result := TImageInfo.Create;
  Result.FileName := '';

  SetLength(Result.Data, 0);

  WAtab.Open;
  try
    if WAtab.Locate('WA_ID', DBMod.WahlID, []) then
    begin
      Result.FileName := WAtabWA_PIC_NAME.AsString;

      if not WAtabWA_DATA.IsNull then
      begin
        mem := TMemoryStream.Create;
        try
          WAtabWA_DATA.SaveToStream(mem);
          mem.Position := 0;

          SetLength(Result.Data, mem.Size);
          if mem.Size > 0 then
            mem.Read(Result.Data[0], mem.Size);
        finally
          mem.Free;
        end;
      end;
    end;
  finally
    WAtab.Close;
  end;
end;

function TWahlMod.getWahlData: TJSONObject;
begin
  Result := TJSONObject.Create;
  WahlDataQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  WahlDataQry.Open;

  if not WahlDataQry.IsEmpty  then
  begin
    JReplace(result, 'titel', WahlDataQry.FieldByName('WA_TITLE').AsString);
    JReplace(result, 'simulation', WahlDataQry.FieldByName('WA_SIMU').AsBoolean);
  end;
  WahlDataQry.Close;
end;

function TWahlMod.hasWahl: boolean;
begin
  FristenCount.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  FristenCount.Open;
  Result := FristenCount.FieldByName('count').AsInteger > 0;
  FristenCount.Close;
end;

function TWahlMod.loadWahlData: TJSONObject;
var
  arr : TJSONArray;
  row : TJSONObject;
begin
  Result := TJSONObject.Create;
  WahlDataQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  WahlDataQry.Open;

  if not WahlDataQry.IsEmpty  then
  begin

    JReplace(result, 'titel', WahlDataQry.FieldByName('WA_TITLE').AsString);
    JReplace(result, 'simulation', WahlDataQry.FieldByName('WA_SIMU').AsBoolean);
    JReplace(result, 'typ', WahlDataQry.FieldByName('WA_TYP').AsInteger );

    arr := TJSONArray.Create;

    PhasenQrx.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    PhasenQrx.Open;
    while not PhasenQrx.Eof do
    begin
      row := TJSONObject.Create;
      JReplace( row, 'nr',    PhasenQrx.FieldByName('WF_ID').AsInteger -1);
      JReplace( row, 'titel', PhasenQrx.FieldByName('WF_TITEL').AsString );
      JReplaceDouble( row, 'start', PhasenQrx.FieldByName('WF_START').AsDateTime);
      JReplaceDouble( row, 'ende', PhasenQrx.FieldByName('WF_ENDE').AsDateTime);
      JReplace( row, 'typ', PhasenQrx.FieldByName('WF_TYP').AsInteger);
      arr.Add(row);
      PhasenQrx.Next;
    end;
    PhasenQrx.Close;
    JReplace(result, 'phasen', arr);
  end;
  WahlDataQry.Close;
end;

function TWahlMod.saveWahlData(data: TJSONObject): TJSONObject;
var
  arr : TJSONArray;
  i   : integer;
  row : TJSONObject;
  wa_id : integer;
begin
  Result := TJSONObject.Create;
  wa_id  := DBMod.WahlID;
  FDTransaction1.StartTransaction;

  UpdateTypeQry.ParamByName('WA_ID').AsInteger := wa_id;
  UpdateTypeQry.ParamByName('WA_TYP').AsInteger:= JInt( data, 'verfahren');
  UpdateTypeQry.ExecSQL;

  arr := JArray( data, 'phasen');
  if arr.Count > 0 then
  begin
    DeletePhasenQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    DeletePhasenQry.ExecSQL;
    WFTab.Open;
    for i := 0 to pred(arr.Count) do
    begin
      row := getRow(arr, i);
      WFTab.Append;
      WFTabWA_ID.AsInteger     := wa_id;
      WFTabWF_ID.AsInteger     := i+1;
      WFTabWF_TITEL.AsString   := JString( row, 'titel');
      WFTabWF_START.AsDateTime := JDouble( row, 'start');
      WFTabWF_ENDE.AsDateTime  := JDouble( row, 'ende');
      WFTabWF_TYP.AsInteger    := JInt( row, 'typ');
      WFTab.Post;
    end;
  end;
  if FDTransaction1.Active then
    FDTransaction1.Commit;
  WFTab.Close;
  Savelog(true, 'Wahl: save', formatJSON(data));
end;

function TWahlMod.setWahl(id: integer): Boolean;
var
  session : TDSSession;
  data    : TJSONObject;
begin
  result := false;
  session := TDSSessionManager.GetThreadSession;

  CheckMAIDQry.ParamByName('MA_ID').AsInteger := DBMod.UserID;;
  CheckMAIDQry.ParamByName('WA_ID').AsInteger := id;
  CheckMAIDQry.Open;
  if not CheckMAIDQry.IsEmpty then
  begin
    session.PutData('WahlID', CheckMAIDQry.FieldByName('WA_ID').AsString);

    data := TJSONObject.Create;
    JReplace( data, 'user',     session.GetData('UserName'));
    JReplace( data, 'remoteip', session.GetData('remoteip'));
    JReplace( data, 'wahl',    id );

    Savelog( true, 'wahl', formatJSON(data));
    data.Free;

    result := true;
  end;
  CheckMAIDQry.Close;
end;

function TWahlMod.updateWahlData(data: TJSONObject): TJSONObject;
var
  arr : TJSONArray;
  i   : integer;
  row : TJSONObject;
begin
  Result := TJSONObject.Create;

  FDTransaction1.StartTransaction;
  UpdateFristQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;

  arr := JArray( data, 'phasen');
  if arr.Count > 0 then
  begin

    for i := 0 to pred(arr.Count) do
    begin
      row := getRow(arr, i);
      UpdateFristQry.ParamByName('WF_ID').AsInteger := i + 1;

      UpdateFristQry.ParamByName('WF_START').AsTime := JDouble( row, 'start');
      UpdateFristQry.ParamByName('WF_ENDE').AsTime := JDouble( row, 'start');
      UpdateFristQry.ExecSQL;

    end;
  end;
  if FDTransaction1.Active then
    FDTransaction1.Commit;
  Savelog(true, 'Wahl: save', formatJSON(data));
end;

function TWahlMod.uploadImage(info : TImageInfo): TJSONObject;
var
  mem: TMemoryStream;
begin
  Result := TJSONObject.Create;
  WAtab.Open;
  if WAtab.Locate('WA_ID', DBMod.WahlID, []) then
  begin
    WAtab.Edit;
    WAtabWA_PIC_NAME.AsString := info.FileName;

    // *** TBytes-Array in TMemoryStream laden ***
    mem := TMemoryStream.Create;
    try
      if Length(info.Data) > 0 then
        mem.Write(info.Data[0], Length(info.Data));

      mem.Position := 0; // Zurück an den Anfang für die Datenbank
      WAtabWA_DATA.LoadFromStream(mem);
    finally
      mem.Free;
    end;

    WAtab.Post;
    JResult(Result, true, '');
  end
  else
    JResult(Result, false, 'Wahl nicht gefunden!');
  WAtab.Close;
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

