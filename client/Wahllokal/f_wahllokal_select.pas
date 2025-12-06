unit f_wahllokal_select;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, fr_base,
  Datasnap.DBClient, Datasnap.DSConnect;

type
  TSelectWahlLokalForm = class(TForm)
    DBGrid1: TDBGrid;
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    FLoggedIN: boolean;
    { Private-Deklarationen }
  public
    property LoggedIN: boolean read FLoggedIN write FLoggedIN;
    class function exec : boolean;
  end;

var
  SelectWahlLokalForm: TSelectWahlLokalForm;

implementation

{$R *.dfm}

uses m_glob, System.JSON, u_json, u_stub;

procedure TSelectWahlLokalForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  data : TJSONObject;
  client : TWahlLokalModClient;
  res    : TJSONObject;
begin
  data := TJSONObject.Create;

  JReplace( data, 'lokalid', ClientDataSet1.FieldByName('WL_ID').AsInteger);
  JReplace( data, 'maid', -1);

  client := TWahlLokalModClient.Create(GM.SQLConnection1.DBXConnection);
  res := client.start(data);
  FLoggedIN := JBool( res, 'result');
  client.Free;
end;

class function TSelectWahlLokalForm.exec: boolean;
begin
  result := false;

  Application.CreateForm(TSelectWahlLokalForm, SelectWahlLokalForm);
  if SelectWahlLokalForm.ShowModal = mrOk then
  begin
    Result := SelectWahlLokalForm.LoggedIN;
  end;
  SelectWahlLokalForm.Free;
end;

procedure TSelectWahlLokalForm.FormCreate(Sender: TObject);
begin
  FLoggedIN := false;
  ClientDataSet1.Open;
  BaseFrame1.OKBtn.Enabled := not ClientDataSet1.IsEmpty;

  if ClientDataSet1.IsEmpty then
  begin
    ShowMessage('Du bist in einem Wahllokal eingeteilt!');
  end;
end;

end.
