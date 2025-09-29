unit m_admin;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, Data.DB, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.Provider, System.JSON;

type
  TAdminMod = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDTransaction1: TFDTransaction;
    TabWahl: TFDTable;
    WahlTab: TDataSetProvider;
    NewWahlTab: TFDTable;
    MATab: TFDTable;
    WVTab: TFDTable;
    NewWahlTabWA_ID: TIntegerField;
    NewWahlTabWA_TITLE: TStringField;
    NewWahlTabWA_SIMU: TStringField;
    NewWahlTabWA_ACTIVE: TStringField;
    MATabMA_ID: TFDAutoIncField;
    MATabWA_ID: TIntegerField;
    MATabMA_PERSNR: TStringField;
    MATabMA_NAME: TStringField;
    MATabMA_VORNAME: TStringField;
    MATabMA_GENDER: TStringField;
    MATabMA_ABTEILUNG: TStringField;
    MATabMA_MAIL: TStringField;
    WVTabMA_ID: TIntegerField;
    WVTabWA_ID: TIntegerField;
    WVTabWV_ROLLE: TStringField;
    PwdTab: TFDTable;
    PwdTabMA_ID: TIntegerField;
    PwdTabWA_ID: TIntegerField;
    PwdTabMW_PWD: TStringField;
    PwdTabMW_ROLLE: TStringField;
    PwdTabMW_SECRET: TStringField;
    PwdTabMW_LOGIN: TStringField;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    function connectDB : boolean;
  public
    function NeueWahl( data : TJSONObject ) :TJSONObject;
    function ResetPwd( data : TJSONObject ) :TJSONObject;
  end;

implementation

uses
  u_glob, u_json, system.Hash, u_totp, FireDAC.Phys.IBWrapper, u_pwd;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TAdminMod }

function TAdminMod.connectDB : boolean;
begin
  Result := false;

  with FDConnection1 do
  begin
    try
      Connected := true;
      Result := Connected;
    except

    end;
  end;
end;


procedure TAdminMod.DSServerModuleCreate(Sender: TObject);
begin
  with FDConnection1.Params as TFDPhysFBConnectionDefParams do
  begin
    Database := glob.DBName;
    UserName := 'admin_user';
    RoleName := 'appadmin';
    Password := glob.AdminPwd;
    if Glob.DBEmbedded then
    begin
      Server := '';
      Protocol := ipLocal;
    end
    else
    begin
      Server   := Glob.DBHost;
      Protocol := ipTCPIP;
    end;
  end;
  FDConnection1.LoginPrompt := false;
end;

function TAdminMod.NeueWahl(data: TJSONObject): TJSONObject;
var
  wahl : TJSONObject;
  wv   : TJSONObject;
  simu : boolean;
  secret : string;

  function addWahl( sim : Boolean ) :Integer;
  begin
    NewWahlTab.Append;
    NewWahlTabWA_TITLE.AsString := JString( wahl, 'name');
    if not sim then
      NewWahlTabWA_SIMU.AsString := 'F'
    else
      NewWahlTabWA_SIMU.AsString := 'T';
    NewWahlTabWA_ACTIVE.AsString := 'T';

    NewWahlTab.Post;

    result := NewWahlTabWA_ID.AsInteger;
  end;

  function addMA(waid : integer) : integer;
  begin
    MATab.Append;
    MATabWA_ID.AsInteger      := waid;
    MATabMA_PERSNR.AsString   := JString( wv, 'persnr');
    MATabMA_NAME.AsString     := JString( wv, 'name');
    MATabMA_VORNAME.AsString  := JString( wv, 'vorname');
    MATab.Post;

    Result := MATabMA_ID.AsInteger;
  end;

  procedure addWV( waid, maid : integer );
  begin
    WVTab.Append;
    WVTabMA_ID.AsInteger := maid;
    WVTabWA_ID.AsInteger := waid;
    WVTabWV_ROLLE.AsString := 'Vorstand';
    WVTab.Post;
  end;

  procedure addPwd( waid, maid : integer );
  begin
    PwdTab.Append;
    PwdTabMA_ID.AsInteger   := maid;
    PwdTabWA_ID.AsInteger   := waid;
    PwdTabMW_ROLLE.AsString := 'Vorstand';
    PwdTabMW_SECRET.AsString:= GenerateBase32Secret();
    PwdTabMW_LOGIN.AsString := JString( wv, 'login');
    PwdTabMW_PWD.AsString   := CalcPwdHash(JString( wv, 'pwd'));
    PwdTab.Post;
  end;


var
  waid : integer;
  maid : integer;
begin
  connectDB;

  Result := TJSONObject.Create;

  wahl := JObject( data, 'wahl');
  wv   := JObject(data, 'vorstand');

  simu := JBool( wahl, 'simu');

  secret := GenerateBase32Secret;

  NewWahlTab.Open;
  MATab.Open;
  WVTab.Open;
  PwdTab.Open;


  try
    waid := addWahl(False);
    maid := addMA(waid);
    addWV( waid, maid);
    addPwd(waid, maid);

    if simu then
    begin
      waid := addWahl(true);
      maid := addMA(waid);
      addWV( waid, maid);
      addPwd(waid, maid);

    end;
    JResult( result, true, Format('Die Wahl "%s" wurde angelegt!', [JString(wahl, 'name')]));
  except
    on e: Exception do
    begin
      JResult( result, false, format('Fehler:%s%s', [sLineBreak, e.ToString]));
    end;

  end;

  NewWahlTab.close;
  MATab.close;
  WVTab.close;
  PwdTab.Close;

end;

function TAdminMod.ResetPwd(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

end.

