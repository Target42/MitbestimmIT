program MitbestimmITClientVCL;

{$R *.dres}

uses
  Vcl.Forms,
  f_main_client in 'f_main_client.pas' {MainClientForm},
  u_fonts in 'gui\u_fonts.pas',
  f_splash in 'f_splash.pas' {Splashform},
  f_info in 'gui\f_info.pas' {infoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Splashform := TSplashform.Create(NIL);
  Splashform.Show;
  Splashform.Update;

  Application.CreateForm(TMainClientForm, MainClientForm);
  Application.Run;
end.
