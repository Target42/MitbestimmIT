unit m_waehler;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.Provider,
  System.JSON;

type
  TWaehlerMod = class(TDSServerModule)
    Mitarbeiter: TFDTable;
    MitarbeiterTab: TDataSetProvider;
  private
    { Private-Deklarationen }
  public
    function import( data : TJSONObject ) :TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses m_db;

{$R *.dfm}

{ TWaehlerMod }

function TWaehlerMod.import(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

end.

