unit fr_mail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Mask, IdMessage, IdAntiFreezeBase, IdAntiFreeze;

type
  TMailFrame = class(TFrame)
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    LabeledEdit5: TLabeledEdit;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdMessage1: TIdMessage;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    m_ok : boolean;
  public
    procedure prepare;
    function isOK : boolean;
  end;

implementation

uses
  IdEMailAddress, u_glob, m_res;

{$R *.dfm}

procedure TMailFrame.BitBtn1Click(Sender: TObject);
var
  port : integer;
  adr : TIdEMailAddressItem;
begin
  m_ok := false;
  if not TryStrToInt(LabeledEdit2.Text, port) then
  begin
    port := 25;
    LabeledEdit2.Text := intToStr(port);
    ComboBox1.ItemIndex := 0;
  end;
  IdSMTP1.Host := LabeledEdit1.Text;
  IdSMTP1.Port := port;
  IdSMTP1.Username := LabeledEdit3.Text;
  IdSMTP1.Password := LabeledEdit4.Text;

  // mail
  IdMessage1.From.Address := LabeledEdit3.Text;

  IdMessage1.Body.Assign(Memo1.Lines);
  adr := IdMessage1.Recipients.Add;
  adr.Address := LabeledEdit5.Text;

  Screen.Cursor := crHourGlass;
  try
    try
      IdSMTP1.Connect;
    except
      on e : exception do
      begin
        Screen.Cursor := crDefault;
        showMessage('Fehler beim Verbinden mit dem Mailserver!'+sLineBreak+e.ToString);
        exit;
      end;
    end;
    Application.ProcessMessages;
    IdSMTP1.Send(IdMessage1);
    ShowMessage('Nachricht gesendet!');
    m_ok := true;
  except
    on e : exception do
    begin
      Screen.Cursor := crDefault;
      ShowMessage(e.ToString);
    end;
  end;
  IdSMTP1.Disconnect;
  Screen.Cursor := crDefault;
end;

procedure TMailFrame.ComboBox1Change(Sender: TObject);
begin
{
Keines (Port 25 )
Explizit (Port 587)
Implizit (Port 465)

}
  case ComboBox1.ItemIndex of
    0 :
    begin
      LabeledEdit2.Text := '25';
      IdSMTP1.UseTLS := utNoTLSSupport
    end;
    1 :
    begin
      LabeledEdit2.Text := '587';
      IdSMTP1.UseTLS := utUseExplicitTLS;
    end;

    2 : begin
      LabeledEdit2.Text := '465';
      IdSMTP1.UseTLS := utUseImplicitTLS;
    end
    else
    begin
      IdSMTP1.UseTLS := utUseImplicitTLS;
      LabeledEdit2.Text := '465';
    end;
  end;

end;

function TMailFrame.isOK: boolean;
begin
  Result := m_ok or CheckBox1.Checked;

  if not CheckBox1.Checked then
  begin
    glob.SMTPHost    := LabeledEdit1.Text;
    Glob.SMTPPort    := StrToIntDef(LabeledEdit2.Text, 465);
    glob.SMTPUser    := LabeledEdit3.Text;
    glob.SMTPPasswort:= LabeledEdit4.Text;
    Glob.SMTPTest    := LabeledEdit5.Text;
    Glob.SMTPSSL     := ComboBox1.ItemIndex;
  end;

  Glob.SMTPNotUsed := CheckBox1.Checked;
  Glob.SMTPOk      := result;
  Glob.writeData;

end;

procedure TMailFrame.prepare;
begin
  m_ok := Glob.SMTPOk;

  ComboBox1.ItemIndex:= Glob.SMTPSSL;
  LabeledEdit2.Text := intToStr(IdSMTP1.Port);
  CheckBox1.Checked := Glob.SMTPNotUsed;
  LabeledEdit1.Text := glob.SMTPHost;
  LabeledEdit2.Text := IntToStr(Glob.SMTPPort);

  LabeledEdit3.Text := glob.SMTPUser;
  LabeledEdit4.Text := glob.SMTPPasswort;
  LabeledEdit5.Text := Glob.SMTPTest;

  if LabeledEdit4.Text = '' then
    LabeledEdit4.Text := GetEnvironmentVariable('MAILPWD');

end;

end.
