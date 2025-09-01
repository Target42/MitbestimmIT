unit fr_admin;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  IdSNTP;

type
  TAdminFrame = class(TFrame)
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Panel1: TPanel;
    Splitter1: TSplitter;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    CodeLab: TLabel;
    IdSNTP1: TIdSNTP;
    procedure CheckBox1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
    m_secret : String;
    m_url    : string;
  public
    procedure prepare;
    procedure release;

    procedure enter;
    procedure leave;

    function CheckPwd : boolean;

    property Secret : string read m_secret write m_secret;
    function useTOTP : boolean;
    function getPasswort : string;
  end;

implementation

{$R *.dfm}

uses
  u_totp, system.DateUtils, u_glob;

{ TFrame1 }

procedure TAdminFrame.CheckBox1Click(Sender: TObject);
var
  account : string;
begin
  if not CheckBox1.Checked then
  begin
    Image1.Picture.Assign(nil);
    Timer1.Enabled := false;
  end
  else
  begin
    account := format('admin@%s.local', [GetEnvironmentVariable('COMPUTERNAME')]);

    m_secret := GenerateBase32Secret;

    m_url    := Format('otpauth://totp/%s:%s?secret=%s&issuer=%s',
                   ['MitbestimmIT', account, m_secret, 'MitbestimmIT']);

    DrawQRCodeToImage( m_url, Image1);
    Timer1.Enabled := true;
  end;
end;

function TAdminFrame.CheckPwd: boolean;
begin
  Result := ( trim(LabeledEdit1.Text) <> '' ) and (LabeledEdit1.Text = LabeledEdit2.Text);

  if Result then
  begin
    Glob.AdminPwd := LabeledEdit1.Text;
    Glob.Faktor2  := CheckBox1.Checked;
    Glob.Secret   := m_secret;
    Glob.writeData;
  end;

end;

procedure TAdminFrame.enter;
begin
  LabeledEdit1.Text := Glob.AdminPwd;
  LabeledEdit2.Text := Glob.AdminPwd;
  CheckBox1.Checked := Glob.Faktor2;

  m_secret := Glob.Secret;

  if CheckBox1.Checked then
  begin
    Timer1.Enabled := true;
  end;

end;

function TAdminFrame.getPasswort: string;
begin
  Result := '';

  if CheckPwd then
    Result := LabeledEdit1.Text;
end;

procedure TAdminFrame.leave;
begin

  Timer1.Enabled := false;
end;

procedure TAdminFrame.prepare;
begin

end;

procedure TAdminFrame.release;
begin

end;

procedure TAdminFrame.Timer1Timer(Sender: TObject);
begin
  IdSNTP1.Active := true;
  setUTC(TTimeZone.Local.ToUniversalTime(IdSNTP1.DateTime));
  IdSNTP1.Active := false;
  CodeLab.Caption := GenerateTOTP(m_secret);
end;

function TAdminFrame.useTOTP: boolean;
begin
  Result := CheckBox1.Checked;
end;

end.
