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
    ClientDataSet1WA_ID: TIntegerField;
    ClientDataSet1WF_ID: TIntegerField;
    ClientDataSet1WF_TITEL: TStringField;
    ClientDataSet1WF_START: TSQLTimeStampField;
    ClientDataSet1WF_ENDE: TSQLTimeStampField;
    ClientDataSet1WF_TYP: TIntegerField;
    ClientDataSet1WF_ACTIVE: TStringField;
    ClientDataSet1WF_PHASE: TStringField;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ClientDataSet1WF_ACTIVEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    procedure change( status : boolean );
  public
    class procedure execute;
  end;

var
  WahlPhasenSEtForm: TWahlPhasenSEtForm;

implementation

{$R *.dfm}

uses m_glob, u_stub, System.JSON, u_json, u_helper;

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
  JReplace( data, 'nr', ClientDataSet1WF_ID.AsInteger);
  JReplace( data, 'status', status );

  client := TWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  res := client.phasenStatus(data);
  ShowResult( res, true );
  client.Free;

  ClientDataSet1.Refresh;
end;

procedure TWahlPhasenSEtForm.ClientDataSet1WF_ACTIVEGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  GM.FlagText(Sender, Text, DisplayText);
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
