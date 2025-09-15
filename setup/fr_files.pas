﻿unit fr_files;

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
    procedure FrameResize(Sender: TObject);
  private
    procedure log( text : string );
    procedure unzipOpenSSL;
    procedure unzipSSL;
    procedure upzipFB;
    procedure unzipFBClient;
    procedure unzipBat;
    procedure unzipClients;
  public
    function doCopy : boolean;

    procedure prepare;

    procedure search;
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

  Glob.HomeDir :=Trim(Edit1.Text);
  Glob.TempDir := TPath.Combine(Glob.HomeDir, 'temp');

  done := ForceDirectories(Glob.TempDir);
  if FileExists(TPath.Combine(Glob.TempDir, 'fb_client.zip')) then
  begin
    result := true;
    exit;
  end;
  ForceDirectories(TPath.Combine(Glob.HomeDir, 'db'));

  Screen.Cursor := crHourGlass;
  try
    if done then
    begin
      log('firebird client');
      done := SaveRCDataToFile('fbclient', TPath.Combine(Glob.TempDir, 'fb_client.zip')) and done;

      log('SSL-Bibliotheken');
      done := SaveRCDataToFile('SSL', TPath.Combine(Glob.TempDir, 'ssl.zip')) and done;
      log('OpenSSL');
      done := SaveRCDataToFile('openssl', TPath.Combine(Glob.TempDir, 'openssl.zip')) and done;
      log('Clients');
      done := SaveRCDataToFile('service', TPath.Combine(Glob.TempDir, 'service.zip')) and done;
      done := SaveRCDataToFile('console', TPath.Combine(Glob.TempDir, 'console.zip')) and done;

      done := SaveRCDataToFile('bat', TPath.Combine(Glob.TempDir, 'bat.zip')) and done;

      done := ForceDirectories( TPath.Combine(Glob.HomeDir, 'Zertifikate')) and done;
      done := SaveRCDataToFile('Zertifikate', TPath.Combine(Glob.HomeDir, 'Zertifikate\ZertifikateErzeugen.bat')) and done;
    end;

    unzipSSL;
    unzipOpenSSL;
    unzipClients;
    unzipFBClient;
    unzipBat;

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
  end
  else
    Glob.writeData;

end;

procedure TFilesFrame.FrameResize(Sender: TObject);
begin
  Edit1.Width := GroupBox1.Width - Edit1.Left - 64;
  SpeedButton1.Left := Edit1.Left + Edit1.Width + 32;
end;

procedure TFilesFrame.log(text: string);
begin
  Memo1.Lines.Add(text);
  Memo1.Update;
end;

procedure TFilesFrame.prepare;
begin
  Edit1.Text := Glob.HomeDir;

  Memo1.Lines.Clear;
end;

procedure TFilesFrame.search;
begin
  if findInPath('fbclient.dll') then
  begin
    Memo1.Lines.Add('fbclient.dll im Pfad gefunden.');
  end
  else
  begin
    Memo1.Lines.Add('fbclient.dll NICHT im Pfad gefunden.');
  end;
end;

procedure TFilesFrame.unzipBat;
var
  zip : TZipFile;
begin
  log('Entpacken Service-Batch');
  zip := TZipFile.Create;
  zip.Open(TPath.Combine(Glob.TempDir, 'bat.zip'), zmRead);
  zip.ExtractAll(Glob.HomeDir);
  zip.Close;
end;

procedure TFilesFrame.unzipClients;
var
  zip : TZipFile;
begin
  log('Server');
  zip := TZipFile.Create;

  zip.Open(TPath.Combine(Glob.TempDir, 'service.zip'), zmRead);
  zip.ExtractAll(Glob.HomeDir);
  zip.Close;

  zip.Open(TPath.Combine(Glob.TempDir, 'console.zip'), zmRead);
  zip.ExtractAll(Glob.HomeDir);
  zip.Close;

  zip.Free;
end;


procedure TFilesFrame.unzipFBClient;
var
  zip : TZipFile;
begin
  log('Entpacken FB-Client');
  zip := TZipFile.Create;
  zip.Open(TPath.Combine(Glob.TempDir, 'fb_client.zip'), zmRead);
  zip.ExtractAll(Glob.HomeDir);
  zip.Close;
  zip.Free;
end;

procedure TFilesFrame.unzipOpenSSL;
var
  zip : TZipFile;
begin
  log('Entpacken OpenSSL');
  zip := TZipFile.Create;
  zip.Open(TPath.Combine(Glob.TempDir, 'openssl.zip'), zmRead);
  zip.ExtractAll(TPath.Combine(Glob.HomeDir, 'Zertifikate\openssl'));
  zip.Close;
  zip.Free;
end;

procedure TFilesFrame.unzipSSL;
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
  zip.Free;

end;


procedure TFilesFrame.upzipFB;
var
  zip : TZipFile;
begin
  log('Entpacken Firebird');
  zip := TZipFile.Create;
  zip.Open(TPath.Combine(Glob.TempDir, 'fb.zip'), zmRead);
  zip.ExtractAll(Glob.HomeDir);
  zip.Close;
  zip.Free;
end;

end.
