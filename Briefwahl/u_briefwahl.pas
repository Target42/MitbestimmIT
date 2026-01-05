unit u_briefwahl;

interface

uses
  System.JSON;

type
  TBriefwahl = class
    private
      const
        bwMa   = 'id';
        bwType = 'typ';
        bwDate = 'date';
        bwError= 'error';
        bwName = 'name';
    public
      type
        TEventType = ( etAntrag, etVErsendet, etEmpfangen);
    private
    FEvent: TEventType;
    FErrorText: string;
    FMA_ID: integer;
    FDate: TDateTime;
    FName: string;
    public
      constructor create;
      Destructor Destroy; override;


      property MA_ID: integer read FMA_ID write FMA_ID;
      property Name: string read FName write FName;
      property Date: TDateTime read FDate write FDate;
      property Event: TEventType read FEvent write FEvent;
      property ErrorText: string read FErrorText write FErrorText;

      procedure fromJson( data : TJSONObject );
      function toJson : TJSONObject;
  end;

implementation

uses
  u_json, System.SysUtils;

{ TBriefwahl }

constructor TBriefwahl.create;
begin

end;

destructor TBriefwahl.Destroy;
begin

  inherited;
end;

procedure TBriefwahl.fromJson(data: TJSONObject);
var
  s : string;
begin
  FMA_ID     := JInt( data, bwMa);
  FErrorText := JString( data, bwError);
  FDate      := JDouble( data, bwDate);
  FName      := JString( data, bwName );

  s := JString( data, bwType);
  if SameText(s, 'antrag') then            FEvent := etAntrag
  else if SameText(s, 'versendet') then    FEvent := etVErsendet
   else if SameText(s, 'empfangen') then   FEvent := etEmpfangen
end;

function TBriefwahl.toJson: TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace( Result, bwMa, FMA_ID);
  case FEvent of
    etAntrag:     JReplace( Result, bwType, 'antrag');
    etVErsendet:  JReplace( Result, bwType, 'versendet');
    etEmpfangen:  JReplace( Result, bwType, 'empfangen');
  end;
  JReplaceDouble( result, bwDate, FDate);
  JReplace( result, bwError, FErrorText);
  JReplace( result, bwName, FName);
end;

end.
