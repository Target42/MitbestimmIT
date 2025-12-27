unit f_helfer_wechsel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, fr_base, Datasnap.DBClient, Datasnap.DSConnect, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, m_res;

type
  THelferWechselForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet1MA_ID: TIntegerField;
    ClientDataSet1MA_PERSNR: TStringField;
    ClientDataSet1MA_NAME: TStringField;
    ClientDataSet1MA_VORNAME: TStringField;
    ClientDataSet1MA_GENDER: TStringField;
    ClientDataSet1MA_ABTEILUNG: TStringField;
    ClientDataSet1MA_MAIL: TStringField;
    ClientDataSet1MA_GEB: TDateField;
    ClientDataSet1WH_ROLLE: TStringField;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    procedure ClientDataSet1MA_GENDERGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    class function execute : boolean;
  end;

var
  HelferWechselForm: THelferWechselForm;

implementation

{$R *.dfm}

uses m_glob, System.JSON, u_json, u_stub, u_helper;

procedure THelferWechselForm.BitBtn1Click(Sender: TObject);
var
  data : TJSONObject;
  res  : TJSONObject;
  client : TWahlLokalModClient;
begin
  if ClientDataSet1.IsEmpty then
    exit;

  data := TJSONObject.Create;
  JReplace( data, 'maid', ClientDataSet1MA_ID.AsInteger);
  JReplace( data, 'pwd',    LabeledEdit2.Text);
  JReplace( data, 'oldpwd', LabeledEdit1.Text );

  client := TWahlLokalModClient.Create(GM.SQLConnection1.DBXConnection);

  res := client.wechsel( data ) ;

  ShowResult( res, true );
  if JBool( res, 'result') then
  begin
    ModalResult := mrOk;
  end;
  client.Free;
end;

procedure THelferWechselForm.ClientDataSet1MA_GENDERGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  GM.GenderText(Sender, Text, DisplayText);
end;

class function THelferWechselForm.execute: boolean;
begin
  Application.CreateForm(THelferWechselForm, HelferWechselForm);
  Result := HelferWechselForm.ShowModal = mrOk;
  HelferWechselForm.Free;
end;

procedure THelferWechselForm.FormCreate(Sender: TObject);
begin
  ClientDataSet1.Open;
end;

end.
