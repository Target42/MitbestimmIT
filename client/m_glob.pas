{
  This file is part of the MitbestimmIT project.

  Copyright (C) 2025 Stephan Winter

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <https://www.gnu.org/licenses/>.
}

unit m_glob;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, DbxCompressionFilter, u_simulation;

type
  {
    TGM Klasse
    Diese Klasse repräsentiert ein Datenmodul, das für die Verwaltung der Verbindung zu einer SQL-Datenbank verwendet wird.

    Eigenschaften:
      - Simulation: Gibt an, ob der Simulationsmodus aktiviert ist.
      - Protokoll: Das Protokoll, das für die Verbindung verwendet wird (z. B. TCP/IP).
      - Host: Der Hostname oder die IP-Adresse des Servers.
      - Port: Der Port, der für die Verbindung verwendet wird.
      - User: Der Benutzername für die Authentifizierung.
      - Passwort: Das Passwort für die Authentifizierung.
      - HostAddress: Die Adresse des Hosts, die über eine spezielle Setter-Methode gesetzt wird.

    Methoden:
      - setHostAddress(value: string): Setzt die Host-Adresse.
      - connect: Baut eine Verbindung zur Datenbank auf. Gibt true zurück, wenn die Verbindung erfolgreich ist.
      - isConnected: Überprüft, ob eine Verbindung zur Datenbank besteht. Gibt true zurück, wenn verbunden.
  }
  TGM = class(TDataModule)
    SQLConnection1: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FIsSimulation: boolean;
    FHost: string;
    FProtokoll: string;
    FPort: integer;
    FHostAddress: string;
    FUser: string;
    FPasswort: string;
    FSimulationPath: string;

    m_simulation : TSimulation;
    procedure setHostAddress( value : string);
    procedure setUser( value : string);
    function GetSimulation: TSimulation;
    procedure SetSimulation(const Value: TSimulation);
  public
    property IsSimulation: boolean read FIsSimulation write FIsSimulation;

    property Protokoll: string read FProtokoll write FProtokoll;
    property Host: string read FHost write FHost;
    property Port: integer read FPort write FPort;

    property User: string read FUser write setUser;
    property Passwort: string read FPasswort write FPasswort;

    property HostAddress: string read FHostAddress write setHostAddress;


    property SimulationPath: string read FSimulationPath;
    property Simulation: TSimulation read GetSimulation write SetSimulation;

    function connect : boolean;
    function isConnected : boolean;
  end;

var
  GM: TGM;

implementation

uses
  System.RegularExpressions, Vcl.Dialogs, system.IOUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TGM }

{
  Funktion: TGM.connect
  Beschreibung:
    Diese Funktion stellt eine Verbindung zu einer Datenbank her. Sie konfiguriert die Verbindungsparameter 
    basierend auf den Eigenschaften der Klasse und öffnet die Verbindung. Falls die Verbindung fehlschlägt, 
    wird eine Fehlermeldung angezeigt.

  Rückgabewert:
    - Boolean: Gibt `true` zurück, wenn die Verbindung erfolgreich hergestellt wurde, andernfalls `false`.

  Parameter:
    - Keine direkten Parameter, verwendet jedoch die Eigenschaften der Klasse:
      - FSimulation: Wenn `true`, wird keine echte Verbindung hergestellt und die Funktion gibt `true` zurück.
      - FHost: Der Hostname oder die IP-Adresse des Servers.
      - FUser: Der Benutzername für die Authentifizierung.
      - FPasswort: Das Passwort für die Authentifizierung.
      - FProtokoll: Das Protokoll, das für die Verbindung verwendet werden soll (z. B. 'ds', 'http', 'https').
      - FPort: Der Port, der für die Verbindung verwendet werden soll. Wenn `-1`, wird ein Standardport verwendet.

  Lokale Prozeduren:
    - setDSProtocol(protokol: string; defaultPort: integer):
      Konfiguriert das Kommunikationsprotokoll und den Port für die Verbindung.

  Ausnahmebehandlung:
    - Falls ein Fehler beim Öffnen der Verbindung auftritt, wird eine Fehlermeldung mit den Details des Fehlers angezeigt.

  Hinweise:
    - Die Funktion verwendet `SQLConnection1`, um die Verbindung zu konfigurieren und zu öffnen.
    - Die Protokoll- und Portkonfiguration erfolgt basierend auf dem Wert von `FProtokoll`.
}
function TGM.connect: boolean;

  procedure setDSProtocol( protokol : string; defaultPort : integer );
  begin
    SQLConnection1.Params.Values['CommunicationProtocol'] := 'tcp/ip';
    if FPort = -1 then
      SQLConnection1.Params.Values['Port'] := IntToStr(defaultPort)
    else
      SQLConnection1.Params.Values['Port'] := IntToStr(FPort);
  end;

