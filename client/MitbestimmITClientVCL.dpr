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
  m_res in 'm_res.pas' {ResMod: TDataModule},
  u_Wahlvorstand in '..\Wahlvorstand\u_Wahlvorstand.pas',
  u_json in '..\lib\u_json.pas',
  u_utils in '..\lib\u_utils.pas',
  fr_PlanStart in 'Planung\fr_PlanStart.pas' {WahlPlanungStartFrame: TFrame},
  f_PassWord in 'gui\f_PassWord.pas' {PasswordDlg},
  f_waehlerliste in 'wähler\f_waehlerliste.pas' {WaehlerlisteForm},
  f_wahlhelfer in 'Wahllokal\f_wahlhelfer.pas' {WahlhelferForm},
  f_wahlhelfer_person in 'Wahllokal\f_wahlhelfer_person.pas' {WahlhelferPersonForm},
  u_Wahlhelfer in '..\Wahllokale\u_Wahlhelfer.pas',
  u_WahlhelferListe in '..\Wahllokale\u_WahlhelferListe.pas',
  f_wahlklokalForm in 'Wahllokal\f_wahlklokalForm.pas' {WahllokalForm},
  m_glob in 'm_glob.pas' {GM: TDataModule},
  f_wahllokalRaum in 'Wahllokal\f_wahllokalRaum.pas' {WahllokalRaumform},
  u_wahllokal in '..\Wahllokale\u_wahllokal.pas',
  u_ComandLineConfig in 'cli\u_ComandLineConfig.pas',
  u_ComandOptions in 'cli\u_ComandOptions.pas',
  f_connet in 'gui\f_connet.pas' {ConnectForm};

{$R *.res}

begin
{$ifdef DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

{$ifndef DEBUG}
  Splashform := TSplashform.Create(NIL);
  Splashform.Show;
  Splashform.Update;
{$ENDIF}
  Application.CreateForm(TResMod, ResMod);
  Application.CreateForm(TGM, GM);
  Application.CreateForm(TMainClientForm, MainClientForm);
  Application.CreateForm(TWahllokalRaumform, WahllokalRaumform);

  Application.Run;
end.
