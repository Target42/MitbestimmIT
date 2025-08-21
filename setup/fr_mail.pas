unit fr_mail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Mask, IdMessage;

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
    procedure BitBtn1Click(Sender: TObject);
  private
    m_ok : boolean;
  public
    procedure prepare;
    function isOK : boolean;
  end;

implementation

uses
  IdEMailAddress, u_glob;

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

  try
    IdSMTP1.Connect;
    IdSMTP1.Send(IdMessage1);
    m_ok := true;
  except

  end;
  IdSMTP1.Disconnect;


end;

function TMailFrame.isOK: boolean;
begin
  Result := m_ok or CheckBox1.Checked;

  if Result then
  begin
    Glob.SMTPNotUsed := CheckBox1.Checked;
    glob.SMTPHost    := LabeledEdit1.Text;
    Glob.SMTPPort    := StrToIntDef(LabeledEdit2.Text, 0);
    glob.SMTPUser    := LabeledEdit3.Text;
    glob.SMTPPasswort:= LabeledEdit4.Text;
  end;

end;

procedure TMailFrame.prepare;
begin
  m_ok := false;
  LabeledEdit2.Text := intToStr(IdSMTP1.Port);
end;

end.
