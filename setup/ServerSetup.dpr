program ServerSetup;

{$R *.dres}

uses
  Vcl.Forms,
  u_glob in 'u_glob.pas',
  f_main_setup in 'f_main_setup.pas' {MainSetupForm},
  fr_admin in 'fr_admin.pas' {AdminFrame: TFrame},
  u_totp in 'totp\u_totp.pas',
  fr_database in 'fr_database.pas' {DatabaseFrame: TFrame},
  m_db_create in '..\server\m_db_create.pas' {CreateDBMode: TDataModule},
  fr_zertifikate in 'fr_zertifikate.pas' {ZertifikatFrame: TFrame},
  u_helper in 'u_helper.pas',
  fr_files in 'fr_files.pas' {FilesFrame: TFrame},
  m_res in 'm_res.pas' {Resmod: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainSetupForm, MainSetupForm);
  Application.CreateForm(TCreateDBMode, CreateDBMode);
  Application.CreateForm(TResmod, Resmod);
  Application.Run;
end.
