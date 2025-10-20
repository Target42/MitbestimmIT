unit m_lokale;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  m_db, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, System.JSON;

type
  TLokaleMod = class(TDSServerModule)
    Lokale: TFDQuery;
    LokaleQry: TDataSetProvider;
    procedure LokaleBeforeOpen(DataSet: TDataSet);
    procedure LokaleBeforePost(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    function get( id : integer ) : TJSONObject;
    function add( data : TJSONObject ) : TJSONObject;
    function save( data : TJSONObject ) : TJSONObject;
    function delete(data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses u_json;


{$R *.dfm}

function TLokaleMod.add(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TLokaleMod.delete(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TLokaleMod.get(id: integer): TJSONObject;
begin
  Result := TJSONObject.Create;
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
begin
  Result := TJSONObject.Create;
end;

end.

