unit m_sim;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON;

type
  TDSSim = class(TDSServerModule)
  private
    { Private-Deklarationen }
  public
    function getBasisData : TJSONObject;
    function setSimData( data : TJSONObject ) : TJSONObject;
    function Auswertung( data : TJSONObject ) : TJSONObject;
  end;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDSSim }

function TDSSim.Auswertung(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TDSSim.getBasisData: TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TDSSim.setSimData(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

end.

