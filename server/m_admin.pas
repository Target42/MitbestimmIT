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
    MATabMA_ID: TIntegerField;
    MATabWA_ID: TIntegerField;
    MATabMA_PERSNR: TStringField;
    MATabMA_NAME: TStringField;
    MATabMA_VORNAME: TStringField;
    MATabMA_GENDER: TStringField;
    MATabMA_ABTEILUNG: TStringField;
    WVTabMA_ID: TIntegerField;
    WVTabWA_ID: TIntegerField;
    WVTabWV_ROLLE: TStringField;
    WVTabWV_PWD: TStringField;
    WVTabWV_SECRET: TStringField;
  private
    function connectDB : boolean;
  public
    function NeueWahl( data : TJSONObject ) :TJSONObject;
    function ResetPwd( data : TJSONObject ) :TJSONObject;
  end;

implementation

uses
  u_glob, u_json, system.Hash, u_totp;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TAdminMod }

function TAdminMod.connectDB : boolean;
begin
  Result := false;

  with FDConnection1 do
  begin

    Params.Values['Database']  := Glob.DBName;
    Params.Values['User_Name'] := 'admin_user';
    Params.Values['Password']  := Glob.AdminPwd;
    Params.Values['RoleName']  := 'appadmin';

    if glob.DBEmbedded then
    begin
      Params.Values['Server'] := '';
      Params.Values['Protocol']  := 'local';
    end
    else
    begin
      Params.Values['Server'] := glob.DBHost;
    end;


    LoginPrompt := false;

    try
      Connected := true;
      Result := Connected;
    except

    end;
  end;
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
    WVTabWV_SECRET.AsString := secret;
    WVTabWV_PWD.AsString := THashSHA2.GetHashString(JString(wv, 'pwd'));

    WVTab.Post;
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


  waid := addWahl(False);
  maid := addMA(waid);
  addWV( waid, maid);

  if simu then
  begin
    waid := addWahl(true);
    maid := addMA(waid);
    addWV( waid, maid);

  end;

  NewWahlTab.close;
  MATab.close;
  WVTab.close;

end;

function TAdminMod.ResetPwd(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

end.

