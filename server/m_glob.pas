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
    function setPhaseActive( phase : string; active : boolean ) :Boolean;
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

function TGlobMod.setPhaseActive(phase: string; active: boolean): Boolean;
begin
  Result := TPhasenMod.setPhaseActive(phase, active);
end;

end.

