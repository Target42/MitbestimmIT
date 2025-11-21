unit f_userEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.CheckLst, System.JSON;

type
  TUserEditForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
  private
    function GeteMail: string;
    procedure SeteMail(const Value: string);
    function Getlogin: string;
    procedure Setlogin(const Value: string);
    function getPersNr : string;
    { Private-Deklarationen }
  public
    class function Edit( dataset : TDataSet ) : TJSONObject;

    property PersNr: string read getPersNr;
    property eMail: string read GeteMail write SeteMail;
    property login: string read Getlogin write Setlogin;

    procedure setData( dataset : TDataSet);
  end;

var
  UserEditForm: TUserEditForm;

implementation

{$R *.dfm}

uses u_rollen, u_json;

{ TUserEditForm }

class function TUserEditForm.Edit(dataset: TDataSet): TJSONObject;
begin
  Result := nil;
  Application.CreateForm(TUserEditForm, UserEditForm);
  UserEditForm.setData(dataset);
  if UserEditForm.ShowModal = mrOk then
  begin
    Result := TJSONObject.Create;
    JReplace( result, 'action', 'update');
    JReplace( result, 'persnr', UserEditForm.PersNr);
    JReplace( result, 'login', UserEditForm.login);
    JReplace( result, 'mail', UserEditForm.eMail);

  end;
  UserEditForm.Free;
end;

function TUserEditForm.GeteMail: string;
begin
  Result := trim( LabeledEdit8.Text );
end;

function TUserEditForm.Getlogin: string;
begin
  Result := trim( LabeledEdit9.Text );
end;

function TUserEditForm.getPersNr: string;
begin
  Result := LabeledEdit1.Text;
end;

procedure TUserEditForm.setData(dataset: TDataSet);
begin
  LabeledEdit1.Text := dataset.FieldByName('MA_PERSNR').AsString;
  LabeledEdit2.Text := dataset.FieldByName('MA_NAME').AsString;
  LabeledEdit3.Text := dataset.FieldByName('MA_VORNAME').AsString;
  LabeledEdit4.Text := dataset.FieldByName('MA_GENDER').AsString;
  LabeledEdit5.Text := dataset.FieldByName('MA_ABTEILUNG').AsString;
  LabeledEdit6.Text := dataset.FieldByName('MA_GEB').AsString;
  LabeledEdit7.Text := dataset.FieldByName('MW_ROLLE').AsString;

  LabeledEdit8.Text := dataset.FieldByName('MA_MAIL').AsString;
  LabeledEdit9.Text := dataset.FieldByName('MW_LOGIN').AsString;
end;

procedure TUserEditForm.SeteMail(const Value: string);
begin
  LabeledEdit8.Text := value;
end;

procedure TUserEditForm.Setlogin(const Value: string);
begin
  LabeledEdit9.Text := value;
end;

end.
