unit u_glob;

interface

uses
  System.Classes;

type
  TGlob = class

  private
    m_data : TMemoryStream;
    FHomeDir: string;
    FTempDir: string;
    FDBEmbedded: boolean;
    FDBHost: string;
    FDBName: string;
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
    FKeyFile: string;
    FRootFile: string;
    FCertFile: string;
    FPortDS: integer;
    FPortHttp: integer;
    FPortHttps: integer;
    FPortClientHttp: integer;
    FSMTPTest: string;
    FSMTPOk: boolean;
    FUserPWD: string;
    FSMTPSSL: integer;
    FPlain: boolean;
    FDBPwdCheck: string;

    procedure CompressStream;
    procedure DecompressStream;

    procedure SavePlain;

  public
    constructor create;
    destructor Destroy; override;

    property FileName: string read FFileName write FFileName;
    property HomeDir: string read FHomeDir write FHomeDir;
    property TempDir: string read FTempDir write FTempDir;

    property DBEmbedded: boolean read FDBEmbedded write FDBEmbedded;
    property DBHost: string read FDBHost write FDBHost;
    property DBName: string read FDBName write FDBName;
    property UserPWD: string read FUserPWD write FUserPWD;
    property DBPwdCheck: String read FDBPwdCheck write FDBPwdCheck;

    property AdminPwd: string read FAdminPwd write FAdminPwd;
    property Faktor2: boolean read FFaktor2 write FFaktor2;
    property Secret: string read FSecret write FSecret;

    property ZertifikatPWD: string read FZertifikatPWD write FZertifikatPWD;
    property KeyFile: string read FKeyFile write FKeyFile;
    property RootFile: string read FRootFile write FRootFile;
    property CertFile: string read FCertFile write FCertFile;

    property SMTPNotUsed: boolean read FSMTPNotUsed write FSMTPNotUsed;
    property SMTPHost: string read FSMTPHost write FSMTPHost;
    property SMTPPort: integer read FSMTPPort write FSMTPPort;
    property SMTPUser: string read FSMTPUser write FSMTPUser;
    property SMTPPasswort: string read FSMTPPasswort write FSMTPPasswort;
    property SMTPTest: string read FSMTPTest write FSMTPTest;
    property SMTPOk: boolean read FSMTPOk write FSMTPOk;
    property SMTPSSL: integer read FSMTPSSL write FSMTPSSL;

    property PortDS: integer read FPortDS write FPortDS;
    property PortHttp: integer read FPortHttp write FPortHttp;
    property PortHttps: integer read FPortHttps write FPortHttps;
    property PortClientHttp: integer read FPortClientHttp write FPortClientHttp;

    function writeData : boolean;
    function readData : boolean;

    property Plain: boolean read FPlain write FPlain;
  end;

var
  Glob : TGlob;

implementation

uses
  System.SysUtils, system.IniFiles, system.ZLib, u_helper, system.IOUtils;

{ TGlob }

procedure TGlob.CompressStream;
var
  ZStream: TZCompressionStream;
  OutStream : TStream;
begin
  m_data.Position := 0;
  OutStream := TFileStream.Create(FFileName, fmCreate );

  ZStream := TZCompressionStream.Create(clMax, OutStream);
  try
    ZStream.CopyFrom(m_data, m_data.Size);
  finally
    ZStream.Free;
  end;
  OutStream.free;
end;

constructor TGlob.create;
begin
  m_data    := TMemoryStream.Create;
  FFileName := ExtractFilePath(ParamStr(0)) + 'config.dat';
  FPortDS   := 9000;
  FPortHttp := 9001;
  FPortHttps:= 9002;
  FPortClientHttp := 8000;
  FUserPWD    := GenerateFirebirdPassword;
  FDBPwdCheck := GenerateFirebirdPassword;

  FHomeDir  := ExtractFilePath(ParamStr(0));

  FPlain    := false;

  if ParamCount >= 1 then
  begin
    for var i := 1 to ParamCount do
      begin
        if SameText(ParamStr(i), '/plain') then
          FPlain := true;
      end;
  end;

end;

procedure TGlob.DecompressStream;
var
  ZStream: TZDecompressionStream;
  InStream : TStream;
begin
  InStream := TFileStream.Create(FFileName, fmOpenRead + fmShareDenyNone);
  m_data.Clear;

  ZStream := TZDecompressionStream.Create(InStream);
  try
    m_data.CopyFrom(ZStream, 0);
  finally
    ZStream.Free;
  end;
  m_data.Position := 0;
  InStream.Free;
end;

destructor TGlob.Destroy;
begin
  m_data.Free;
end;

function TGlob.readData: boolean;
var
  ini : TMemIniFile;
