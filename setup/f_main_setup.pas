unit f_main_setup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DosCommand, Vcl.StdCtrls, Vcl.Buttons,
  IdTCPConnection, IdTCPClient, IdHTTP, IdServerIOHandler, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer, IdContext, IdGlobal, Vcl.ComCtrls, System.Actions, Vcl.ActnList,
  Vcl.StdActns, Vcl.ExtCtrls, JvWizard, JvExControls, System.ImageList,
  Vcl.ImgList, PngImageList, fr_admin, fr_database, fr_zertifikate,
  System.SysUtils, fr_files, fr_mail, fr_pre, fr_portcheck, fr_server,
  Vcl.AppEvnts;

type
  TMainSetupForm = class(TForm)
    StatusBar1: TStatusBar;
    JvWizard1: TJvWizard;
    JvWizardWelcomePage1: TJvWizardWelcomePage;
    JvWizardInteriorPage1: TJvWizardInteriorPage;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    JvWizardInteriorPage2: TJvWizardInteriorPage;
    AdminFrame1: TAdminFrame;
    JvWizardInteriorPage3: TJvWizardInteriorPage;
    DatabaseFrame1: TDatabaseFrame;
    JvWizardInteriorPage4: TJvWizardInteriorPage;
    ZertifikatFrame1: TZertifikatFrame;
    FilesFrame1: TFilesFrame;
    PngImageList1: TPngImageList;
    JvWizardInteriorPage5: TJvWizardInteriorPage;
    MailFrame1: TMailFrame;
    JvWizardInteriorPage6: TJvWizardInteriorPage;
    PreFrame1: TPreFrame;
    JvWizardInteriorPage7: TJvWizardInteriorPage;
    PortCheckFrame1: TPortCheckFrame;
    JvWizardInteriorPage8: TJvWizardInteriorPage;
    ServerFrame1: TServerFrame;
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure JvWizardInteriorPage1NextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage2NextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage4NextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage3NextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage5NextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage7NextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardWelcomePage1FinishButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage8EnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure JvWizard1FinishButtonClick(Sender: TObject);
    procedure JvWizard1CancelButtonClick(Sender: TObject);
    procedure JvWizardInteriorPage2EnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure JvWizardWelcomePage1CancelButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage8FinishButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizard1HelpButtonClick(Sender: TObject);
    procedure JvWizardWelcomePage1HelpButtonClick(Sender: TObject;
      var Stop: Boolean);
    function FormHelp(Command: Word; Data: THelpEventData;
      var CallHelp: Boolean): Boolean;
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
  public
    { Public-Deklarationen }
  end;

var
  MainSetupForm: TMainSetupForm;

implementation

uses
  system.IOUtils, u_helper, u_glob, System.Zip, ShellApi;

{$R *.dfm}

procedure TMainSetupForm.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  // ignore messages
end;

procedure TMainSetupForm.CheckBox1Click(Sender: TObject);
begin
  if ((Sender as TCheckBox).Checked = true )then
    JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkFinish, TJvWizardButtonKind.bkHelp]
  else
    JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkFinish, TJvWizardButtonKind.bkHelp];
end;

procedure TMainSetupForm.FormCreate(Sender: TObject);
begin
  JvWizard1.DoubleBuffered := true;

  Glob.HomeDir := ExtractFilePath(ParamStr(0));
  Glob.readData;

  FilesFrame1.prepare;
  DatabaseFrame1.prepare;
  ZertifikatFrame1.prepare;
  MailFrame1.prepare;
  PreFrame1.prepare;
  PortCheckFrame1.prepare;
  AdminFrame1.prepare;
  ServerFrame1.prepare;

  JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkFinish, TJvWizardButtonKind.bkHelp];
end;

function TMainSetupForm.FormHelp(Command: Word; Data: THelpEventData;
  var CallHelp: Boolean): Boolean;
begin
  CallHelp := false;
  JvWizard1HelpButtonClick( nil );
  Result := true;
end;

