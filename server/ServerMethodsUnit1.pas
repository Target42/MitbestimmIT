unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth;

type
  [TRoleAuth('user,admin')]
  TServerMethods1 = class(TDSServerModule)
  private
  public
    [TRoleAuth('user')]
    function hasConfig : boolean;
    [TRoleAuth('user')]
    function setInitialconfig( data : TJSONObject ) : TJSONObject;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;


{ TServerMethods1 }

function TServerMethods1.hasConfig: boolean;
begin
  Result := false;
end;

function TServerMethods1.setInitialconfig(data: TJSONObject): TJSONObject;
begin
  Result := NIL;
end;

end.

