unit f_admin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, m_glob, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, u_stub;

type
  TAdminForm = class(TForm)
    GroupBox1: TGroupBox;
    DSProviderConnection1: TDSProviderConnection;
    WahlTab: TClientDataSet;
    DBGrid1: TDBGrid;
    WahlSrc: TDataSource;
    WahlTabWA_ID: TIntegerField;
    WahlTabWA_TITLE: TStringField;
    WahlTabWA_SIMU: TStringField;
    WahlTabWA_ACTIVE: TStringField;
    WahlTabWA_SIMU_LANG: TStringField;
    WahlTabWA_ACTIVE_LANG: TStringField;
    StatusBar1: TStatusBar;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    CheckBox1: TCheckBox;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    BitBtn1: TBitBtn;
    LabeledEdit6: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure WahlTabWA_SIMU_LANGGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure WahlTabWA_ACTIVE_LANGGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

  public
    { Public-Deklarationen }
  end;

var
  AdminForm: TAdminForm;

implementation

uses
  System.JSON, u_json, m_res;

{$R *.dfm}

procedure TAdminForm.BitBtn1Click(Sender: TObject);
var
  am : TAdminModClient;
  function buildJson : TJSONObject;
  var
    obj : TJSONObject;
  begin
    Result := TJSONObject.Create;

    obj := TJSONObject.Create;
    JReplace( obj, 'name', LabeledEdit1.Text);
    JReplace( obj, 'simu', CheckBox1.Checked);
    JReplace( Result, 'wahl', obj);

    obj := TJSONObject.Create;
    JReplace( obj, 'login',   trim(LabeledEdit6.Text));
    JReplace( obj, 'persnr',  trim(LabeledEdit2.Text));
    JReplace( obj, 'name',    trim(LabeledEdit3.Text));
    JReplace( obj, 'vorname', trim(LabeledEdit4.Text));
    JReplace( obj, 'pwd',     LabeledEdit5.Text);

    JReplace( Result, 'vorstand', obj);
  end;
var
  res : TJSONObject;
begin
  am := TAdminModClient.Create(GM.SQLConnection1.DBXConnection);
  res := am.NeueWahl(buildJson);

  if not JBool( res, 'result') then
    ShowMessage(JString(res, 'message'));

  am.Free;
  WahlTab.Refresh;
end;

procedure TAdminForm.FormCreate(Sender: TObject);
var
  y, m, d : word;
begin
  DecodeDate( Now(), y, m, d );

  LabeledEdit1.Text := 'Wahl ' + IntToStr( y + 1 );

  WahlTab.Open;
end;

procedure TAdminForm.FormDestroy(Sender: TObject);
begin
  WahlTab.Close;
end;

procedure TAdminForm.WahlTabWA_ACTIVE_LANGGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Uppercase(WahlTab .FieldByName('WA_ACTIVE').AsString) = 'T' then
    Text := 'Ja'
  else
    Text := 'Nein';
end;

procedure TAdminForm.WahlTabWA_SIMU_LANGGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Uppercase(WahlTab .FieldByName('WA_SIMU').AsString) = 'T' then
    Text := 'Ja'
  else
    Text := 'Nein';

end;

end.
