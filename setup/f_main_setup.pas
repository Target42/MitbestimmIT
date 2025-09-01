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
  System.SysUtils, fr_files, fr_mail, fr_pre, fr_portcheck, fr_server;

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
    Label1: TLabel;
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
  private
  public
    { Public-Deklarationen }
  end;

var
  MainSetupForm: TMainSetupForm;

implementation

uses
  system.IOUtils, u_helper, u_glob, System.Zip;

{$R *.dfm}

procedure TMainSetupForm.CheckBox1Click(Sender: TObject);
begin
  if ((Sender as TCheckBox).Checked = true )then
    JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkFinish]
  else
    JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkFinish];
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

  JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkFinish];
end;

procedure TMainSetupForm.JvWizard1CancelButtonClick(Sender: TObject);
begin
  Glob.writeData;
end;

procedure TMainSetupForm.JvWizard1FinishButtonClick(Sender: TObject);
begin
  Glob.writeData;
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
  ServerFrame1.updateData;
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

end.




