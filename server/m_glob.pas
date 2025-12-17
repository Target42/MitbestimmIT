unit m_glob;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter;

type
  TGlobMod = class(TDSServerModule)
  private
    { Private-Deklarationen }
  public
    function isPhaseActive( phase : string ) :Boolean;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses m_phase;

{$R *.dfm}

{ TGlobMod }

function TGlobMod.isPhaseActive(phase: string): Boolean;
begin
  Result := TPhasenMod.phaseActive(phase);
end;

end.

