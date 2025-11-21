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
  [TRoleAuth(roWahlVorsitz + ' ' +roWahlVorstand)]
  TUserMod = class(TDSServerModule)
    User: TFDQuery;
    UserQry: TDataSetProvider;
    FDTransaction1: TFDTransaction;
    UpdateUserLogin: TFDQuery;
    UpdateUserMail: TFDQuery;
    GetUserID: TFDQuery;
    procedure UserBeforeOpen(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    function setUserData( data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses u_json, m_log;

{$R *.dfm}

function TUserMod.setUserData(data: TJSONObject): TJSONObject;
var
  action : string;
  mail   : string;
  login  : string;
  persnr : string;
  ma_id  : integer;
  count  : integer;
begin
  Result := TJSONObject.Create;

  action := JString( data, 'action');
  persnr := JString( data, 'persnr');
  mail   := JString( data, 'mail');
  login  := JString( data, 'login');

  ma_id := -1;
  GetUserID.ParamByName('WA_ID').AsInteger    := DBMod.WahlID;
  GetUserID.ParamByName('MA_PERSNR').AsString := persnr;
  GetUserID.Open;
  if not GetUserID.IsEmpty then
  begin
    ma_id := GetUserID.FieldByName('MA_ID').AsInteger;
  end;
  GetUserID.Close;


  if ma_id <> -1 then
  begin
    if SameText(action, 'update') then
    begin
      count := 0;
      UpdateUserLogin.ParamByName('ma_id').AsInteger := ma_id;
      UpdateUserLogin.ParamByName('MW_LOGIN').AsString := login;
      UpdateUserLogin.ExecSQL;
      count := count + UpdateUserLogin.RowsAffected;

      UpdateUserMail.ParamByName('ma_id').AsInteger := ma_id;
      UpdateUserMail.ParamByName('ma_mail').AsString:= mail;
      UpdateUserMail.ExecSQL;
      count := count + UpdateUserMail.RowsAffected;

      if count > 0 then
        JResult( result, true, 'Die Daten wurden aktualisiert.')
      else
        JResult( result, true, 'Es wurden keine Änderungen erkannt.');

      Savelog(True, 'Update login', formatJSON(data));
    end;
  end
  else
    JResult( result, false, 'Der Benutzer wurde nicht gefunden!');
end;

procedure TUserMod.UserBeforeOpen(DataSet: TDataSet);
begin
  User.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

end.

