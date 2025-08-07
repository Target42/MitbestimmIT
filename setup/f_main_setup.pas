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
  System.SysUtils, fr_files;

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
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure JvWizardInteriorPage1NextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage2NextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage4EnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure JvWizardInteriorPage4NextButtonClick(Sender: TObject;
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
  FilesFrame1.prepare;
  ZertifikatFrame1.prepare;

  JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkFinish];

end;

procedure TMainSetupForm.JvWizardInteriorPage1NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := (FilesFrame1.doCopy = false );
end;

procedure TMainSetupForm.JvWizardInteriorPage2NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := not AdminFrame1.CheckPwd;
  if Stop then
    ShowMessage('Die Kennworte müssen übereinstimmen und drüfen nicht leer sein!');

end;

procedure TMainSetupForm.JvWizardInteriorPage4EnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
//  JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkFinish, TJvWizardButtonKind.bkBack];
end;

procedure TMainSetupForm.JvWizardInteriorPage4NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := not ZertifikatFrame1.ok;
  if stop then
    ShowMessage('Es wurde noch kein Zertifikat erfolgreich erstellt!');
end;

end.




