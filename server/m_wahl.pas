unit m_wahl;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TWahlMod = class(TDSServerModule)
    WAtab: TFDTable;
    WAtabWA_ID: TIntegerField;
    WAtabWA_TITLE: TStringField;
    WAtabWA_SIMU: TStringField;
    WAtabWA_ACTIVE: TStringField;
    WAtabWA_DATA: TBlobField;
    FDQuery1: TFDQuery;
  private
    { Private-Deklarationen }
  public
    function getWahlData( waid : integer) : TJSONObject;
    function saveWahlData( data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses m_db;

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

end.

