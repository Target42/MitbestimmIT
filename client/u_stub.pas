//
// Erzeugt vom DataSnap-Proxy-Generator.
// 19.10.2025 13:40:13
//

unit u_stub;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TAdminModClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FNeueWahlCommand: TDBXCommand;
    FResetPwdCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function NeueWahl(data: TJSONObject): TJSONObject;
    function ResetPwd(data: TJSONObject): TJSONObject;
  end;

  TLoginModClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FWATabWA_SIMUGetTextCommand: TDBXCommand;
    FWATabWA_SIMUSetTextCommand: TDBXCommand;
    FcheckLoginCommand: TDBXCommand;
    FcheckTOTPCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure WATabWA_SIMUGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure WATabWA_SIMUSetText(Sender: TField; Text: string);
    function checkLogin(data: TJSONObject): TJSONObject;
    function checkTOTP(code: string; utctime: TDateTime): TJSONObject;
  end;

  TWahlModClient = class(TDSAdminClient)
  private
    FWahlListBeforeOpenCommand: TDBXCommand;
    FWahlListWA_SIMUGetTextCommand: TDBXCommand;
    FWahlListWA_ACTIVEGetTextCommand: TDBXCommand;
    FgetWahlDataCommand: TDBXCommand;
    FsaveWahlDataCommand: TDBXCommand;
    FloadWahlDataCommand: TDBXCommand;
    FsetWahlCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure WahlListBeforeOpen(DataSet: TDataSet);
    procedure WahlListWA_SIMUGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure WahlListWA_ACTIVEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    function getWahlData: TJSONObject;
    function saveWahlData(data: TJSONObject): TJSONObject;
    function loadWahlData: TJSONObject;
    function setWahl(id: Integer): Boolean;
  end;

  TWaehlerModClient = class(TDSAdminClient)
  private
    FMAQryBeforeOpenCommand: TDBXCommand;
    FimportCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure MAQryBeforeOpen(DataSet: TDataSet);
    function import(data: TJSONObject): TJSONObject;
  end;

implementation

procedure TAdminModClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TAdminMod.DSServerModuleCreate';
    FDSServerModuleCreateCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FDSServerModuleCreateCommand.ExecuteUpdate;
end;

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
  FDSServerModuleCreateCommand.Free;
  FNeueWahlCommand.Free;
  FResetPwdCommand.Free;
  inherited;
end;

procedure TLoginModClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TLoginMod.DSServerModuleCreate';
    FDSServerModuleCreateCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FDSServerModuleCreateCommand.ExecuteUpdate;
end;

procedure TLoginModClient.WATabWA_SIMUGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if FWATabWA_SIMUGetTextCommand = nil then
  begin
    FWATabWA_SIMUGetTextCommand := FDBXConnection.CreateCommand;
    FWATabWA_SIMUGetTextCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FWATabWA_SIMUGetTextCommand.Text := 'TLoginMod.WATabWA_SIMUGetText';
    FWATabWA_SIMUGetTextCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FWATabWA_SIMUGetTextCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FWATabWA_SIMUGetTextCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FWATabWA_SIMUGetTextCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FWATabWA_SIMUGetTextCommand.Parameters[1].Value.SetWideString(Text);
  FWATabWA_SIMUGetTextCommand.Parameters[2].Value.SetBoolean(DisplayText);
  FWATabWA_SIMUGetTextCommand.ExecuteUpdate;
  Text := FWATabWA_SIMUGetTextCommand.Parameters[1].Value.GetWideString;
end;

procedure TLoginModClient.WATabWA_SIMUSetText(Sender: TField; Text: string);
begin
  if FWATabWA_SIMUSetTextCommand = nil then
  begin
    FWATabWA_SIMUSetTextCommand := FDBXConnection.CreateCommand;
    FWATabWA_SIMUSetTextCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FWATabWA_SIMUSetTextCommand.Text := 'TLoginMod.WATabWA_SIMUSetText';
    FWATabWA_SIMUSetTextCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FWATabWA_SIMUSetTextCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FWATabWA_SIMUSetTextCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FWATabWA_SIMUSetTextCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FWATabWA_SIMUSetTextCommand.Parameters[1].Value.SetWideString(Text);
  FWATabWA_SIMUSetTextCommand.ExecuteUpdate;
