unit fr_zertifikate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.Buttons, IdContext, IdCustomHTTPServer, IdCustomTCPServer,
  IdHTTPServer, IdServerIOHandler, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdGlobal, DosCommand;

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
    Memo1: TMemo;
    procedure IdHTTPServer1QuerySSLPort(APort: TIdPort; var VUseSSL: Boolean);
  private
    m_data : string;
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

procedure TZertifikatFrame.IdHTTPServer1QuerySSLPort(APort: TIdPort;
  var VUseSSL: Boolean);
begin
  VUseSSL := true;
end;

end.
