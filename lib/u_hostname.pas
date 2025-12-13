unit u_hostname;

interface

function GetFullyQualifiedHostName: string;

implementation

uses
  Windows, WinSock2, SysUtils;

function GetFullyQualifiedHostName: string;
const
  // Definiert die maximale Puffergröße für den Hostnamen
  MAX_HOSTNAME_LEN = 256;
var
  WSAData: TWSAData;     // Datenstruktur für die Winsock-Initialisierung
  HostName: array[0..MAX_HOSTNAME_LEN] of AnsiChar; // Puffer für den einfachen Hostnamen
  PAddr: PInAddr;        // Pointer für die IP-Adresse
  HostInfo: PHostEnt;    // Pointer auf die Struktur der Host-Informationen
  ErrCode: Integer;      // Fehlercode
begin
  Result := '';

  // 1. Winsock-Bibliothek initialisieren
  if WSAStartup(MakeWord(2, 2), WSAData) <> 0 then
  begin
    // Fehler bei der Initialisierung
    Exit;
  end;

  try
    // 2. Einfachen Hostnamen abrufen
    if gethostname(@HostName, SizeOf(HostName)) = SOCKET_ERROR then
    begin
      // Fehlercode abrufen, falls nötig: ErrCode := WSAGetLastError;
      Exit;
    end;

    // Einfachen Hostnamen speichern (als Fallback)
    Result := Trim(string(HostName));

    // 3. DNS-Lookup auf Basis des einfachen Hostnamens (gethostbyname)
    //    Dies versucht, den FQDN zu ermitteln.
    HostInfo := gethostbyname(HostName);

    if Assigned(HostInfo) then
    begin
      // 4. Prüfen, ob der FQDN verfügbar ist
      if HostInfo^.h_name <> nil then
      begin
        // h_name enthält den FQDN, wenn der DNS-Server ihn liefert.
        Result := Trim(string(HostInfo^.h_name));
      end;
      // Anmerkung: Die Rückgabe von gethostbyname muss NICHT manuell freigegeben werden.
    end
    else
    begin
      // Fehler bei gethostbyname. Den einfachen Hostnamen beibehalten.
      ErrCode := WSAGetLastError;
      OutputDebugString(PChar('gethostbyname Fehler: ' + IntToStr(ErrCode)));
    end;

  finally
    // 5. Winsock-Bibliothek beenden
    WSACleanup;
  end;
end;
end.
