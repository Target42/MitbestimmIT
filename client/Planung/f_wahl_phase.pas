unit f_wahl_phase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_BRWahlFristen, fr_base, Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  TWahlPhaseForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    DateTimePicker2: TDateTimePicker;
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    FWahlPhase: PTWahlPhase;
    procedure setWahlPhase( value : PTWahlPhase );
  public
    property WahlPhase: PTWahlPhase read FWahlPhase write setWahlPhase;
  end;

var
  WahlPhaseForm: TWahlPhaseForm;

implementation

{$R *.dfm}

{ TWahlPhaseForm }

procedure TWahlPhaseForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  FWahlPhase.start := DateTimePicker1.DateTime;
  FWahlPhase.ende  := DateTimePicker2.DateTime;
end;

procedure TWahlPhaseForm.setWahlPhase(value: PTWahlPhase);
begin
  FWahlPhase := value;

  Label1.Caption := FWahlPhase^.titel;

  Label3.Visible          := (FWahlPhase^.typ = dtZeitraum) or (FWahlPhase^.typ = dtZeitpunkte);
  DateTimePicker2.Visible := Label3.Visible;

  if FWahlPhase^.typ = dtZeitpunkte then
  begin
    DateTimePicker1.Kind := dtkDateTime;
    DateTimePicker2.Kind := dtkDateTime;
  end
  else
  begin
    DateTimePicker1.Kind := dtkDate;
    DateTimePicker2.Kind := dtkDate;
  end;

  DateTimePicker1.DateTime := FWahlPhase.start;
  DateTimePicker2.DateTime := FWahlPhase.ende;
end;

end.
