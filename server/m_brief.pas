unit m_brief;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, m_db,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON;

type
  TBriefWahlMod = class(TDSServerModule)
    MaList: TFDQuery;
    MaListQry: TDataSetProvider;
    MaBw: TFDQuery;
    MaBwQry: TDataSetProvider;
    procedure MaListBeforeOpen(DataSet: TDataSet);
    procedure MaBwBeforeOpen(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    function setEvent( data : TJSONObject ) : TJSONObject;
    function setInvalid( data : TJSONObject ) : TJSONObject;
    function removeInvalid( data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TBriefWahlMod.MaBwBeforeOpen(DataSet: TDataSet);
begin
  MaBw.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

procedure TBriefWahlMod.MaListBeforeOpen(DataSet: TDataSet);
begin
  MaList.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

function TBriefWahlMod.removeInvalid(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TBriefWahlMod.setEvent(data: TJSONObject): TJSONObject;
var
  maid : integer;
  waid : integer;
begin
  Result := TJSONObject.Create;
  waid := DBMod.WahlID;

end;

function TBriefWahlMod.setInvalid(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

end.

