unit f_wahl_select;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Data.DB, Data.SqlExpr, Datasnap.DBClient, m_glob,
  Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, u_stub;

type
  TWahlSelectForm = class(TForm)
    BaseFrame1: TBaseFrame;
    ClientDataSet1: TClientDataSet;
    DSProviderConnection1: TDSProviderConnection;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1WA_ID: TIntegerField;
    ClientDataSet1WA_TITLE: TStringField;
    ClientDataSet1WA_SIMU: TStringField;
    ClientDataSet1WA_ACTIVE: TStringField;
    ClientDataSet1WA_TYP: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ClientDataSet1WA_SIMUGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure ClientDataSet1WA_TYPGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    FWAID: integer;
  public
    class function execute : boolean;
    property WAID: integer read FWAID write FWAID;
  end;

var
  WahlSelectForm: TWahlSelectForm;

implementation

uses
  System.JSON, u_json;

{$R *.dfm}



procedure TWahlSelectForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  client : TWahlModClient;
  data   : TJSONObject;
begin
  client:= TWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  if client.setWahl(ClientDataSet1WA_ID.AsInteger) then
  begin
    FWAID := ClientDataSet1WA_ID.AsInteger;
    data := client.getWahlData;
    if  Assigned(data) then
    begin
      GM.WahlName   := JString( data, 'titel');
      GM.Simulation := JBool( data, 'simulation');
    end;

  end;
  client.Free;
end;

procedure TWahlSelectForm.ClientDataSet1WA_SIMUGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString = 'T' then
    Text := 'Ja'
  else
    Text := 'Nein';

end;

procedure TWahlSelectForm.ClientDataSet1WA_TYPGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  case sender.AsInteger of
    0 : Text := 'Normal';
    1 : Text := 'Vereinfacht';
  end;
end;

class function TWahlSelectForm.execute: boolean;
begin
  Result := false;
  Application.CreateForm(TWahlSelectForm, WahlSelectForm);
  if WahlSelectForm.ShowModal = mrOk then
  begin
    result := WahlSelectForm.WAID <> 0;
  end;
  WahlSelectForm.Free;
end;

procedure TWahlSelectForm.FormCreate(Sender: TObject);
begin
  FWAID := 0;
  ClientDataSet1.Open;
  BaseFrame1.OKBtn.Enabled := not ClientDataSet1.IsEmpty;
end;

procedure TWahlSelectForm.FormDestroy(Sender: TObject);
begin
  ClientDataSet1.Close;
end;

end.
