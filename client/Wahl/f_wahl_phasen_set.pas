unit f_wahl_phasen_set;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.Buttons;

type
  TWahlPhasenSEtForm = class(TForm)
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ClientDataSet1WA_ID: TIntegerField;
    ClientDataSet1WP_ID: TIntegerField;
    ClientDataSet1WP_TITLE: TStringField;
    ClientDataSet1WP_ACTIVE: TStringField;
    ClientDataSet1WP_PHASE: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ClientDataSet1WP_ACTIVEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    procedure change( status : boolean );
  public
    class procedure execute;
  end;

var
  WahlPhasenSEtForm: TWahlPhasenSEtForm;

implementation

{$R *.dfm}

uses m_glob, u_stub, System.JSON, u_json, u_helper, m_res;

procedure TWahlPhasenSEtForm.BitBtn1Click(Sender: TObject);
begin
  change(true);
end;

procedure TWahlPhasenSEtForm.BitBtn2Click(Sender: TObject);
begin
  change(false);
end;

procedure TWahlPhasenSEtForm.change(status: boolean);
var
  client : TWahlModClient;
  res    : TJSonObject;
  data   : TJSONObject;
begin
  if ClientDataSet1.IsEmpty then
    exit;

  data := TJSONObject.Create;
  JReplace( data, 'nr', ClientDataSet1WP_ID.AsInteger);
  JReplace( data, 'status', status );

  client := TWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  res := client.phasenStatus(data);
  ShowResult( res, true );
  client.Free;

  ClientDataSet1.Refresh;
end;

procedure TWahlPhasenSEtForm.ClientDataSet1WP_ACTIVEGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  GM.FlagText(Sender, Text, DisplayText);
end;

procedure TWahlPhasenSEtForm.DBGrid1DblClick(Sender: TObject);
begin
  if ClientDataSet1.IsEmpty then
    exit;

  if ClientDataSet1WP_ACTIVE.AsString = 'T' then
    BitBtn2.Click
  else
    BitBtn1.Click;
end;

class procedure TWahlPhasenSEtForm.execute;
begin
  Application.CreateForm(TWahlPhasenSEtForm, WahlPhasenSEtForm);
  WahlPhasenSEtForm.ShowModal;
  WahlPhasenSEtForm.Free;
end;

procedure TWahlPhasenSEtForm.FormCreate(Sender: TObject);
begin
  ClientDataSet1 .Open;
end;

end.
