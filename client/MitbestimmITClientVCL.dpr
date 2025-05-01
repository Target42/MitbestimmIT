program MitbestimmITClientVCL;

{$R *.dres}

uses
  Vcl.Forms,
  f_main_client in 'f_main_client.pas' {MainClientForm},
  u_fonts in 'gui\u_fonts.pas',
  f_splash in 'f_splash.pas' {Splashform},
  f_info in 'gui\f_info.pas' {infoForm},
  f_planungsform in 'Planung\f_planungsform.pas' {Planungsform},
  fr_wahlverfahren in 'Planung\fr_wahlverfahren.pas' {WahlverfahrenFrame: TFrame},
  fr_wahlfristen in 'Planung\fr_wahlfristen.pas' {WahlfristenFrame: TFrame},
  u_BRWahlFristen in '..\berechnungen\u_BRWahlFristen.pas',
  fr_wahlvorstand in 'Planung\fr_wahlvorstand.pas' {WahlVorstandFrame: TFrame},
  fr_base in '..\lib\fr_base.pas' {BaseFrame: TFrame},
  f_WahlVorstandPerson in 'Planung\f_WahlVorstandPerson.pas' {WahlVorstandPersonForm},
  m_res in 'm_res.pas' {DataModule1: TDataModule},
  u_Wahlvorstand in '..\Wahlvorstand\u_Wahlvorstand.pas',
  u_json in '..\lib\u_json.pas',
  u_utils in '..\lib\u_utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

{$ifndef DEBUG}
  Splashform := TSplashform.Create(NIL);
  Splashform.Show;
  Splashform.Update;
{$ENDIF}
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TMainClientForm, MainClientForm);
  Application.CreateForm(TWahlVorstandPersonForm, WahlVorstandPersonForm);
  Application.Run;
end.
