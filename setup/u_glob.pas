unit u_glob;

interface

type
  TGlob = class

  private
    FHomeDir: string;
    FTempDir: string;
    FDBEmbedded: boolean;
    FDBHost: string;
    FDBName: string;
    FDBUser: string;
    FDBPasswort: string;
    FAdminPwd: string;
    FFaktor2: boolean;
    FZertifikatPWD: string;
    FSMTPHost: string;
    FSMTPPort: integer;
    FSMTPUser: string;
    FSMTPPasswort: string;
    FSMTPNotUsed: boolean;
    FFileName: string;
    FSecret: string;
  public
    constructor create;
    property FileName: string read FFileName write FFileName;
    property HomeDir: string read FHomeDir write FHomeDir;
    property TempDir: string read FTempDir write FTempDir;

    property DBEmbedded: boolean read FDBEmbedded write FDBEmbedded;
    property DBHost: string read FDBHost write FDBHost;
    property DBName: string read FDBName write FDBName;
    property DBUser: string read FDBUser write FDBUser;
    property DBPasswort: string read FDBPasswort write FDBPasswort;

    property AdminPwd: string read FAdminPwd write FAdminPwd;
    property Faktor2: boolean read FFaktor2 write FFaktor2;
    property Secret: string read FSecret write FSecret;

    property ZertifikatPWD: string read FZertifikatPWD write FZertifikatPWD;

    property SMTPNotUsed: boolean read FSMTPNotUsed write FSMTPNotUsed;
    property SMTPHost: string read FSMTPHost write FSMTPHost;
    property SMTPPort: integer read FSMTPPort write FSMTPPort;
    property SMTPUser: string read FSMTPUser write FSMTPUser;
    property SMTPPasswort: string read FSMTPPasswort write FSMTPPasswort;

    function writeData : boolean;
    function readData : boolean;


  end;

var
  Glob : TGlob;

implementation

uses
  System.SysUtils, system.IniFiles;

{ TGlob }

constructor TGlob.create;
begin
  FFileName := ExtractFilePath(ParamStr(0)) + 'config.ini';
end;

function TGlob.readData: boolean;
var
  ini : TIniFile;
begin
  Result := FileExists(FFileName);
  if not Result then
    exit;

  ini := TIniFile.Create(FFileName);
  FHomeDir      := ini.ReadString('app', 'homedir', '');
  FTempDir      := ini.ReadString('app', 'tempir', '');

  FDBEmbedded   := ini.ReadBool  ('db', 'embedded', false);
  FDBHost       := ini.ReadString('db', 'host', '');
  FDBName       := ini.ReadString('db', 'name', '');
  FDBUser       := ini.ReadString('db', 'user', '');
  FDBPasswort   := ini.ReadString('app', 'pwd', '');

  FAdminPwd     := ini.ReadString('admin', 'pwd', '');
  FFaktor2      := ini.ReadBool  ('admin', 'factor2', false);
  FSecret       := ini.ReadString('admin', 'secret', '');

  FZertifikatPWD:= ini.ReadString('ssl', 'pwd', '');

  FSMTPHost     := ini.ReadString('smtp', 'host', '');
  FSMTPPort     :=ini.ReadInteger('smtp', 'port', 0);
  FSMTPUser     := ini.ReadString('smtp', 'user', '');
  FSMTPPasswort := ini.ReadString('smtp', 'pwd', '');
  FSMTPNotUsed  := ini.ReadBool  ('smtp', 'norused', true);

  ini.Free;

end;

function TGlob.writeData: boolean;
var
  ini : TIniFile;
begin
  Result := false;

  if FFileName = '' then
    exit;

  ini := TIniFile.Create(FFileName);
  ini.WriteString('app', 'homedir', FHomeDir);
  ini.WriteString('app', 'tempir', FTempDir);

  ini.WriteBool  ('db', 'embedded', FDBEmbedded);
  ini.WriteString('db', 'host', FDBHost);
  ini.WriteString('db', 'name', FDBName);
  ini.WriteString('db', 'user', FDBUser);
  ini.WriteString('app', 'pwd', FDBPasswort);

  ini.WriteString('admin', 'pwd', FAdminPwd);
  ini.WriteBool  ('admin', 'factor2', FFaktor2);
  ini.WriteString('admin', 'secret', FSecret);

  ini.WriteString('ssl', 'pwd', FZertifikatPWD);

  ini.WriteString('smtp', 'host', FSMTPHost);
  ini.WriteInteger('smtp', 'port', FSMTPPort);
  ini.WriteString('smtp', 'user', FSMTPUser);
  ini.WriteString('smtp', 'pwd', FSMTPPasswort);
  ini.WriteBool  ('smtp', 'norused', FSMTPNotUsed);

  ini.Free;
end;

initialization

  Glob := TGlob.Create;

finalization
  Glob.Free;
  Glob := nil;


end.
