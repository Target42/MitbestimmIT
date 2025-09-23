unit fr_zertifikate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.Buttons, IdContext, IdCustomHTTPServer, IdCustomTCPServer,
  IdHTTPServer, IdServerIOHandler, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdGlobal, DosCommand,
  Vcl.ComCtrls, System.ImageList, Vcl.ImgList, PngImageList;

type
  TZertifikatFrame = class(TFrame)
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    IdHTTP1: TIdHTTP;
    IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL;
    IdHTTPServer1: TIdHTTPServer;
    PngImageList1: TPngImageList;
    RadioGroup1: TRadioGroup;
    LabeledEdit3: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    LabeledEdit4: TLabeledEdit;
    GroupBox2: TGroupBox;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    FileOpenDialog1: TFileOpenDialog;
    procedure IdHTTPServer1QuerySSLPort(APort: TIdPort; var VUseSSL: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure IdServerIOHandlerSSLOpenSSL1GetPassword(var Password: string);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DosCommand1TerminateProcess(ASender: TObject;
      var ACanTerminate: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    m_ok : boolean;
  public
    procedure prepare;

    function ok : boolean;
  end;

implementation

{$R *.dfm}

uses
  system.IOUtils, u_glob, m_res;


procedure TZertifikatFrame.BitBtn2Click(Sender: TObject);
begin
  m_ok := false;

  IdServerIOHandlerSSLOpenSSL1.SSLOptions.KeyFile      := TPath.Combine(Glob.HomeDir, 'Zertifikate\key.pem');
//  IdServerIOHandlerSSLOpenSSL1.SSLOptions.RootCertFile := TPath.Combine(Glob.HomeDir, 'Zertifikate\cert.pem');
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.CertFile     := TPath.Combine(Glob.HomeDir, 'Zertifikate\cert.pem');

  try
    IdHTTPServer1.Active := true;
    IdHTTP1.Get(Format('https://localhost:%d/', [IdHTTPServer1.DefaultPort]));
    if IdHTTP1.ResponseCode = 200 then
    begin
      m_ok := true;
    end;

  except
    on e :exception do
    begin
      ShowMessage(e.ToString);
    end;

  end;
  IdHTTPServer1.Active := false;
  if m_ok then
  begin
    Label1.Font.Color := clGreen;
    Label1.Caption := 'Test erfolgreich';
  end
  else
  begin
    Label1.Font.Color := clRed;
    Label1.Caption := 'Test fehlgeschlagen';
  end;
end;

procedure TZertifikatFrame.DosCommand1TerminateProcess(ASender: TObject;
  var ACanTerminate: Boolean);
begin
  BitBtn2.Click;
end;

procedure TZertifikatFrame.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ContentText := 'ok';
  AResponseInfo.ResponseNo := 200;
end;

procedure TZertifikatFrame.IdHTTPServer1QuerySSLPort(APort: TIdPort;
  var VUseSSL: Boolean);
begin
  VUseSSL := true;
end;

procedure TZertifikatFrame.IdServerIOHandlerSSLOpenSSL1GetPassword(
  var Password: string);
begin
  Password := LabeledEdit1.Text;
end;

function TZertifikatFrame.ok: boolean;
begin
  result := m_ok;
  if Result then
  begin
    Glob.ZertifikatPWD  := LabeledEdit1.Text;
    Glob.KeyFile        := IdServerIOHandlerSSLOpenSSL1.SSLOptions.KeyFile;
    Glob.RootFile       := IdServerIOHandlerSSLOpenSSL1.SSLOptions.RootCertFile;
    glob.CertFile       := IdServerIOHandlerSSLOpenSSL1.SSLOptions.CertFile;
    Glob.writeData;
  end;
end;

procedure TZertifikatFrame.prepare;
begin
  m_ok := false;

  if not Glob.Eigenes then
    RadioGroup1.ItemIndex := 0
  else
    RadioGroup1.ItemIndex := 1;

  GroupBox1.Enabled := Glob.Eigenes;
end;

procedure TZertifikatFrame.RadioGroup1Click(Sender: TObject);
begin
  GroupBox1.Enabled := (RadioGroup1.ItemIndex = 1);
  if RadioGroup1.ItemIndex = 0 then
  begin
    Glob.ZertifikatPWD := 'Wahl';
    Glob.KeyFile  := TPath.Combine(Glob.HomeDir, 'Zertifikate\key.pem');
    Glob.RootFile := TPath.Combine(Glob.HomeDir, 'Zertifikate\cert.pem');
    glob.CertFile := TPath.Combine(Glob.HomeDir, 'Zertifikate\cert.pem');

  end;

  LabeledEdit1.Text := Glob.ZertifikatPWD;
  LabeledEdit2.Text := Glob.ZertifikatPWD;

  IdServerIOHandlerSSLOpenSSL1.SSLOptions.KeyFile       := Glob.KeyFile;
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.RootCertFile  := Glob.RootFile;
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.CertFile      := glob.CertFile;

  LabeledEdit3.Text := glob.CertFile;
  LabeledEdit4.Text := glob.KeyFile;

end;

procedure TZertifikatFrame.SpeedButton1Click(Sender: TObject);
var
  id : integer;
begin
  id := ( Sender as TSpeedButton).Tag;
  if id = 1 then
  begin
    FileOpenDialog1.FileName := LabeledEdit3.Text;
    if FileOpenDialog1.Execute then
      LabeledEdit3.Text := FileOpenDialog1.FileName;
  end
  else
  begin
    FileOpenDialog1.FileName := LabeledEdit4.Text;
    if FileOpenDialog1.Execute then
      LabeledEdit4.Text := FileOpenDialog1.FileName;
  end;
end;

end.
