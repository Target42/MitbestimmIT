unit m_admin;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter;

type
  TAdminMod = class(TDSServerModule)
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