begin
  Result := FileExists(FFileName);
  if not Result then
    exit;

  DecompressStream;

  ini := TMemIniFile.Create(m_data);

  FHomeDir      := ini.ReadString('app', 'homedir', '');
  FTempDir      := ini.ReadString('app', 'tempir', '');

  FDBEmbedded   := ini.ReadBool  ('db', 'embedded', false);
  FDBHost       := ini.ReadString('db', 'host', 'localhost');
  FDBName       := ini.ReadString('db', 'name', 'D:\DelphiBin\MitbestimmIT\Setup\db\wahl2026.fdb');
  FUserPWD      := ini.ReadString('db', 'user', FUserPWD);
  FDBPwdCheck   := ini.ReadString('db', 'pwdcheck', GenerateFirebirdPassword());

  FAdminPwd     := ini.ReadString('admin', 'pwd', '');
  FFaktor2      := ini.ReadBool  ('admin', 'factor2', false);
  FSecret       := ini.ReadString('admin', 'secret', '');

  FZertifikatPWD:= ini.ReadString('ssl', 'pwd', '');
  FKeyFile      := ini.ReadString('ssl', 'keyfile', '');
  FCertFile     := ini.ReadString('ssl', 'certfile', '');
  FRootFile     := ini.ReadString('ssl', 'rootfile', '');

  FSMTPHost     := ini.ReadString('smtp', 'host', '');
  FSMTPPort     := ini.ReadInteger('smtp', 'port', 465);
  FSMTPUser     := ini.ReadString('smtp', 'user', '');
  FSMTPPasswort := ini.ReadString('smtp', 'pwd', '');
  FSMTPNotUsed  := ini.ReadBool  ('smtp', 'notused', true);
  FSMTPTest     := ini.ReadString('smtp', 'testuser', '' );
  FSMTPOk       := ini.ReadBool('smt', 'ok', false);
  FSMTPSSL      := ini.ReadInteger('smt', 'ssl', 2);

  FPortDS       := ini.ReadInteger('ports', 'ds',   9000);
  FPortHttp     := ini.ReadInteger('ports', 'http', 9001);
  FPortHttps    := ini.ReadInteger('ports', 'https',9002);

  FPortClientHttp := ini.ReadInteger('ports', 'client',8080);

  ini.Free;

  if FPlain then
    SavePlain;

end;

procedure TGlob.SavePlain;
{$ifdef DEBUG}
var
  fname : string;
  st    : TFileStream;
{$endif}
begin
{$ifdef DEBUG}
  fname := TPath.Combine(TPath.GetHomePath, 'plain.txt');
  st := TFileStream.Create(fname, fmCreate + fmShareDenyNone);
  m_data.Position := 0;
  st.CopyFrom(m_data);
  st.Free;
{$endif}
end;

function TGlob.writeData: boolean;
var
  ini : TMemIniFile;
begin
  Result := false;

  if FFileName = '' then
    exit;

  ini := TMemIniFile.Create(m_data);
  ini.WriteString('app', 'homedir', FHomeDir);
  ini.WriteString('app', 'tempir',  FTempDir);

  ini.WriteBool  ('db', 'embedded', FDBEmbedded);
  ini.WriteString('db', 'host',     FDBHost);
  ini.WriteString('db', 'name',     FDBName);
  ini.WriteString('db', 'user',     FUserPWD);
  ini.WriteString('db', 'pwdcheck', FDBPwdCheck);

  ini.WriteString('admin', 'pwd',     FAdminPwd);
  ini.WriteBool  ('admin', 'factor2', FFaktor2);
  ini.WriteString('admin', 'secret',  FSecret);

  ini.WriteString('ssl', 'pwd',      FZertifikatPWD);
  ini.WriteString('ssl', 'keyfile',  FKeyFile);
  ini.WriteString('ssl', 'certfile', FCertFile);
  ini.WriteString('ssl', 'rootfile', FRootFile);

  ini.WriteString( 'smtp', 'host',     FSMTPHost);
  ini.WriteInteger('smtp', 'port',     FSMTPPort);
  ini.WriteString( 'smtp', 'user',     FSMTPUser);
  ini.WriteString( 'smtp', 'pwd',      FSMTPPasswort);
  ini.WriteBool  ( 'smtp', 'notused',  FSMTPNotUsed);
  ini.WriteString( 'smtp', 'testuser', FSMTPTest );
  ini.WriteBool(   'smtp', 'ok',       FSMTPOk);
  ini.WriteInteger('smtp', 'ssl',      FSMTPSSL);

  ini.WriteInteger('ports', 'ds',     FPortDS);
  ini.WriteInteger('ports', 'http',   FPortHttp);
  ini.WriteInteger('ports', 'https',  FPortHttps);
  ini.WriteInteger('ports', 'client', FPortClientHttp);

  ini.UpdateFile;
  ini.Free;

  if FPlain then
  begin
    SavePlain;
  end;


  CompressStream;
end;

initialization

  Glob := TGlob.Create;

finalization
  Glob.Free;
  Glob := nil;


end.
