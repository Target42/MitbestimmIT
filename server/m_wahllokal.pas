unit m_wahllokal;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, m_db,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, Datasnap.Provider, u_rollen, System.JSON;

type
  [TRoleAuth(roWahlVorsitz + ' '+ roWahlVorstand + ' ' + roWahlHelfer)]
  TWahlLokalMod = class(TDSServerModule)
    Wahllokale: TFDQuery;
    FDTransaction1: TFDTransaction;
    WahllokaleQry: TDataSetProvider;
    procedure WahllokaleBeforeOpen(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    function wahl( data : TJSONObject ) : TJSONObject;
    function invalid(data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TWahlLokalMod.invalid(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TWahlLokalMod.wahl(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

procedure TWahlLokalMod.WahllokaleBeforeOpen(DataSet: TDataSet);
begin
  Wahllokale.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  Wahllokale.ParamByName('MA_ID').AsInteger := DBMod.UserID;
end;

end.

