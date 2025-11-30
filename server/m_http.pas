unit m_http;

interface

uses
  System.SysUtils, System.Classes, IdContext, IdCustomHTTPServer,
  IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdHTTPServer, u_glob, Web.HTTPApp, Web.HTTPProd;

type
  THttpMod = class(TDataModule)
    IdHTTPServer1: TIdHTTPServer;
    IdAntiFreeze1: TIdAntiFreeze;
    PageProducer1: TPageProducer;
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure DataModuleCreate(Sender: TObject);
  private
    m_hostname : string;
    m_wwwroot : string;

    function GetFullComputerName: string;
  public
    function start : boolean;
    procedure stop;

    class function startHttp : boolean;
    class procedure stopHttp;
  end;

var
  HttpMod: THttpMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.IOUtils, Vcl.Forms, u_debug, Windows, CodeSiteLogging;

{ THttpMod }

procedure THttpMod.DataModuleCreate(Sender: TObject);
var
  filename : string;
begin
  m_wwwroot := Glob.HomeDir;
  m_hostname := GetFullComputerName;

  filename := TPath.Combine(m_wwwroot, 'index.html');
  if FileExists(filename) then
    PageProducer1.HTMLFile := filename;
end;

function THttpMod.GetFullComputerName: string;
const
  // Wir verwenden ComputerNameDnsFullyQualified für den vollständigen Namen (z.B. "server.domain.com")
  NameType = ComputerNameDnsFullyQualified;
var
  Buffer: array[0..255] of WideChar; // Puffer für den Namen
  BufferSize: DWORD;             // Größe des Puffers
  Success: Boolean;              // Prüft den Erfolg des API-Aufrufs
begin
  // Setze die anfängliche Puffergröße
  BufferSize := SizeOf(Buffer);

  // Initialisiere den Puffer mit Null-Zeichen
  FillChar(Buffer, BufferSize, 0);

  // Rufe die Windows API-Funktion auf
  Success := GetComputerNameEx(
    NameType,           // Gewünschter Name-Typ
    @Buffer,             // Zeiger auf den Puffer
    BufferSize         // Zeiger auf die Puffergröße
  );

  if Success then
  begin
    Result := StrPas(Buffer);
  end
  else
  begin
    Result := GetEnvironmentVariable('COMPUTERNAME');

  end;
end;

procedure THttpMod.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  sub      : string;
  filename : string;
  rootDoc  : Boolean;
begin
  AResponseInfo.ResponseNo := 400;

  rootDoc := SameText( ARequestInfo.Document, '/') or
             SameText( ARequestInfo.Document, '/index.htm') or
             SameText( ARequestInfo.Document, '/index.html');

  sub := StringReplace(ARequestInfo.Document, '/', '\', [rfReplaceAll]);
  filename := TPath.GetFullPath(m_wwwroot + sub);

  if filename.StartsWith(m_wwwroot) then
  begin
    if rootDoc then
    begin
{
      // aktivieren, wenn man die index.html testen möchte
      filename := TPath.Combine(m_wwwroot, 'index.html');
      if FileExists(filename) then
        PageProducer1.HTMLFile := filename;
 }
      AResponseInfo.ContentText := PageProducer1.Content;
      AResponseInfo.ResponseNo := 200;
    end
    else if FileExists(filename) then
    begin
      AResponseInfo.ContentStream := TFileStream.Create(filename, fmOpenRead + fmShareDenyNone);
      AResponseInfo.ResponseNo := 200;
    end
    else
    begin
      AResponseInfo.ContentText := 'Nix da !';
      CodeSite.SendError('Get-Fehler : %s', [ARequestInfo.Document]);
      CodeSite.SendError('Datei : %s', [filename]);
    end;
  end
  else
  begin
    CodeSite.SendError('Get-Fehler : %s', [ARequestInfo.Document]);
  end;
end;

procedure THttpMod.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if SameText( TagString, 'hostname') then        ReplaceText := m_hostname
  else if SameText( TagString, 'dsport') then     ReplaceText := intToStr( Glob.PortDS)
  else if SameText( TagString, 'httpport') then   ReplaceText := intToStr( Glob.PortHttp)
  else if SameText( TagString, 'httpsport') then  ReplaceText := intToStr( Glob.PortHttps)
  else if SameText( TagString, 'clientport') then ReplaceText := intToStr( Glob.PortClientHttp);
end;

function THttpMod.start: boolean;
begin
  CodeSite.EnterMethod('start');
  if Glob.PortClientHttp = 0 then
  begin
    Result := true;
    CodeSite.SendError('Kein http-Port gesetzt');
    CodeSite.ExitMethod('start');
    exit;
  end;

  m_wwwroot := TPath.Combine(Glob.HomeDir, 'client');
  Result := false;
  try
    IdHTTPServer1.DefaultPort := Glob.PortClientHttp;
    IdHTTPServer1.Active := true;
    result := IdHTTPServer1.Active;
    CodeSite.Send(Format('http client %d', [Glob.PortClientHttp]));
  except
    on e : exception do
    begin
      CodeSite.SendError(e.ToString);
    end;
  end;
  CodeSite.ExitMethod('start');

end;

class function THttpMod.startHttp: boolean;
begin
  Result := false;

  if Assigned(HttpMod) then
    exit;

  Application.CreateForm(THttpMod, HttpMod);
  Result := HttpMod.start;
end;

procedure THttpMod.stop;
begin
  IdHTTPServer1.Active := false;
end;

class procedure THttpMod.stopHttp;
begin
  if Assigned(HttpMod) then
  begin
    HttpMod.stop;
    FreeAndNil(HttpMod);
  end;
end;

end.
