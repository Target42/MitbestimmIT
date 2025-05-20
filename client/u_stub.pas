// 
// Erzeugt vom DataSnap-Proxy-Generator.
// 13.05.2025 20:07:36
// 

unit u_stub;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FhasConfigCommand: TDBXCommand;
    FsetInitialconfigCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function hasConfig: Boolean;
    function setInitialconfig(data: TJSONObject): TJSONObject;
  end;

implementation

function TServerMethods1Client.hasConfig: Boolean;
begin
  if FhasConfigCommand = nil then
  begin
    FhasConfigCommand := FDBXConnection.CreateCommand;
    FhasConfigCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FhasConfigCommand.Text := 'TServerMethods1.hasConfig';
    FhasConfigCommand.Prepare;
  end;
  FhasConfigCommand.ExecuteUpdate;
  Result := FhasConfigCommand.Parameters[0].Value.GetBoolean;
end;

function TServerMethods1Client.setInitialconfig(data: TJSONObject): TJSONObject;
begin
  if FsetInitialconfigCommand = nil then
  begin
    FsetInitialconfigCommand := FDBXConnection.CreateCommand;
    FsetInitialconfigCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsetInitialconfigCommand.Text := 'TServerMethods1.setInitialconfig';
    FsetInitialconfigCommand.Prepare;
  end;
  FsetInitialconfigCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FsetInitialconfigCommand.ExecuteUpdate;
  Result := TJSONObject(FsetInitialconfigCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FhasConfigCommand.Free;
  FsetInitialconfigCommand.Free;
  inherited;
end;

end.
