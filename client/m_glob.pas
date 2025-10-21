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
  System.SysUtils, System.Classes, i_Storage, u_Waehlerliste, i_waehlerliste,
  Data.DB, Data.SqlExpr, Data.DBXDataSnap, Data.DBXCommon, IPPeerClient,
  Datasnap.DBClient, Datasnap.DSConnect, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

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
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    MAUserTab: TFDMemTable;
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure SQLConnection1AfterDisconnect(Sender: TObject);
  private
    FHost: string;
    FProtokoll: string;
    FPort: integer;
    FHostAddress: string;
    FUser: string;
    FPasswort: string;

    m_waehlerliste : IWaehlerliste;
    FIsAdmin: boolean;
    FWahlID: integer;
    FWahlName: string;
    FSimulation: boolean;


    procedure setHostAddress( value : string);
    procedure setUser( value : string);
  public
    property Protokoll: string read FProtokoll write FProtokoll;
    property Host     : string read FHost write FHost;
    property Port     : integer read FPort write FPort;

    property User     : string read FUser write setUser;
    property Passwort : string read FPasswort write FPasswort;
    property IsAdmin: boolean read FIsAdmin write FIsAdmin;

    property HostAddress: string read FHostAddress write setHostAddress;

    property WahlID: integer read FWahlID write FWahlID;

    property WaehlerListe : IWaehlerListe read m_waehlerliste;

    property WahlName: string read FWahlName write FWahlName;
    property Simulation: boolean read FSimulation write FSimulation;

    function connect: boolean;
    procedure disconnect;

    procedure updateMATab;
  end;

var
  GM: TGM;

implementation

uses
  System.RegularExpressions, Vcl.Dialogs, system.IOUtils, Vcl.Forms;

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

  FIsAdmin := SameText('admin_user', FUser);

  SQLConnection1.Params.Values['HostName']                  := FHost;
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

procedure TGM.DataModuleCreate(Sender: TObject);
begin
  m_waehlerliste := TWaehlerliste.create;

  setHostAddress('ds://localhost:211');
  FWahlID      := -1;
  FUser        := 'jd0815';
  FPasswort    := '0815';
end;

procedure TGM.DataModuleDestroy(Sender: TObject);
begin
  m_waehlerliste.release;
end;

procedure TGM.disconnect;
begin
  if SQLConnection1.Connected then
    SQLConnection1.Close;

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
  Match := TRegEx.Match(FHostAddress, Muster);
  if Match.Success then
  begin
    FProtokoll := Match.Groups[1].Value;
    FHost := Match.Groups[2].Value;
    FPort := StrToIntDef(Match.Groups[3].Value, -1);
  end;
end;


procedure TGM.setUser(value: string);
begin
  FUser := Trim(value);
  if FUser = '' then
    FUser := GetEnvironmentVariable('USERNAME');

end;

procedure TGM.SQLConnection1AfterDisconnect(Sender: TObject);
begin
  FWahlName  := '';
  FSimulation:= false;

  if Assigned( Screen.ActiveForm ) then
  begin
    Screen.ActiveForm.Close;
  end;
end;

procedure TGM.updateMATab;
begin
  FDBatchMove1.Options := [poClearDest, poCreateDest, poIdentityInsert];
  FDBatchMove1.Execute;
end;

end.
