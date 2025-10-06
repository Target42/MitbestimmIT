unit f_wahl_select;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Data.DB, Data.SqlExpr, Datasnap.DBClient, m_glob,
  Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids;

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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ClientDataSet1WA_SIMUGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private-Deklarationen }
  public
    class function execute : boolean;
  end;

var
  WahlSelectForm: TWahlSelectForm;

implementation

{$R *.dfm}


procedure TWahlSelectForm.ClientDataSet1WA_SIMUGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString = 'T' then
    Text := 'Ja'
  else
    Text := 'Nein';

end;

class function TWahlSelectForm.execute: boolean;
begin
  Result := false;
  Application.CreateForm(TWahlSelectForm, WahlSelectForm);
  WahlSelectForm.ShowModal;
  WahlSelectForm.Free;
end;

procedure TWahlSelectForm.FormCreate(Sender: TObject);
begin
  ClientDataSet1.Open;
end;

procedure TWahlSelectForm.FormDestroy(Sender: TObject);
begin
  ClientDataSet1.Close;
end;

end.
