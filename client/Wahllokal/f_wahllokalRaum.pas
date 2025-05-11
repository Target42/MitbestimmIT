unit f_wahllokalRaum;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, fr_base, u_wahllokal;

type
  TWahllokalRaumform = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    BaseFrame1: TBaseFrame;
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    FRaum: TWahlLokal;
    procedure setRaum( value : TWahlLokal );
  public
    property Raum: TWahlLokal read FRaum write setRaum;
  end;

var
  WahllokalRaumform: TWahllokalRaumform;

implementation

{$R *.dfm}

{ TWahllokalRaumform }

procedure TWahllokalRaumform.BaseFrame1OKBtnClick(Sender: TObject);
begin
  FRaum.Building  := LabeledEdit1.Text;
  FRaum.Raum      := LabeledEdit2.Text;
  FRaum.Stockwerk := LabeledEdit3.Text;

  FRaum.Von := DateTimePicker1.DateTime;
  FRaum.bis := DateTimePicker2.DateTime;

end;

procedure TWahllokalRaumform.setRaum(value: TWahlLokal);
begin
  FRaum := value;
  LabeledEdit1.Text := FRaum.Building;
  LabeledEdit2.Text := FRaum.Raum;
  LabeledEdit3.Text := FRaum.Stockwerk;

  DateTimePicker1.DateTime := FRaum.Von;
  DateTimePicker2.DateTime := FRaum.bis;
end;

end.
