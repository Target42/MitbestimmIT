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
  System.SysUtils;

type
  TMainSetupForm = class(TForm)
    StatusBar1: TStatusBar;
    ActionList1: TActionList;
    BrowseForFolder1: TBrowseForFolder;
    JvWizard1: TJvWizard;
    JvWizardWelcomePage1: TJvWizardWelcomePage;
    JvWizardInteriorPage1: TJvWizardInteriorPage;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    PngImageList1: TPngImageList;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    JvWizardInteriorPage2: TJvWizardInteriorPage;
    AdminFrame1: TAdminFrame;
    JvWizardInteriorPage3: TJvWizardInteriorPage;
    DatabaseFrame1: TDatabaseFrame;
    JvWizardInteriorPage4: TJvWizardInteriorPage;
    ZertifikatFrame1: TZertifikatFrame;
    Label1: TLabel;
    procedure IdServerIOHandlerSSLOpenSSL1GetPassword(var Password: string);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure IdHTTPServer1QuerySSLPort(APort: TIdPort; var VUseSSL: Boolean);
    procedure BrowseForFolder1Accept(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure JvWizardInteriorPage1NextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage2NextButtonClick(Sender: TObject;
      var Stop: Boolean);
  private
    procedure setSpeedBtn;
  public
    { Public-Deklarationen }
  end;

var
  MainSetupForm: TMainSetupForm;

implementation

uses
  system.IOUtils, u_helper, u_glob, System.Zip;

{$R *.dfm}

procedure TMainSetupForm.BrowseForFolder1Accept(Sender: TObject);
begin
  Edit1.Text := BrowseForFolder1.Folder;
end;

procedure TMainSetupForm.CheckBox1Click(Sender: TObject);
begin
  if ((Sender as TCheckBox).Checked = true )then
    JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkNext, TJvWizardButtonKind.bkFinish]
  else
    JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkFinish];
end;

procedure TMainSetupForm.FormCreate(Sender: TObject);
begin
  setSpeedBtn;

  if ( SameText( GetEnvironmentVariable('COMPUTERNAME'), 'odin') = true) then
  begin
    Edit1.Text := 'D:\DelphiBin\MitbestimmIT\Setup\Server';
  end
  else
  begin
    var path : string;
    path := GetEnvironmentVariable('ProgramFiles')+'\';
    Edit1.Text :=  TPAth.Combine( path, 'MitbestimmIT' );
  end;
  JvWizardWelcomePage1.VisibleButtons := [TJvWizardButtonKind.bkFinish];
end;

procedure TMainSetupForm.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ContentText := 'ok';
  AResponseInfo.ResponseNo := 200;

end;

procedure TMainSetupForm.IdHTTPServer1QuerySSLPort(APort: TIdPort;
  var VUseSSL: Boolean);
begin
  VUseSSL := true;
end;

procedure TMainSetupForm.IdServerIOHandlerSSLOpenSSL1GetPassword(
  var Password: string);
begin
  Password := 'Wahl2026';
end;

procedure TMainSetupForm.JvWizardInteriorPage1NextButtonClick(Sender: TObject;
  var Stop: Boolean);
var
  done : Boolean;
  zip  : TZipFile;
begin
  Screen.Cursor := crHourGlass;
  try
    Glob.HomeDir :=Trim(Edit1.Text);
    Glob.TempDir := TPath.Combine(Glob.HomeDir, 'temp');

    done := ForceDirectories(Glob.TempDir);
    if done then
    begin
      done := SaveRCDataToFile('FB', TPath.Combine(Glob.TempDir, 'fb.zip')) and done;
      done := SaveRCDataToFile('SSL', TPath.Combine(Glob.TempDir, 'ssl.zip')) and done;
      done := SaveRCDataToFile('openssl', TPath.Combine(Glob.TempDir, 'openssl.zip')) and done;

      done := ForceDirectories( TPath.Combine(Glob.HomeDir, 'Zertifikate')) and done;
      done := SaveRCDataToFile('Zertifikate', TPath.Combine(Glob.HomeDir, 'Zertifikate\ZertifikateErzeugen.bat')) and done;
    end;
    zip := TZipFile.Create;
    zip.Open(TPath.Combine(Glob.TempDir, 'openssl.zip'), zmRead);
    zip.ExtractAll(TPath.Combine(Glob.HomeDir, 'Zertifikate\openssl'));
  except

  end;
  Screen.Cursor := crDefault;

  if not done then
  begin
    stop := false;
    MessageDlg('Es ist ein Fehler beim Auspacken der Dateien passiert.' +
      #13#10 + 'Wählen sie einen anderen Pfad.',  mtWarning, [mbOK], 0);
  end;

end;

procedure TMainSetupForm.JvWizardInteriorPage2NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := not AdminFrame1.CheckPwd;
  if Stop then
    ShowMessage('Die Kennworte müssen übereinstimmen und drüfen nicht leer sein!');

end;

procedure TMainSetupForm.setSpeedBtn;
begin
  SpeedButton1.Caption := '';
end;

end.




