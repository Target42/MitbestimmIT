unit m_VorschlaglistenImport;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON, u_json,
  FireDAC.Stan.Intf, FireDAC.Comp.Client, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, m_db;

type
  TDSVorschlagListenImport = class(TDSServerModule)
    FDTransaction1: TFDTransaction;
    GetQrpQry: TFDQuery;
    DeleteMAQry: TFDQuery;
    DeleteListeQry: TFDQuery;
    AddlisteQry: TFDQuery;
    InsertMaQry: TFDQuery;
    FindMAQry: TFDQuery;
  private
    m_list : TJSONArray;
    procedure cleanold( data : TJSONObject );
    procedure addNew( data  : TJSONObject );

    procedure deleteList(  id : integer );
    function findlist( kurz : string ) :integer;
    function addNewList( name, kurz : string ) : Integer;

  public
    function Import( data : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  m_phase, u_BRWahlFristen;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDSVorschlagListenImport }

procedure TDSVorschlagListenImport.addNew(data: TJSONObject);
var
  name, kurz : string;
  id  : integer;
  arr : TJSONArray;
  person : TJSONObject;
  i : integer;

  obj : TJSONObject;
  err : TJSONArray;
  ok  : TJSONArray;
begin

  err := TJSONArray.Create;
  ok  := TJSONArray.Create;

  name := JString( data, 'name');
  kurz := JString( data, 'kurz');

  obj := TJSONObject.Create;
  JReplace( obj, 'name', name);
  JReplace( obj, 'kurz', kurz);

  cleanold(data);

  id := addNewList(name, kurz);
  arr := JArray( data, 'personen');
  if Assigned(arr) then
  begin
    for i := 0 to pred(arr.Count) do
    begin
      person := getRow(arr, i);
      FindMAQry.ParamByName('MA_PERSNR').AsString := JString( person, 'persnr');
      FindMAQry.Open;
      if FindMAQry.IsEmpty then
      begin
        err.Add(JString( person, 'persnr'));
      end
      else
      begin
        ok.Add(JString( person, 'persnr'));
        InsertMaQry.ParamByName('WA_ID').AsInteger      := DBMod.WahlID;
        InsertMaQry.ParamByName('MA_ID').AsInteger      := FindMAQry.FieldByName('MA_ID').AsInteger;
        InsertMaQry.ParamByName('WT_ID').AsInteger      := id;
        InsertMaQry.ParamByName('WT_WA_POS').AsInteger  := i + 1;
        InsertMaQry.ParamByName('WT_WA_JOB').AsString   := JString( person, 'job');

        InsertMaQry.ExecSQL;
      end;
      FindMAQry.Close;
    end;
  end;
  JReplace( obj, 'ok', ok);
  JReplace( obj, 'error', err);
  m_list.AddElement(obj);
end;

function TDSVorschlagListenImport.addNewList(name, kurz: string): Integer;
begin
  AddlisteQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  AddlisteQry.ParamByName('WT_NAME').AsString:= name;
  AddlisteQry.ParamByName('WT_KURZ').AsString:= kurz;
  AddlisteQry.ExecSQL;

  Result := findlist(kurz);
end;

procedure TDSVorschlagListenImport.cleanold(data: TJSONObject);
var
  name, kurz : string;
  id  : integer;
begin
  name := JString( data, 'name');
  kurz := JString( data, 'kurz');

  id := findlist(kurz);
  if id <> 0 then
  begin
    deleteList( id );
  end;
end;

procedure TDSVorschlagListenImport.deleteList(id: integer);
begin
  DeleteMAQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  DeleteMAQry.ParamByName('WT_ID').AsInteger := id;
  DeleteMAQry.ExecSQL;

  DeleteListeQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  DeleteListeQry.ParamByName('WT_ID').AsInteger := id;
  DeleteListeQry.ExecSQL;
end;

function TDSVorschlagListenImport.findlist(kurz: string): integer;
begin
  Result := 0;
  GetQrpQry.ParamByName('wa_id').AsInteger := DBMod.WahlID;
  GetQrpQry.ParamByName('kurz').AsString := kurz;
  GetQrpQry.Open;
  if not GetQrpQry.IsEmpty then
  begin
    Result := GetQrpQry.FieldByName('WT_ID').AsInteger;
  end;
  GetQrpQry.Close;
end;

function TDSVorschlagListenImport.Import(data: TJSONObject): TJSONObject;
var
  i : integer;
  pages : TJSONArray;
  row   : TJSONObject;
begin
  Result := TJSONObject.Create;
  if not TPhasenMod.phaseActive(EWV) then
  begin
    JResult( result, false, 'Es können keinen Änderungen mehr an den Wahllisten vorgenommen werden!');
    exit;
  end;
  m_list:= TJSONArray.Create;
  pages := JArray( data, 'pages');
  if Assigned( pages) then
  begin
    FDTransaction1.StartTransaction;
    for i := 0 to pred(pages.Count) do
    begin
      row := getRow( pages, i);

      addNew(row);
    end;
    FDTransaction1.Commit;
  end;
  JReplace( result, 'listen', m_list);
  JResult( result, true, '');
end;

end.

