unit fr_files;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, Vcl.StdActns;

type
  TFilesFrame = class(TFrame)
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    ActionList1: TActionList;
    BrowseForFolder1: TBrowseForFolder;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    procedure BrowseForFolder1Accept(Sender: TObject);
  private
    procedure log( text : string );
    procedure unzipOpenSSL;
    procedure unzipSSL;
  public
    function doCopy : boolean;

    procedure prepare;
  end;

implementation

{$R *.dfm}

uses
  m_res, System.Zip, u_glob, system.IOUtils, u_helper, system.UITypes;

procedure TFilesFrame.BrowseForFolder1Accept(Sender: TObject);
begin
  Edit1.Text := BrowseForFolder1.Folder;
end;

function TFilesFrame.doCopy: boolean;
var
  done : Boolean;
begin
  result := true;
  done := true;

  Screen.Cursor := crHourGlass;
  try
    Glob.HomeDir :=Trim(Edit1.Text);
    Glob.TempDir := TPath.Combine(Glob.HomeDir, 'temp');

    done := ForceDirectories(Glob.TempDir);
    if done then
    begin
      log('Embedded Firebird');
      done := SaveRCDataToFile('FB', TPath.Combine(Glob.TempDir, 'fb.zip')) and done;
      log('SSL-Bibliotheken');
      done := SaveRCDataToFile('SSL', TPath.Combine(Glob.TempDir, 'ssl.zip')) and done;
      log('OpenSSL');
      done := SaveRCDataToFile('openssl', TPath.Combine(Glob.TempDir, 'openssl.zip')) and done;

      done := ForceDirectories( TPath.Combine(Glob.HomeDir, 'Zertifikate')) and done;
      done := SaveRCDataToFile('Zertifikate', TPath.Combine(Glob.HomeDir, 'Zertifikate\ZertifikateErzeugen.bat')) and done;
    end;
    unzipSSL;

    unzipOpenSSL;

    log('Fertig');
  except
    on e : exception do
    begin
      log( e.ToString );
    end;

  end;
  Screen.Cursor := crDefault;

  if not done then
  begin
    result := false;
    MessageDlg('Es ist ein Fehler beim Auspacken der Dateien passiert.' +
      #13#10 + 'Wählen sie einen anderen Pfad.',  mtWarning, [mbOK], 0);
  end;
end;

procedure TFilesFrame.log(text: string);
begin
  Memo1.Lines.Add(text);
  Memo1.Update;
end;

procedure TFilesFrame.prepare;
begin
  if ( SameText( GetEnvironmentVariable('COMPUTERNAME'), 'odin') = true) then
  begin
    Edit1.Text := 'D:\DelphiBin\MitbestimmIT\Setup';
  end
  else
  begin
    var path : string;
    path := GetEnvironmentVariable('ProgramFiles')+'\';
    Edit1.Text :=  TPAth.Combine( path, 'MitbestimmIT' );
  end;

  Memo1.Lines.Clear;
end;

procedure TFilesFrame.unzipOpenSSL;
var
  zip : TZipFile;
  path : string;
begin
  log('Entpacken SSL-Libs');
  zip := TZipFile.Create;
  zip.open(TPath.Combine(Glob.TempDir, 'ssl.zip'), zmRead );

  path := ExtractFilePath(ParamStr(0));
  // zur setup exe
  zip.ExtractAll(path);
  if not SameText( path, ExtractFilePath(TPath.Combine(Glob.HomeDir, 'test.zip') ) )then
  begin
    // falls Setup nicht im zielverzeichnis steht !!
    zip.ExtractAll(Glob.HomeDir );
  end;
  zip.Close;

end;

procedure TFilesFrame.unzipSSL;
var
  zip : TZipFile;
begin
  log('Entpacken OpenSSL');
  zip := TZipFile.Create;
  zip.Open(TPath.Combine(Glob.TempDir, 'openssl.zip'), zmRead);
  zip.ExtractAll(TPath.Combine(Glob.HomeDir, 'Zertifikate\openssl'));
  zip.Close;

end;

end.
