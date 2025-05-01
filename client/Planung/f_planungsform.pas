unit f_planungsform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, JvWizard, JvExControls,
  fr_wahlverfahren, fr_wahlfristen, u_BRWahlFristen, fr_wahlvorstand;

type
  TPlanungsform = class(TForm)
    StatusBar1: TStatusBar;
    JvWizard1: TJvWizard;
    JvWizardWelcomePage1: TJvWizardWelcomePage;
    WahlverfahrenFrame1: TWahlverfahrenFrame;
    JvWizardInteriorPage1: TJvWizardInteriorPage;
    WahlfristenFrame1: TWahlfristenFrame;
    JvWizardInteriorPage2: TJvWizardInteriorPage;
    WahlVorstandFrame1: TWahlVorstandFrame;
    procedure FormCreate(Sender: TObject);
  private
    m_fristen : TWahlFristen;
  public
    class procedure Execute;
  end;

var
  Planungsform: TPlanungsform;

implementation

{$R *.dfm}

{ TPlanungsform }

class procedure TPlanungsform.Execute;
begin
  Application.CreateForm(TPlanungsform, Planungsform);
  Planungsform.ShowModal;
  Planungsform.Free;
end;

procedure TPlanungsform.FormCreate(Sender: TObject);
begin
  m_fristen.Verfahren := wvAllgemein;
  WahlverfahrenFrame1.init(@m_fristen);

  WahlfristenFrame1.init(@m_fristen);
  WahlfristenFrame1.setDefaultDate(StrToDate('15.5.2026'));


end;

end.
