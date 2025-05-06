unit u_Wahlhelfer;

interface

uses
  SysUtils, Classes, System.JSON;

type
  TWahlhelfer = class(TObject)
  private
    FPersonamnummer: String;
    FName: string;
    FVorname: string;
    FGeschlecht: string;
    FAbteilung: string;
    function GetPersonamnummer: String;
    procedure SetPersonamnummer(const Value: String);
    function GetName: string;
    procedure SetName(const Value: string);
    function GetVorname: string;
    procedure SetVorname(const Value: string);
    function GetGeschlecht: string;
    procedure SetGeschlecht(const Value: string);
    function GetAbteilung: string;
    procedure SetAbteilung(const Value: string);
  public
  const
    PERSNR = 'persnr';
    WNAME  = 'name';
    WVORNAME = 'vorname';
    WGESCHLECHT = 'geschlecht';
    WABTEILUNG = 'abteilung';
  public
    property Personamnummer: String read GetPersonamnummer write SetPersonamnummer;
    property Name: string read GetName write SetName;
    property Vorname: string read GetVorname write SetVorname;
    property Geschlecht: string read GetGeschlecht write SetGeschlecht;
    property Abteilung: string read GetAbteilung write SetAbteilung;

    function toJSON : TJSONObject;
    procedure fromJSON( data : TJSONObject );
    constructor Create;
  end;

implementation

uses
  u_json;

constructor TWahlhelfer.Create;
begin
  inherited Create;
  FPersonamnummer := '';
  FName := '';
  FVorname := '';
  FGeschlecht := '';
  FAbteilung := '';
end;

function TWahlhelfer.GetPersonamnummer: String;
begin
  Result := FPersonamnummer;
end;

procedure TWahlhelfer.SetPersonamnummer(const Value: String);
begin
  // Hier könnten Sie Validierungen für die Personamnummer hinzufügen
  FPersonamnummer := Value;
end;

function TWahlhelfer.GetName: string;
begin
  Result := FName;
end;

procedure TWahlhelfer.SetName(const Value: string);
begin
  FName := Value;
end;

function TWahlhelfer.GetVorname: string;
begin
  Result := FVorname;
end;

procedure TWahlhelfer.SetVorname(const Value: string);
begin
  FVorname := Value;
end;

function TWahlhelfer.toJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  JReplace( Result, PERSNR, FPersonamnummer);
  JReplace( Result, WNAME, FName);
  JReplace( Result, WVORNAME, FVorname);
  JReplace( Result, WGESCHLECHT, FGeschlecht);
  JReplace( Result, WABTEILUNG, FAbteilung);

end;

function TWahlhelfer.GetGeschlecht: string;
begin
  Result := FGeschlecht;
end;

procedure TWahlhelfer.SetGeschlecht(const Value: string);
begin
  // Hier könnten Sie Validierungen für das Geschlecht hinzufügen (z.B. nur 'M' oder 'W')
  FGeschlecht := Value;
end;

procedure TWahlhelfer.fromJSON(data: TJSONObject);
begin
  FPersonamnummer := JString( data, PERSNR );
  FName           := JString( data, WNAME );
  FVorname        := JString( data, WVORNAME );
  FGeschlecht     := JString( data, WGESCHLECHT );
  FAbteilung      := JString( data, WABTEILUNG );
end;

function TWahlhelfer.GetAbteilung: string;
begin
  Result := FAbteilung;
end;

procedure TWahlhelfer.SetAbteilung(const Value: string);
begin
  FAbteilung := Value;
end;

end.
