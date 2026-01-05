unit u_simdata;

interface

uses
  System.JSON;

type
  TSimData = class
    private
    FWaehler: integer;
    FBriefWaehler: integer;
    FDoppelt: integer;
    FSumme: integer;
    FKorrektur: integer;
    FWahlzettel: integer;
    FInvalid_Urne: integer;
    FInavlid_Brief: integer;
    FRem: string;
    FIsEmpty: boolean;
    public
      constructor create;
      Destructor Destroy; override;

      property IsEmpty: boolean read FIsEmpty write FIsEmpty;
      property Waehler: integer read FWaehler write FWaehler;
      property BriefWaehler: integer read FBriefWaehler write FBriefWaehler;
      property Doppelt: integer read FDoppelt write FDoppelt;
      property Summe: integer read FSumme write FSumme;
      property Korrektur: integer read FKorrektur write FKorrektur;
      property Wahlzettel: integer read FWahlzettel write FWahlzettel;
      property Invalid_Urne: integer read FInvalid_Urne write FInvalid_Urne;
      property Invalid_Brief: integer read FInavlid_Brief write FInavlid_Brief;
      property Rem: string read FRem write FRem;

      function toJson : TJSONObject;
      procedure fromJson( data : TJSONObject );
  end;

implementation

{ TSimData }

uses u_json;

constructor TSimData.create;
begin

end;

destructor TSimData.Destroy;
begin

  inherited;
end;

procedure TSimData.fromJson(data: TJSONObject);
begin
  FIsEmpty      := JBool(data, 'empty');
  FBriefWaehler := JInt( data, 'brief');
  FWaehler      := JInt( data, 'waehler');
  FDoppelt      := JInt( data, 'doppelt');
  FSumme        := JInt( data, 'summe');
  FKorrektur    := JInt( data, 'korrektur');
  FWahlzettel   := JInt( data, 'zettel');
  FInvalid_Urne := JInt( data, 'urne_inv');
  FInavlid_Brief:= JInt( data, 'brief_inv');
  FRem          := JString( data, 'text');
end;

function TSimData.toJson: TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace( result, 'empty',      FIsEmpty);
  JReplace( result, 'brief',      FBriefWaehler);
  JReplace( result, 'waehler',    FWaehler);
  JReplace( result, 'doppelt',    FDoppelt);
  JReplace( result, 'summe',      FSumme);
  JReplace( result, 'korrektur',  FKorrektur);
  JReplace( result, 'zettel',     FWahlzettel);
  JReplace( result, 'urne_inv',   FInvalid_Urne);
  JReplace( result, 'brief_inv',  FInavlid_Brief);
  JReplace( result, 'text',       FRem );
end;

end.
