unit f_User;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, m_glob,
  Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.Menus;

type
  TUserForm = class(TForm)
    ClientDataSet1: TClientDataSet;
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1MA_ID: TIntegerField;
    ClientDataSet1MA_PERSNR: TStringField;
    ClientDataSet1MA_NAME: TStringField;
    ClientDataSet1MA_VORNAME: TStringField;
    ClientDataSet1MA_GENDER: TStringField;
    ClientDataSet1MA_ABTEILUNG: TStringField;
    ClientDataSet1MA_MAIL: TStringField;
    ClientDataSet1MA_GEB: TDateField;
    ClientDataSet1MW_ROLLE: TStringField;
    ClientDataSet1MW_LOGIN: TStringField;
    DataSource1: TDataSource;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    Barbeiten1: TMenuItem;
    procedure ClientDataSet1MA_GENDERGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Barbeiten1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    class procedure Execute;
  end;

var
  UserForm: TUserForm;

implementation

{$R *.dfm}

uses m_res, f_userEdit, u_stub, System.JSON, u_helper;

procedure TUserForm.Barbeiten1Click(Sender: TObject);
var
  data   : TJSONObject;
  client : TUserModClient;
  res    : TJSONObject;
begin
  if ClientDataSet1.IsEmpty then
    exit;
  data := TUserEditForm.Edit(ClientDataSet1);
  if Assigned(data) then
  begin
    client := TUserModClient.Create(GM.SQLConnection1.DBXConnection);

    res := client.setUserData(data);
    ShowResult(res, true);
    client.Free;

    ClientDataSet1.Refresh;
  end;
end;

procedure TUserForm.ClientDataSet1MA_GENDERGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  GM.GenderText(Sender, Text, DisplayText);
end;

procedure TUserForm.DBGrid1DblClick(Sender: TObject);
begin
  Barbeiten1Click(Sender);
end;

class procedure TUserForm.Execute;
begin
  Application.CreateForm(TUserForm, UserForm);
  UserForm.ShowModal;
  UserForm.free;
end;

procedure TUserForm.FormCreate(Sender: TObject);
begin
  ClientDataSet1.Open;
end;

end.
