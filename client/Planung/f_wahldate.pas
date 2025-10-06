unit f_wahldate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_base;

type
  TWahlDateform = class(TForm)
    BaseFrame1: TBaseFrame;
    MonthCalendar1: TMonthCalendar;
    procedure FormCreate(Sender: TObject);
  private
    m_date : TDatetime;
    function GetDate: TDatetime;
    procedure SetDate(const Value: TDatetime);
    { Private-Deklarationen }
  public
    property Date: TDatetime read GetDate write SetDate;
  end;

var
  WahlDateform: TWahlDateform;

implementation

uses
  System.DateUtils;

{$R *.dfm}

{ TWahlDateform }

procedure TWahlDateform.FormCreate(Sender: TObject);
var
  da : TDateTime;
begin
  da := EncodeDate(2026, 05, 15);
  while DayOfTheWeek(da) >= 6 do
  begin
    da := incDay( da );
  end;
  MonthCalendar1.Date := da;

end;

function TWahlDateform.GetDate: TDatetime;
begin
  result := MonthCalendar1.Date;
end;

procedure TWahlDateform.SetDate(const Value: TDatetime);
begin
  m_date := value;
  MonthCalendar1.Date := m_date;
end;

end.
