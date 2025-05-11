unit u_wahllokal;

interface

uses
  System.JSON, u_json;

type
  TWahlLokal = class
    private
      FBuilding: string;
      FRaum: string;
      FStockwerk: string;
      FVon: TDateTime;
      FBis: TDateTime;
    public
      const
        WLBUILDING = 'gebaeude';
        WLROOM     = 'raum';
        WLSTOCKWERK= 'stockwerk';
        WLVON      = 'von';
        WLBIS      = 'bis';
    public
      constructor create;
      Destructor Destroy; override;

      property Building: string read FBuilding write FBuilding;
      property Raum: string read FRaum write FRaum;
      property Stockwerk: string read FStockwerk write FStockwerk;
      property Von: TDateTime read FVon write FVon;
      property Bis: TDateTime read FBis write FBis;

      function toJSON : TJSONObject;
      procedure fromJSON( data : TJSONObject );
  end;

implementation

uses
  System.SysUtils;

{ TWahlLokal }

constructor TWahlLokal.create;
begin

end;

destructor TWahlLokal.Destroy;
begin

  inherited;
end;

procedure TWahlLokal.fromJSON(data: TJSONObject);
var
  fmt : TFormatSettings;
begin
  fmt := TFormatSettings.Create('de-DE');

  FBuilding  := JString(data, WLBUILDING);
  FRaum      := JString(data, WLROOM);
  FStockwerk := JString(data, WLSTOCKWERK);
  FVon       := StrToDateTime( JString( data, WLVON), fmt);
  FBis       := StrToDateTime( JString( data, WLBIS), fmt);

end;

function TWahlLokal.toJSON: TJSONObject;
var
  fmt : TFormatSettings;
begin
  fmt := TFormatSettings.Create('de-DE');

  Result := TJSONObject.Create;
  JReplace( Result, WLBUILDING, FBuilding);
  JReplace( Result, WLROOM, FRaum);
  JReplace( Result, WLSTOCKWERK, FStockwerk);
  JReplace(Result, WLVON, DateTimeToStr(FVon, fmt));
  JReplace(Result, WLBIS, DateTimeToStr(FBis, fmt));
end;

end.
