unit f_WahlvorStand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_wahlvorstand, fr_base;

type
  TWahlVorstandForm = class(TForm)
    BaseFrame1: TBaseFrame;
    WahlVorstandFrame1: TWahlVorstandFrame;
  private
    { Private-Deklarationen }
  public
    class procedure execute;
  end;

var
  WahlVorstandForm: TWahlVorstandForm;

implementation

{$R *.dfm}

{ TWahlVorstandForm }

class procedure TWahlVorstandForm.execute;
begin
  Application.CreateForm(TWahlVorstandForm, WahlVorstandForm);
  WahlVorstandForm.ShowModal;
  WahlVorstandForm.Free;
end;

end.
