//
// Erzeugt vom DataSnap-Proxy-Generator.
// 01.11.2025 16:22:30
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
    FMitarbeiterBeforeOpenCommand: TDBXCommand;
    FimportCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure MitarbeiterBeforeOpen(DataSet: TDataSet);
    function import(data: TJSONObject): TJSONObject;
  end;

  TLokaleModClient = class(TDSAdminClient)
  private
    FLokaleBeforeOpenCommand: TDBXCommand;
    FLokaleBeforePostCommand: TDBXCommand;
    FHelferBeforeOpenCommand: TDBXCommand;
    FDelHelferBeforeOpenCommand: TDBXCommand;
    FAddHelferQryBeforeOpenCommand: TDBXCommand;
    FgetCommand: TDBXCommand;
    FaddCommand: TDBXCommand;
    FsaveCommand: TDBXCommand;
    FdeleteCommand: TDBXCommand;
    FaddHelferCommand: TDBXCommand;
    FsaveHelferCommand: TDBXCommand;
    FdeleteHelferCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure LokaleBeforeOpen(DataSet: TDataSet);
    procedure LokaleBeforePost(DataSet: TDataSet);
    procedure HelferBeforeOpen(DataSet: TDataSet);
    procedure DelHelferBeforeOpen(DataSet: TDataSet);
    procedure AddHelferQryBeforeOpen(DataSet: TDataSet);
    function get(id: Integer): TJSONObject;
    function add(data: TJSONObject): TJSONObject;
    function save(data: TJSONObject): TJSONObject;
    function delete(id: Integer): TJSONObject;
    function addHelfer(data: TJSONObject): TJSONObject;
    function saveHelfer(data: TJSONObject): TJSONObject;
    function deleteHelfer(data: TJSONObject): TJSONObject;
  end;

  TVortandModClient = class(TDSAdminClient)
  private
    FgetlistCommand: TDBXCommand;
    FaddCommand: TDBXCommand;
    FgetCommand: TDBXCommand;
    FsaveCommand: TDBXCommand;
    FdeleteCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function getlist: TJSONObject;
    function add(data: TJSONObject): TJSONObject;
    function get(ma_id: Integer): TJSONObject;
    function save(data: TJSONObject): TJSONObject;
    function delete(data: TJSONObject): TJSONObject;
  end;

  TWahlListeModClient = class(TDSAdminClient)
  private
    FWahlListeBeforeOpenCommand: TDBXCommand;
    FWahllisteMABeforeOpenCommand: TDBXCommand;
    FaddCommand: TDBXCommand;
    FsaveCommand: TDBXCommand;
    FdeleteCommand: TDBXCommand;
    FaddMACommand: TDBXCommand;
    FsaveMACommand: TDBXCommand;
    FdeleteMACommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure WahlListeBeforeOpen(DataSet: TDataSet);
    procedure WahllisteMABeforeOpen(DataSet: TDataSet);
    function add(data: TJSONObject): TJSONObject;
    function save(data: TJSONObject): TJSONObject;
    function delete(data: TJSONObject): TJSONObject;
    function addMA(data: TJSONObject): TJSONObject;
    function saveMA(data: TJSONObject): TJSONObject;
    function deleteMA(data: TJSONObject): TJSONObject;
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

procedure TWaehlerModClient.MitarbeiterBeforeOpen(DataSet: TDataSet);
begin
  if FMitarbeiterBeforeOpenCommand = nil then
  begin
    FMitarbeiterBeforeOpenCommand := FDBXConnection.CreateCommand;
    FMitarbeiterBeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FMitarbeiterBeforeOpenCommand.Text := 'TWaehlerMod.MitarbeiterBeforeOpen';
    FMitarbeiterBeforeOpenCommand.Prepare;
  end;
  FMitarbeiterBeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FMitarbeiterBeforeOpenCommand.ExecuteUpdate;
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
  FMitarbeiterBeforeOpenCommand.Free;
  FimportCommand.Free;
  inherited;
end;

procedure TLokaleModClient.LokaleBeforeOpen(DataSet: TDataSet);
begin
  if FLokaleBeforeOpenCommand = nil then
  begin
    FLokaleBeforeOpenCommand := FDBXConnection.CreateCommand;
    FLokaleBeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FLokaleBeforeOpenCommand.Text := 'TLokaleMod.LokaleBeforeOpen';
    FLokaleBeforeOpenCommand.Prepare;
  end;
  FLokaleBeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FLokaleBeforeOpenCommand.ExecuteUpdate;
