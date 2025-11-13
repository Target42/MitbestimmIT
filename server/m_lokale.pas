unit m_lokale;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  m_db, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, System.JSON, u_rollen;

type
  [TRoleAuth(roWahlVorstand)]
  TLokaleMod = class(TDSServerModule)
    Lokale: TFDQuery;
    LokaleQry: TDataSetProvider;
    WLTab: TFDTable;
    WLTabWA_ID: TIntegerField;
    WLTabWL_ID: TIntegerField;
    WLTabWL_BAU: TStringField;
    WLTabWL_STOCKWERK: TStringField;
    WLTabWL_RAUM: TStringField;
    WLTabWL_START: TSQLTimeStampField;
    WLTabWL_ENDE: TSQLTimeStampField;
    DelHelferQry: TFDQuery;
    DelRaumQry: TFDQuery;
    Helfer: TFDQuery;
    HelferQry: TDataSetProvider;
    UpdateHelferQry: TFDQuery;
    DelHelfer: TFDQuery;
    AddHelferQry: TFDQuery;
    MAPwdTab: TFDTable;
    FDTransaction1: TFDTransaction;
    procedure LokaleBeforeOpen(DataSet: TDataSet);
    procedure LokaleBeforePost(DataSet: TDataSet);
    procedure HelferBeforeOpen(DataSet: TDataSet);
    procedure DelHelferBeforeOpen(DataSet: TDataSet);
    procedure AddHelferQryBeforeOpen(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    // Wahllokale
    function get( id : integer ) : TJSONObject;
    function add( data : TJSONObject ) : TJSONObject;
    function save( data : TJSONObject ) : TJSONObject;
    function delete(id : integer ) : TJSONObject;

    // Wahlhelfer
    function addHelfer( data : TJSONObject ) :TJSONObject;
    function saveHelfer( data : TJSONObject ) :TJSONObject;
    function deleteHelfer( data : TJSONObject ) :TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  u_json, u_wahllokal, system.Variants, m_log;


{$R *.dfm}

function TLokaleMod.add(data: TJSONObject): TJSONObject;
var
  lokal : TWahlLokal;
begin
  Result := TJSONObject.Create;
  lokal  := TWahlLokal.create;
  lokal.fromJSON(data);

  WLTab.Open;
  WLTab.Append;
  WLTabWA_ID.AsInteger        := DBMod.WahlID;
  WLTabWL_BAU.AsString        := lokal.Building;
  WLTabWL_STOCKWERK.AsString  := lokal.Stockwerk;
  WLTabWL_RAUM.AsString       := lokal.Raum;
  WLTabWL_START.AsDateTime    := lokal.Von;
  WLTabWL_ENDE.AsDateTime     := lokal.Bis;
  try
    WLTab.Post;
    JResult( result, true, 'Der Raum wurde angelegt');
  except
    on e : exception do
    begin
      JResult( result, false, e.ToString);
    end;
  end;
  WLTab.Close;
  lokal.Free;

  SAveLog(true, 'Wahllokal: add', formatJSON(data));

end;

function TLokaleMod.addHelfer(data: TJSONObject): TJSONObject;
var
  id : integer;
begin
  id := JInt( data, 'maid');
  Result := TJSONObject.Create;
  AddHelferQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  AddHelferQry.ParamByName('WL_ID').AsInteger := JInt( data, 'raumid');
  AddHelferQry.ParamByName('MA_ID').AsInteger := id;
  AddHelferQry.ParamByName('WH_ROLLE').AsString  := JString( data, 'rolle');
  AddHelferQry.ExecSQL;

  MAPwdTab.Open;
  if not MAPwdTab.Locate('MA_ID', VarArrayOf([id]), []) then
  begin
    MAPwdTab.Append;
    MAPwdTab.FieldByName('MA_ID').AsInteger := id;

  end
  else
  begin
    MAPwdTab.Edit;
  end;

  MAPwdTab.FieldByName('MW_ROLLE').AsString := DBMod.AddRole(roWahlHelfer, MAPwdTab.FieldByName('MW_ROLLE').AsString );
  MAPwdTab.Post;

  MAPwdTab.Close;


  if AddHelferQry.RowsAffected = 0 then
    JResult( result, false, 'Es wurden kene Datensätze eingefügt')
  else
  begin
    JResult( result, true, Format('Es wurden %d Datensätze eingefügt', [AddHelferQry.RowsAffected]));
     SaveLog(true, 'Wahllokal: add helfer', formatJSON(data));
  end;

end;

procedure TLokaleMod.AddHelferQryBeforeOpen(DataSet: TDataSet);
begin
  AddHelferQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

function TLokaleMod.delete(id : integer): TJSONObject;
begin
  Result := TJSONObject.Create;

  try
    DelHelferQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    DelHelferQry.ParamByName('WL_ID').AsInteger := id;
    DelHelferQry.ExecSQL;


    DelRaumQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    DelRaumQry.ParamByName('WL_ID').AsInteger := id;
    DelRaumQry.ExecSQL;

    JResult( result, true, 'Der Raum wurde gelöscht.');
    SaveLog(true, 'Wahllokal: löschen', IntToStr(id));
  except
    on e : exception do
    begin
      JResult( result, false, e.ToString);
    end;

  end;
end;

function TLokaleMod.deleteHelfer(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;

  DelHelfer.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  DelHelfer.ParamByName('WL_ID').AsInteger := JInt( data, 'raumid');
  DelHelfer.ParamByName('MA_ID').AsInteger := JInt( data, 'maid');
  DelHelfer.ExecSQL;

  if DelHelfer.RowsAffected = 0 then
    JResult( result, false, 'Es wurden kene Datensätze gelöscht')
  else
  begin
    JResult( result, true, Format('Es wurden %d Datensätze gelöscht', [DelHelferQry.RowsAffected]));
     SAveLog(true, 'Wahllokal: delete helfer', formatJSON(data));
  end;
end;

procedure TLokaleMod.DelHelferBeforeOpen(DataSet: TDataSet);
begin
  DelHelferQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

function TLokaleMod.get(id: integer): TJSONObject;
var
  lokal : TWahlLokal;
begin
  Result := NIL;
  WLTab.Open;
  if WLTab.Locate('WA_ID;WL_ID', VarArrayOf([DBMod.WahlID, id]), []) then
  begin
    lokal  := TWahlLokal.create;

    lokal.ID        := WLTabWL_ID.AsInteger;
    lokal.Building  := WLTabWL_BAU.AsString;
    lokal.Stockwerk := WLTabWL_STOCKWERK.AsString;
    lokal.Raum      := WLTabWL_RAUM.AsString;
    lokal.Von       := WLTabWL_START.AsDateTime;
    lokal.Bis       := WLTabWL_ENDE.AsDateTime;

    Result := lokal.toJSON;

    lokal.Free;
  end
  else
  begin
    JResult( result, false, 'Der Raum wurde nicht gefunden.');
  end;
  WLTab.Close;
end;

procedure TLokaleMod.HelferBeforeOpen(DataSet: TDataSet);
begin
  Helfer.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

procedure TLokaleMod.LokaleBeforeOpen(DataSet: TDataSet);
begin
  Lokale.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

procedure TLokaleMod.LokaleBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('WA_ID').IsNull then
    DataSet.FieldByName('WA_ID').AsInteger := DBMod.WahlID;
end;

function TLokaleMod.save(data: TJSONObject): TJSONObject;
var
  lokal : TWahlLokal;
begin
  Result := TJSONObject.Create;
  lokal  := TWahlLokal.create;
  lokal.fromJSON(data);

  WLTab.Open;
  if WLTab.Locate('WA_ID;WL_ID', VarArrayOf([DBMod.WahlID, lokal.ID]), []) then
  begin
    WLTab.Edit;
    WLTabWA_ID.AsInteger        := DBMod.WahlID;
    WLTabWL_BAU.AsString        := lokal.Building;
    WLTabWL_STOCKWERK.AsString  := lokal.Stockwerk;
    WLTabWL_RAUM.AsString       := lokal.Raum;
    WLTabWL_START.AsDateTime    := lokal.Von;
    WLTabWL_ENDE.AsDateTime     := lokal.Bis;
    try
      WLTab.Post;
      JResult( result, true, 'Der Raum wurde gespeichert');
       SaveLog(true, 'Wahllokal: save', formatJSON(data));
    except
      on e : exception do
      begin
        JResult( result, false, e.ToString);
      end;
    end
  end
  else
  begin
    JResult( result, false, 'Der Raum wurde nicht gefunden.');
  end;

  WLTab.Close;
  lokal.Free;
end;

function TLokaleMod.saveHelfer(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;

  UpdateHelferQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  UpdateHelferQry.ParamByName('WL_ID').AsInteger := JInt( data, 'raumid');
  UpdateHelferQry.ParamByName('MA_ID').AsInteger := JInt( data, 'maid');
  UpdateHelferQry.ParamByName('WH_ROLLE').AsString:= JString(data, 'rolle');
  UpdateHelferQry.ExecSQL;

  if UpdateHelferQry.RowsAffected = 0 then
    JResult( result, false, 'Es wurden kene Datensätze aktualisiert')
  else
  begin
     SaveLog(true, 'Wahllokal: save Helfer', formatJSON(data));
    JResult( result, true, Format('Es wurden %d Datensätze aktualisiert', [UpdateHelferQry.RowsAffected]));
  end;

end;

end.

