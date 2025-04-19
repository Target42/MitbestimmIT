program MitbestimmITClientVCL;

uses
  Vcl.Forms,
  f_main_client in 'f_main_client.pas' {MainClientForm},
  u_BER_Berechnungen in '..\berechnungen\u_BER_Berechnungen.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainClientForm, MainClientForm);
  Application.Run;
end.
