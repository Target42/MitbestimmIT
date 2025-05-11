unit m_glob;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient;

type
  TGM = class(TDataModule)
    SQLConnection1: TSQLConnection;
  private
    FSimulation: boolean;
    FHost: string;
    FProtokoll: string;
    FPort: integer;
    FHostAddress: string;
    FUser: string;
    FPasswort: string;

    procedure setHostAddress( value : string);
  public
    property Simulation: boolean read FSimulation write FSimulation;

    property Protokoll: string read FProtokoll write FProtokoll;
    property Host: string read FHost write FHost;
    property Port: integer read FPort write FPort;

    property User: string read FUser write FUser;
    property Passwort: string read FPasswort write FPasswort;

    property HostAddress: string read FHostAddress write setHostAddress;

    function connect : boolean;
    function isConnected : boolean;
  end;

var
  GM: TGM;

implementation

uses
  System.RegularExpressions;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TGM }

function TGM.connect: boolean;
begin
  if FSimulation then
    Result := true
  else
  begin

  end;
end;

function TGM.isConnected: boolean;
begin
  Result := FSimulation;

  if not Result then
  begin

  end;
end;

procedure TGM.setHostAddress(value: string);
const
  Muster = '^(\w+):\/\/([^:\/]+):(\d+)$';
var
  Match: TMatch;
begin
  FHostAddress  := value;
  FProtokoll    := '';
  FHost         := '';
  FPort         := -1;
  FSimulation   := SameText('simulation', FHostAddress);

  if not Simulation then
  begin
    Match := TRegEx.Match(FHostAddress, Muster);
    if Match.Success then
    begin
      FProtokoll := Match.Groups[1].Value;
      FHost := Match.Groups[2].Value;
      FPort := StrToIntDef(Match.Groups[3].Value, -1);
    end;
  end;
end;

end.
