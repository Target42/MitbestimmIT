unit fr_database;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Mask;

type
  TDatabaseFrame = class(TFrame)
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    GroupBox2: TGroupBox;
    LabeledEdit3: TLabeledEdit;
    GroupBox4: TGroupBox;
    BitBtn1: TBitBtn;
    LabeledEdit4: TLabeledEdit;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure LinkLabel1Click(Sender: TObject);
  private
  public
    procedure prepare;
    function checkDB : boolean;
  end;

implementation

{$R *.dfm}

uses
  m_db_create, system.IOUtils, u_glob, system.Zip, ShellAPI, m_res;

procedure TDatabaseFrame.BitBtn1Click(Sender: TObject);
var
  db : TCreateDBMode;
  dbname : string;
begin
  if trim(LabeledEdit2.Text) = '' then
  begin
    ShowMessage('Es muss ein Passwort vergeben werden !!');
    exit;
  end;
  if trim(LabeledEdit3.Text) = '' then
  begin
    ShowMessage('Es muss ein DB-Namevergeben werden !!');
    exit;
  end;

  Screen.Cursor := crSQLWait;
  if RadioGroup1.ItemIndex = 0 then
    dbname        := TPath.Combine( Glob.HomeDir, 'db\'+ExtractFileName(LabeledEdit3.Text))
  else
    dbname := LabeledEdit3.Text;

//  unzipDB( dbname );

  LabeledEdit3.Text := dbname;
  Glob.DBEmbedded := RadioGroup1.ItemIndex = 0;
  Glob.DBName     := LabeledEdit3.Text;
  Glob.DBHost     := LabeledEdit4.Text;


  db := TCreateDBMode.Create(nil);
  db.Embedded   := Glob.DBEmbedded;
  // sysdba zum anlegen
  db.DBUser     := LabeledEdit1.Text;
  db.DBPasswort := LabeledEdit2.Text;

  db.Host       := Glob.DBHost;
  DB.DBName     := Glob.DBName;

  db.UserPwd    := Glob.UserPWD;
  db.AdminPwd   := Glob.AdminPwd;
  db.AdminSecret:= Glob.Secret;

  try
    db.createDB;
  except
    on e : exception do
    begin
      ShowMessage(e.ToString);
    end;

  end;
  db.Free;
  Screen.Cursor := crDefault;
  ShowMessage('Datenbank wurde erzeugt')

end;

function TDatabaseFrame.checkDB: boolean;
var
  db : TCreateDBMode;
begin
  db := TCreateDBMode.Create(nil);
  db.Embedded   := Glob.DBEmbedded;
  // admin user zum Test
  db.DBUser     := 'admin';
  db.AdminPwd   := glob.AdminPwd;

  db.Host       := Glob.DBHost;
  DB.DBName     := Glob.DBName;

  Result := db.testConnection;
  db.Free;

  if Result then
    glob.writeData;
end;

procedure TDatabaseFrame.LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key >= #0) and  (Key <' ')) then
    exit;

  if RadioGroup1.ItemIndex = 0 then
  begin
    if not TPath.IsValidFileNameChar(key) then
      key := #0;
  end
  else
  begin
    if not TPath.IsValidPathChar(key) then
      Key := #0;
  end;
end;

procedure TDatabaseFrame.LinkLabel1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'https://www.firebirdsql.org/en/firebird-4-0', nil, nil, SW_SHOWNORMAL);
end;

procedure TDatabaseFrame.prepare;
begin
  LabeledEdit3.Text := TPath.Combine(ExtractFilePath(paramstr(0)), 'db\Wahl2026.fdb');
  LabeledEdit4.Text := 'localhost';

  if Glob.DBEmbedded then
    RadioGroup1.ItemIndex := 0
  else
    RadioGroup1.ItemIndex := 1;

  LabeledEdit1.Text := 'sysdba';
  LabeledEdit2.Text := 'masterkey';
  if Glob.DBName <> '' then
    LabeledEdit3.Text := Glob.DBName;
  if Glob.DBHost <> '' then
    LabeledEdit4.Text := Glob.DBHost;
end;

end.
