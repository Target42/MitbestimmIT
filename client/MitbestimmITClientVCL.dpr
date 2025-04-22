program MitbestimmITClientVCL;

{$R *.dres}

uses
  Vcl.Forms,
  f_main_client in 'f_main_client.pas' {MainClientForm},
  u_fonts in 'gui\u_fonts.pas',
  f_splash in 'f_splash.pas' {Splashform};

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
