//
// Erzeugt vom DataSnap-Proxy-Generator.
// 02.09.2025 19:40:26
// 

unit u_stub;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TAdminModClient = class(TDSAdminClient)
  private
    FNeueWahlCommand: TDBXCommand;
    FResetPwdCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function NeueWahl(data: TJSONObject): TJSONObject;
    function ResetPwd(data: TJSONObject): TJSONObject;
  end;

implementation

function TAdminModClient.NeueWahl(data: TJSONObject): TJSONObject;
begin
  if FNeueWahlCommand = nil then
  begin
    FNeueWahlCommand := FDBXConnection.CreateCommand;
    FNeueWahlCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FNeueWahlCommand.Text := 'TAdminMod.NeueWahl';
    FNeueWahlCommand.Prepare;
  end;
  FNeueWahlCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FNeueWahlCommand.ExecuteUpdate;
  Result := TJSONObject(FNeueWahlCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TAdminModClient.ResetPwd(data: TJSONObject): TJSONObject;
begin
  if FResetPwdCommand = nil then
  begin
    FResetPwdCommand := FDBXConnection.CreateCommand;
    FResetPwdCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FResetPwdCommand.Text := 'TAdminMod.ResetPwd';
    FResetPwdCommand.Prepare;
  end;
  FResetPwdCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FResetPwdCommand.ExecuteUpdate;
  Result := TJSONObject(FResetPwdCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TAdminModClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TAdminModClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TAdminModClient.Destroy;
begin
  FNeueWahlCommand.Free;
  FResetPwdCommand.Free;
  inherited;
end;

end.