end;

procedure TLokaleModClient.LokaleBeforePost(DataSet: TDataSet);
begin
  if FLokaleBeforePostCommand = nil then
  begin
    FLokaleBeforePostCommand := FDBXConnection.CreateCommand;
    FLokaleBeforePostCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FLokaleBeforePostCommand.Text := 'TLokaleMod.LokaleBeforePost';
    FLokaleBeforePostCommand.Prepare;
  end;
  FLokaleBeforePostCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FLokaleBeforePostCommand.ExecuteUpdate;
end;

procedure TLokaleModClient.HelferBeforeOpen(DataSet: TDataSet);
begin
  if FHelferBeforeOpenCommand = nil then
  begin
    FHelferBeforeOpenCommand := FDBXConnection.CreateCommand;
    FHelferBeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FHelferBeforeOpenCommand.Text := 'TLokaleMod.HelferBeforeOpen';
    FHelferBeforeOpenCommand.Prepare;
  end;
  FHelferBeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FHelferBeforeOpenCommand.ExecuteUpdate;
end;

procedure TLokaleModClient.DelHelferBeforeOpen(DataSet: TDataSet);
begin
  if FDelHelferBeforeOpenCommand = nil then
  begin
    FDelHelferBeforeOpenCommand := FDBXConnection.CreateCommand;
    FDelHelferBeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDelHelferBeforeOpenCommand.Text := 'TLokaleMod.DelHelferBeforeOpen';
    FDelHelferBeforeOpenCommand.Prepare;
  end;
  FDelHelferBeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FDelHelferBeforeOpenCommand.ExecuteUpdate;
end;

procedure TLokaleModClient.AddHelferQryBeforeOpen(DataSet: TDataSet);
begin
  if FAddHelferQryBeforeOpenCommand = nil then
  begin
    FAddHelferQryBeforeOpenCommand := FDBXConnection.CreateCommand;
    FAddHelferQryBeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAddHelferQryBeforeOpenCommand.Text := 'TLokaleMod.AddHelferQryBeforeOpen';
    FAddHelferQryBeforeOpenCommand.Prepare;
  end;
  FAddHelferQryBeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FAddHelferQryBeforeOpenCommand.ExecuteUpdate;
end;

