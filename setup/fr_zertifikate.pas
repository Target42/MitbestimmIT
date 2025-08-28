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
    BitBtn1: TBitBtn;
    IdHTTP1: TIdHTTP;
    IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL;
    IdHTTPServer1: TIdHTTPServer;
    DosCommand1: TDosCommand;
    GroupBox2: TGroupBox;
    Memo1: TRichEdit;
    BitBtn2: TBitBtn;
    PngImageList1: TPngImageList;
    procedure IdHTTPServer1QuerySSLPort(APort: TIdPort; var VUseSSL: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure DosCommand1NewLine(ASender: TObject; const ANewLine: string;
      AOutputType: TOutputType);
    procedure Memo1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Memo1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure IdServerIOHandlerSSLOpenSSL1GetPassword(var Password: string);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DosCommand1TerminateProcess(ASender: TObject;
      var ACanTerminate: Boolean);
  private
    m_ok : boolean;
  public
    procedure prepare;

    function ok : boolean;
  end;

implementation

{$R *.dfm}

uses
  system.IOUtils, u_glob;


procedure TZertifikatFrame.BitBtn1Click(Sender: TObject);
var
  openssl : string;
  bat     : string;
begin
  Memo1.Lines.Clear;
  openssl := TPath.Combine(Glob.HomeDir, 'Zertifikate\openssl\bin\openssl.exe');

  DosCommand1.CurrentDir := TPath.Combine(Glob.HomeDir, 'Zertifikate' );
  bat := TPath.Combine(Glob.HomeDir, 'Zertifikate\ZertifikateErzeugen.bat' );
  DosCommand1.CommandLine := Format('"%s" "%s" "%s"',
  [
    bat,
    openssl,
    LabeledEdit1.Text
  ]);
  DosCommand1.Execute;
end;

procedure TZertifikatFrame.BitBtn2Click(Sender: TObject);
begin
  m_ok := false;

  IdServerIOHandlerSSLOpenSSL1.SSLOptions.KeyFile      := TPath.Combine(Glob.HomeDir, 'Zertifikate\key.pem');
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.RootCertFile := TPath.Combine(Glob.HomeDir, 'Zertifikate\cert.pem');
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.CertFile     := TPath.Combine(Glob.HomeDir, 'Zertifikate\cert.pem');

  try
    IdHTTPServer1.Active := true;
    IdHTTP1.Get(Format('https://localhost:%d/', [IdHTTPServer1.DefaultPort]));
    if IdHTTP1.ResponseCode = 200 then
    begin
      Memo1.Lines.Add('Test ist erfolgreich!');
      m_ok := true;
    end;

  except
    on e :exception do
    begin
      ShowMessage(e.ToString);
    end;

  end;
  if IdHTTPServer1.Active then
    IdHTTPServer1.Active := false;

end;

procedure TZertifikatFrame.DosCommand1NewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
begin
  Memo1.Lines.Add(ANewLine);
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

procedure TZertifikatFrame.Memo1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  SendMessage(Memo1.Handle, EM_SCROLL, SB_LINEDOWN, 0);
end;

procedure TZertifikatFrame.Memo1MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  SendMessage(Memo1.Handle, EM_SCROLL, SB_LINEUP, 0);
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

  Memo1.Lines.Clear;

  LabeledEdit1.Text := Glob.ZertifikatPWD;
  LabeledEdit2.Text := Glob.ZertifikatPWD;
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.KeyFile       := Glob.KeyFile;
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.RootCertFile  := Glob.RootFile;
  IdServerIOHandlerSSLOpenSSL1.SSLOptions.CertFile      := glob.CertFile;

  if LabeledEdit1.Text <> '' then
    BitBtn2.Click;
end;

end.