end;

function TLoginModClient.checkLogin(data: TJSONObject): TJSONObject;
begin
  if FcheckLoginCommand = nil then
  begin
    FcheckLoginCommand := FDBXConnection.CreateCommand;
    FcheckLoginCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FcheckLoginCommand.Text := 'TLoginMod.checkLogin';
    FcheckLoginCommand.Prepare;
  end;
  FcheckLoginCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FcheckLoginCommand.ExecuteUpdate;
  Result := TJSONObject(FcheckLoginCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TLoginModClient.checkTOTP(code: string; utctime: TDateTime): TJSONObject;
begin
  if FcheckTOTPCommand = nil then
  begin
    FcheckTOTPCommand := FDBXConnection.CreateCommand;
    FcheckTOTPCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FcheckTOTPCommand.Text := 'TLoginMod.checkTOTP';
    FcheckTOTPCommand.Prepare;
  end;
  FcheckTOTPCommand.Parameters[0].Value.SetWideString(code);
  FcheckTOTPCommand.Parameters[1].Value.AsDateTime := utctime;
  FcheckTOTPCommand.ExecuteUpdate;
  Result := TJSONObject(FcheckTOTPCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

constructor TLoginModClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TLoginModClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TLoginModClient.Destroy;
begin
  FDSServerModuleCreateCommand.Free;
  FWATabWA_SIMUGetTextCommand.Free;
  FWATabWA_SIMUSetTextCommand.Free;
  FcheckLoginCommand.Free;
  FcheckTOTPCommand.Free;
  inherited;
end;

procedure TWahlModClient.WahlListBeforeOpen(DataSet: TDataSet);
begin
  if FWahlListBeforeOpenCommand = nil then
  begin
    FWahlListBeforeOpenCommand := FDBXConnection.CreateCommand;
    FWahlListBeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FWahlListBeforeOpenCommand.Text := 'TWahlMod.WahlListBeforeOpen';
    FWahlListBeforeOpenCommand.Prepare;
  end;
  FWahlListBeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FWahlListBeforeOpenCommand.ExecuteUpdate;
end;

procedure TWahlModClient.WahlListWA_SIMUGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if FWahlListWA_SIMUGetTextCommand = nil then
  begin
    FWahlListWA_SIMUGetTextCommand := FDBXConnection.CreateCommand;
    FWahlListWA_SIMUGetTextCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FWahlListWA_SIMUGetTextCommand.Text := 'TWahlMod.WahlListWA_SIMUGetText';
    FWahlListWA_SIMUGetTextCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FWahlListWA_SIMUGetTextCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FWahlListWA_SIMUGetTextCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FWahlListWA_SIMUGetTextCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FWahlListWA_SIMUGetTextCommand.Parameters[1].Value.SetWideString(Text);
  FWahlListWA_SIMUGetTextCommand.Parameters[2].Value.SetBoolean(DisplayText);
  FWahlListWA_SIMUGetTextCommand.ExecuteUpdate;
  Text := FWahlListWA_SIMUGetTextCommand.Parameters[1].Value.GetWideString;
end;

procedure TWahlModClient.WahlListWA_ACTIVEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if FWahlListWA_ACTIVEGetTextCommand = nil then
  begin
    FWahlListWA_ACTIVEGetTextCommand := FDBXConnection.CreateCommand;
    FWahlListWA_ACTIVEGetTextCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FWahlListWA_ACTIVEGetTextCommand.Text := 'TWahlMod.WahlListWA_ACTIVEGetText';
    FWahlListWA_ACTIVEGetTextCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FWahlListWA_ACTIVEGetTextCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FWahlListWA_ACTIVEGetTextCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FWahlListWA_ACTIVEGetTextCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FWahlListWA_ACTIVEGetTextCommand.Parameters[1].Value.SetWideString(Text);
  FWahlListWA_ACTIVEGetTextCommand.Parameters[2].Value.SetBoolean(DisplayText);
  FWahlListWA_ACTIVEGetTextCommand.ExecuteUpdate;
  Text := FWahlListWA_ACTIVEGetTextCommand.Parameters[1].Value.GetWideString;
end;

function TWahlModClient.getWahlData: TJSONObject;
begin
  if FgetWahlDataCommand = nil then
  begin
    FgetWahlDataCommand := FDBXConnection.CreateCommand;
    FgetWahlDataCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetWahlDataCommand.Text := 'TWahlMod.getWahlData';
    FgetWahlDataCommand.Prepare;
  end;
  FgetWahlDataCommand.ExecuteUpdate;
  Result := TJSONObject(FgetWahlDataCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TWahlModClient.saveWahlData(data: TJSONObject): TJSONObject;
begin
  if FsaveWahlDataCommand = nil then
  begin
    FsaveWahlDataCommand := FDBXConnection.CreateCommand;
    FsaveWahlDataCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsaveWahlDataCommand.Text := 'TWahlMod.saveWahlData';
    FsaveWahlDataCommand.Prepare;
  end;
  FsaveWahlDataCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FsaveWahlDataCommand.ExecuteUpdate;
  Result := TJSONObject(FsaveWahlDataCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TWahlModClient.loadWahlData: TJSONObject;
begin
  if FloadWahlDataCommand = nil then
  begin
    FloadWahlDataCommand := FDBXConnection.CreateCommand;
    FloadWahlDataCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FloadWahlDataCommand.Text := 'TWahlMod.loadWahlData';
    FloadWahlDataCommand.Prepare;
  end;
  FloadWahlDataCommand.ExecuteUpdate;
  Result := TJSONObject(FloadWahlDataCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TWahlModClient.setWahl(id: Integer): Boolean;
begin
  if FsetWahlCommand = nil then
  begin
    FsetWahlCommand := FDBXConnection.CreateCommand;
    FsetWahlCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsetWahlCommand.Text := 'TWahlMod.setWahl';
    FsetWahlCommand.Prepare;
  end;
  FsetWahlCommand.Parameters[0].Value.SetInt32(id);
  FsetWahlCommand.ExecuteUpdate;
  Result := FsetWahlCommand.Parameters[1].Value.GetBoolean;
end;

constructor TWahlModClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TWahlModClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TWahlModClient.Destroy;
begin
  FWahlListBeforeOpenCommand.Free;
  FWahlListWA_SIMUGetTextCommand.Free;
  FWahlListWA_ACTIVEGetTextCommand.Free;
  FgetWahlDataCommand.Free;
  FsaveWahlDataCommand.Free;
  FloadWahlDataCommand.Free;
  FsetWahlCommand.Free;
  inherited;
end;

procedure TWaehlerModClient.MAQryBeforeOpen(DataSet: TDataSet);
begin
  if FMAQryBeforeOpenCommand = nil then
  begin
    FMAQryBeforeOpenCommand := FDBXConnection.CreateCommand;
    FMAQryBeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FMAQryBeforeOpenCommand.Text := 'TWaehlerMod.MAQryBeforeOpen';
    FMAQryBeforeOpenCommand.Prepare;
  end;
  FMAQryBeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FMAQryBeforeOpenCommand.ExecuteUpdate;
end;

function TWaehlerModClient.import(data: TJSONObject): TJSONObject;
begin
  if FimportCommand = nil then
  begin
    FimportCommand := FDBXConnection.CreateCommand;
    FimportCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FimportCommand.Text := 'TWaehlerMod.import';
    FimportCommand.Prepare;
  end;
  FimportCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FimportCommand.ExecuteUpdate;
  Result := TJSONObject(FimportCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TWaehlerModClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TWaehlerModClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TWaehlerModClient.Destroy;
begin
  FMAQryBeforeOpenCommand.Free;
  FimportCommand.Free;
  inherited;
end;

end.

