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
  m_db_create, system.IOUtils, u_glob, system.Zip, ShellAPI;

procedure TDatabaseFrame.BitBtn1Click(Sender: TObject);
var
  db : TCreateDBMode;
  dbname : string;
  path   : string;
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

  if RadioGroup1.ItemIndex = 0 then
  begin
    dbname        := TPath.Combine( Glob.HomeDir, 'db\'+ExtractFileName(LabeledEdit3.Text));
    ForceDirectories(ExtractFilePath(dbname));
  end
  else
    dbname := LabeledEdit3.Text;

//  unzipDB( dbname );

  LabeledEdit3.Text := dbname;
  Glob.DBEmbedded := RadioGroup1.ItemIndex = 0;
  Glob.DBUser     := LabeledEdit1.Text;
  Glob.DBPasswort := LabeledEdit2.Text;
  Glob.DBName     := LabeledEdit3.Text;
  Glob.DBHost     := LabeledEdit4.Text;


  db := TCreateDBMode.Create(nil);
  db.Embedded   := Glob.DBEmbedded;
  db.DBUser     := glob.DBUser;
  db.Host       := Glob.DBHost;
  db.DBPasswort := glob.DBPasswort;
  DB.DBName     := Glob.DBName;

  try
    db.createDB;
  except
    on e : exception do
    begin
      ShowMessage(e.ToString);
    end;

  end;
  db.Free;


end;

function TDatabaseFrame.checkDB: boolean;
var
  db : TCreateDBMode;
begin
  db := TCreateDBMode.Create(nil);
  db.Embedded   := Glob.DBEmbedded;
  db.DBUser     := glob.DBUser;
  db.Host       := Glob.DBHost;
  db.DBPasswort := glob.DBPasswort;
  DB.DBName     := Glob.DBName;

  Result := db.createDB;
  db.Free;
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
end;

end.