procedure TMainSetupForm.JvWizard1CancelButtonClick(Sender: TObject);
begin
  Glob.writeData;
end;

procedure TMainSetupForm.JvWizard1FinishButtonClick(Sender: TObject);
begin
  Glob.writeData;
end;

procedure TMainSetupForm.JvWizard1HelpButtonClick(Sender: TObject);
const
  wwwroot = 'https://github.com/Target42/MitbestimmIT/wiki';
var
  page : string;
  url : string;
begin
  if JvWizard1.ActivePage = JvWizardWelcomePage1 then         page := '/Setup-Start'
  else if JvWizard1.ActivePage = JvWizardInteriorPage6 then   page := '/Setup-Vorraussetzungen'
  else if JvWizard1.ActivePage = JvWizardInteriorPage1 then   page := '/Setup-Grundlagen'
  else if JvWizard1.ActivePage = JvWizardInteriorPage7 then   page := '/Setup-Port-Check'
  else if JvWizard1.ActivePage = JvWizardInteriorPage2 then   page := '/Setup-Administrator'
  else if JvWizard1.ActivePage = JvWizardInteriorPage3 then   page := '/Setup-Datenbank'
  else if JvWizard1.ActivePage = JvWizardInteriorPage4 then   page := '/Setup-Zertifkate'
  else if JvWizard1.ActivePage = JvWizardInteriorPage5 then   page := '/Setup-Mailserver'
  else if JvWizard1.ActivePage = JvWizardInteriorPage6 then   page := '/Setup-Server'
  else
    page := '/Installation';

  url := wwwroot + page;

  ShellExecute( 0, 'open', PCHAR(url), nil, nil, SW_SHOWNORMAL );
end;

procedure TMainSetupForm.JvWizardInteriorPage1NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := (FilesFrame1.doCopy = false );
end;

procedure TMainSetupForm.JvWizardInteriorPage2EnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  AdminFrame1.enter;
end;

procedure TMainSetupForm.JvWizardInteriorPage2NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := not AdminFrame1.CheckPwd;
  if Stop then
    ShowMessage('Die Kennworte müssen übereinstimmen und drüfen nicht leer sein!');
end;

procedure TMainSetupForm.JvWizardInteriorPage3NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := DatabaseFrame1.checkDB = false;
  if stop then
    ShowMessage('Die Datenbank ist noch nicht initialisiert!');
end;

procedure TMainSetupForm.JvWizardInteriorPage4NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  ZertifikatFrame1.BitBtn2.Click;
  stop := not ZertifikatFrame1.ok;
  if stop then
    ShowMessage('Es wurde noch kein Zertifikat erfolgreich erstellt!');

  glob.ZertifikatPWD := ZertifikatFrame1.LabeledEdit1.Text;
end;

procedure TMainSetupForm.JvWizardInteriorPage5NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := not MailFrame1.isOK;
end;

procedure TMainSetupForm.JvWizardInteriorPage7NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := not PortCheckFrame1.isOk;
  if stop then
  begin
    PortCheckFrame1.BitBtn5.Click;
  end;

  stop := not PortCheckFrame1.isOk;
  if stop then
  begin
    ShowMessage('Bitte alle Ports testen und doppelt Belegung vermeiden!');
  end;
end;

procedure TMainSetupForm.JvWizardInteriorPage8EnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  Glob.writeData;
end;

procedure TMainSetupForm.JvWizardInteriorPage8FinishButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  Glob.writeData;
  Close;
end;

procedure TMainSetupForm.JvWizardWelcomePage1CancelButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := true;
  Glob.writeData;
  Close;
end;

procedure TMainSetupForm.JvWizardWelcomePage1FinishButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := true;
  Glob.writeData;
  Close;
end;

procedure TMainSetupForm.JvWizardWelcomePage1HelpButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  ShellExecute(
    Application.Handle,
    'open',
    'https://github.com/Target42/MitbestimmIT/wiki',
    nil,
    nil,
    SW_SHOWNORMAL
  );
end;

end.