function TLokaleModClient.get(id: Integer): TJSONObject;
begin
  if FgetCommand = nil then
  begin
    FgetCommand := FDBXConnection.CreateCommand;
    FgetCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetCommand.Text := 'TLokaleMod.get';
    FgetCommand.Prepare;
  end;
  FgetCommand.Parameters[0].Value.SetInt32(id);
  FgetCommand.ExecuteUpdate;
  Result := TJSONObject(FgetCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TLokaleModClient.add(data: TJSONObject): TJSONObject;
begin
  if FaddCommand = nil then
  begin
    FaddCommand := FDBXConnection.CreateCommand;
    FaddCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FaddCommand.Text := 'TLokaleMod.add';
    FaddCommand.Prepare;
  end;
  FaddCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FaddCommand.ExecuteUpdate;
  Result := TJSONObject(FaddCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TLokaleModClient.save(data: TJSONObject): TJSONObject;
begin
  if FsaveCommand = nil then
  begin
    FsaveCommand := FDBXConnection.CreateCommand;
    FsaveCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsaveCommand.Text := 'TLokaleMod.save';
    FsaveCommand.Prepare;
  end;
  FsaveCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FsaveCommand.ExecuteUpdate;
  Result := TJSONObject(FsaveCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TLokaleModClient.delete(id: Integer): TJSONObject;
begin
  if FdeleteCommand = nil then
  begin
    FdeleteCommand := FDBXConnection.CreateCommand;
    FdeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteCommand.Text := 'TLokaleMod.delete';
    FdeleteCommand.Prepare;
  end;
  FdeleteCommand.Parameters[0].Value.SetInt32(id);
  FdeleteCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TLokaleModClient.addHelfer(data: TJSONObject): TJSONObject;
begin
  if FaddHelferCommand = nil then
  begin
    FaddHelferCommand := FDBXConnection.CreateCommand;
    FaddHelferCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FaddHelferCommand.Text := 'TLokaleMod.addHelfer';
    FaddHelferCommand.Prepare;
  end;
  FaddHelferCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FaddHelferCommand.ExecuteUpdate;
  Result := TJSONObject(FaddHelferCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TLokaleModClient.saveHelfer(data: TJSONObject): TJSONObject;
begin
  if FsaveHelferCommand = nil then
  begin
    FsaveHelferCommand := FDBXConnection.CreateCommand;
    FsaveHelferCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsaveHelferCommand.Text := 'TLokaleMod.saveHelfer';
    FsaveHelferCommand.Prepare;
  end;
  FsaveHelferCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FsaveHelferCommand.ExecuteUpdate;
  Result := TJSONObject(FsaveHelferCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TLokaleModClient.deleteHelfer(data: TJSONObject): TJSONObject;
begin
  if FdeleteHelferCommand = nil then
  begin
    FdeleteHelferCommand := FDBXConnection.CreateCommand;
    FdeleteHelferCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteHelferCommand.Text := 'TLokaleMod.deleteHelfer';
    FdeleteHelferCommand.Prepare;
  end;
  FdeleteHelferCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FdeleteHelferCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteHelferCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TLokaleModClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TLokaleModClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TLokaleModClient.Destroy;
begin
  FLokaleBeforeOpenCommand.Free;
  FLokaleBeforePostCommand.Free;
  FHelferBeforeOpenCommand.Free;
  FDelHelferBeforeOpenCommand.Free;
  FAddHelferQryBeforeOpenCommand.Free;
  FgetCommand.Free;
  FaddCommand.Free;
  FsaveCommand.Free;
  FdeleteCommand.Free;
  FaddHelferCommand.Free;
  FsaveHelferCommand.Free;
  FdeleteHelferCommand.Free;
  inherited;
end;

function TVortandModClient.getlist: TJSONObject;
begin
  if FgetlistCommand = nil then
  begin
    FgetlistCommand := FDBXConnection.CreateCommand;
    FgetlistCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetlistCommand.Text := 'TVortandMod.getlist';
    FgetlistCommand.Prepare;
  end;
  FgetlistCommand.ExecuteUpdate;
  Result := TJSONObject(FgetlistCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TVortandModClient.add(data: TJSONObject): TJSONObject;
begin
  if FaddCommand = nil then
  begin
    FaddCommand := FDBXConnection.CreateCommand;
    FaddCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FaddCommand.Text := 'TVortandMod.add';
    FaddCommand.Prepare;
  end;
  FaddCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FaddCommand.ExecuteUpdate;
  Result := TJSONObject(FaddCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TVortandModClient.get(ma_id: Integer): TJSONObject;
begin
  if FgetCommand = nil then
  begin
    FgetCommand := FDBXConnection.CreateCommand;
    FgetCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FgetCommand.Text := 'TVortandMod.get';
    FgetCommand.Prepare;
  end;
  FgetCommand.Parameters[0].Value.SetInt32(ma_id);
  FgetCommand.ExecuteUpdate;
  Result := TJSONObject(FgetCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TVortandModClient.save(data: TJSONObject): TJSONObject;
begin
  if FsaveCommand = nil then
  begin
    FsaveCommand := FDBXConnection.CreateCommand;
    FsaveCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsaveCommand.Text := 'TVortandMod.save';
    FsaveCommand.Prepare;
  end;
  FsaveCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FsaveCommand.ExecuteUpdate;
  Result := TJSONObject(FsaveCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TVortandModClient.delete(data: TJSONObject): TJSONObject;
begin
  if FdeleteCommand = nil then
  begin
    FdeleteCommand := FDBXConnection.CreateCommand;
    FdeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteCommand.Text := 'TVortandMod.delete';
    FdeleteCommand.Prepare;
  end;
  FdeleteCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FdeleteCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TVortandModClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TVortandModClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TVortandModClient.Destroy;
begin
  FgetlistCommand.Free;
  FaddCommand.Free;
  FgetCommand.Free;
  FsaveCommand.Free;
  FdeleteCommand.Free;
  inherited;
end;

procedure TWahlListeModClient.WahlListeBeforeOpen(DataSet: TDataSet);
begin
  if FWahlListeBeforeOpenCommand = nil then
  begin
    FWahlListeBeforeOpenCommand := FDBXConnection.CreateCommand;
    FWahlListeBeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FWahlListeBeforeOpenCommand.Text := 'TWahlListeMod.WahlListeBeforeOpen';
    FWahlListeBeforeOpenCommand.Prepare;
  end;
  FWahlListeBeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FWahlListeBeforeOpenCommand.ExecuteUpdate;
end;

procedure TWahlListeModClient.WahllisteMABeforeOpen(DataSet: TDataSet);
begin
  if FWahllisteMABeforeOpenCommand = nil then
  begin
    FWahllisteMABeforeOpenCommand := FDBXConnection.CreateCommand;
    FWahllisteMABeforeOpenCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FWahllisteMABeforeOpenCommand.Text := 'TWahlListeMod.WahllisteMABeforeOpen';
    FWahllisteMABeforeOpenCommand.Prepare;
  end;
  FWahllisteMABeforeOpenCommand.Parameters[0].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FWahllisteMABeforeOpenCommand.ExecuteUpdate;
end;

function TWahlListeModClient.add(data: TJSONObject): TJSONObject;
begin
  if FaddCommand = nil then
  begin
    FaddCommand := FDBXConnection.CreateCommand;
    FaddCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FaddCommand.Text := 'TWahlListeMod.add';
    FaddCommand.Prepare;
  end;
  FaddCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FaddCommand.ExecuteUpdate;
  Result := TJSONObject(FaddCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TWahlListeModClient.save(data: TJSONObject): TJSONObject;
begin
  if FsaveCommand = nil then
  begin
    FsaveCommand := FDBXConnection.CreateCommand;
    FsaveCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsaveCommand.Text := 'TWahlListeMod.save';
    FsaveCommand.Prepare;
  end;
  FsaveCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FsaveCommand.ExecuteUpdate;
  Result := TJSONObject(FsaveCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TWahlListeModClient.delete(data: TJSONObject): TJSONObject;
begin
  if FdeleteCommand = nil then
  begin
    FdeleteCommand := FDBXConnection.CreateCommand;
    FdeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteCommand.Text := 'TWahlListeMod.delete';
    FdeleteCommand.Prepare;
  end;
  FdeleteCommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FdeleteCommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TWahlListeModClient.addMA(data: TJSONObject): TJSONObject;
begin
  if FaddMACommand = nil then
  begin
    FaddMACommand := FDBXConnection.CreateCommand;
    FaddMACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FaddMACommand.Text := 'TWahlListeMod.addMA';
    FaddMACommand.Prepare;
  end;
  FaddMACommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FaddMACommand.ExecuteUpdate;
  Result := TJSONObject(FaddMACommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TWahlListeModClient.saveMA(data: TJSONObject): TJSONObject;
begin
  if FsaveMACommand = nil then
  begin
    FsaveMACommand := FDBXConnection.CreateCommand;
    FsaveMACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FsaveMACommand.Text := 'TWahlListeMod.saveMA';
    FsaveMACommand.Prepare;
  end;
  FsaveMACommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FsaveMACommand.ExecuteUpdate;
  Result := TJSONObject(FsaveMACommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TWahlListeModClient.deleteMA(data: TJSONObject): TJSONObject;
begin
  if FdeleteMACommand = nil then
  begin
    FdeleteMACommand := FDBXConnection.CreateCommand;
    FdeleteMACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FdeleteMACommand.Text := 'TWahlListeMod.deleteMA';
    FdeleteMACommand.Prepare;
  end;
  FdeleteMACommand.Parameters[0].Value.SetJSONValue(data, FInstanceOwner);
  FdeleteMACommand.ExecuteUpdate;
  Result := TJSONObject(FdeleteMACommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

constructor TWahlListeModClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TWahlListeModClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TWahlListeModClient.Destroy;
begin
  FWahlListeBeforeOpenCommand.Free;
  FWahllisteMABeforeOpenCommand.Free;
  FaddCommand.Free;
  FsaveCommand.Free;
  FdeleteCommand.Free;
  FaddMACommand.Free;
  FsaveMACommand.Free;
  FdeleteMACommand.Free;
  inherited;
end;

end.

