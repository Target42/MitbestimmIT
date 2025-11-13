unit m_user;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, u_rollen, m_db,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON;

type
  [TRoleAuth(roWahlVorsitz, roWahlVorstand)]
  TUserMod = class(TDSServerModule)
    User: TFDQuery;
    UserQry: TDataSetProvider;
    procedure UserBeforeOpen(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    function setUserData( data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses u_json;

{$R *.dfm}

function TUserMod.setUserData(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

procedure TUserMod.UserBeforeOpen(DataSet: TDataSet);
begin
  User.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

end.