begin
  Result := false;
  if FIsSimulation then
    Result := true
  else
  begin

    SQLConnection1.Params.Values['HostName']  := FHost;
    SQLConnection1.Params.Values['DSAuthenticationUser']      := FUser;
    SQLConnection1.Params.Values['DSAuthenticationPassword']  := FPasswort;

         if SameText('ds', FProtokoll) then      setDSProtocol('tcp/ip', 211)
    else if SameText('http', FProtokoll) then    setDSProtocol('http', 8080)
    else if SameText('https', FProtokoll) then   setDSProtocol('https', 8081);

    try
      SQLConnection1.Open;
      Result := SQLConnection1.Connected;
    except
      on e : exception do
      begin
        ShowMessage('Fehler beim Login.'+sLineBreak+e.ToString);
      end;
    end;
  end;
end;

procedure TGM.DataModuleCreate(Sender: TObject);
begin
  FSimulationPath := TPath.Combine(TPath.GetDocumentsPath, 'MitbestimmIT');
  ForceDirectories(FSimulationPath);
  m_simulation := NIL;
end;

procedure TGM.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(m_simulation) then
    FreeAndNil(m_simulation);
end;

function TGM.GetSimulation: TSimulation;
begin
  Result := m_simulation;
end;

{
  // Überprüft, ob eine Verbindung besteht.
  // Gibt den Wert von FSimulation zurück, wenn dieser True ist.
  // Falls FSimulation False ist, wird der Verbindungsstatus von SQLConnection1 überprüft.
  //
  // Rückgabewert:
  //   - True: Wenn entweder FSimulation True ist oder SQLConnection1 verbunden ist.
  //   - False: Wenn FSimulation False ist und SQLConnection1 nicht verbunden ist.
}
function TGM.isConnected: boolean;
begin
  Result := FIsSimulation;

  if not Result then
  begin
    Result := SQLConnection1.Connected;
  end;
end;

{
  /**
   * Setzt die Host-Adresse und extrahiert Protokoll, Host und Port aus der Adresse.
   *
   * @param value Die Host-Adresse als String. Erwartetes Format: "<Protokoll>://<Host>:<Port>".
   *
   * Die Methode analysiert die übergebene Host-Adresse und extrahiert das Protokoll,
   * den Hostnamen und den Port, falls die Adresse dem erwarteten Muster entspricht.
   * Falls die Adresse "simulation" ist (unabhängig von Groß-/Kleinschreibung), wird
   * der Host auf "Simulation" gesetzt und keine weiteren Analysen durchgeführt.
   *
   * Konstanten:
   * - Muster: Regulärer Ausdruck, der das Format der Host-Adresse definiert.
   *
   * Variablen:
   * - Match: Enthält das Ergebnis der regulären Ausdrucksprüfung.
   *
   * Felder:
   * - FHostAddress: Speichert die übergebene Host-Adresse.
   * - FProtokoll: Speichert das extrahierte Protokoll (z. B. "http", "https").
   * - FHost: Speichert den extrahierten Hostnamen.
   * - FPort: Speichert den extrahierten Port als Integer. Standardwert ist -1.
   * - FSimulation: Gibt an, ob die Adresse "simulation" ist.
   *
   * Hinweise:
   * - Falls der reguläre Ausdruck nicht übereinstimmt, bleiben FProtokoll, FHost und FPort leer bzw. auf Standardwerten.
   * - Die Methode ist robust gegenüber ungültigen Eingaben und verwendet StrToIntDef, um ungültige Portwerte abzufangen.
   */
}
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
  FIsSimulation   := SameText('simulation', FHostAddress);


  if not IsSimulation then
  begin
    Match := TRegEx.Match(FHostAddress, Muster);
    if Match.Success then
    begin
      FProtokoll := Match.Groups[1].Value;
      FHost := Match.Groups[2].Value;
      FPort := StrToIntDef(Match.Groups[3].Value, -1);
    end;
  end
  else
    FHost := 'Simulation';
end;

procedure TGM.SetSimulation(const Value: TSimulation);
begin
  if Assigned(m_simulation) then
    FreeAndNil(m_simulation);

  m_simulation := value;
  FIsSimulation := Assigned(m_simulation);
end;

procedure TGM.setUser(value: string);
begin
  FUser := Trim(value);
  if FUser = '' then
    FUser := GetEnvironmentVariable('USERNAME');

end;

end.
