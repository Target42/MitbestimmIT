unit i_Storage;

interface

uses
  System.JSON, u_WahlDef;

type
  IStorage                = interface;
  IStorageWahlDefinition  = interface;
  IStorageWahlVorstand    = interface;
  IStorageWaehlerListe    = interface;


  IStorage = interface
    ['{E1C3BAB1-EA26-422D-9667-4B74974FE995}']

    // private
    function getWahlDefininition : IStorageWahlDefinition;
    function getWahlVorstand     : IStorageWahlVorstand;
    function getWaehlerListe     : IStorageWaehlerListe;

    // public
    function connect( info : TJSONObject ) : Boolean;
    function isConnected : boolean;

    function select : TJSONObject;

    function getWahlen : TJSONObject;
    function load( data : TJSONObject) :boolean;
    function new : boolean;

    procedure close;

    procedure release;

    property WahlDefinition : IStorageWahlDefinition read getWahlDefininition;
    property WahlVorstand   : IStorageWahlVorstand read getWahlVorstand;
    property WaehlerListe   : IStorageWaehlerListe read getWaehlerListe;
  end;

  IStorageWahlDefinition  = interface
    ['{9530E465-B489-4245-8DE6-A579082AFA3D}']
    // private
    // public
    function getData : TWahlDef;
    function saveData( value : TWahlDef ) : boolean;

    procedure release;
  end;

  IStorageWahlVorstand    = interface
    ['{54F10517-B422-4837-A786-12A8E9515B2C}']
  end;

  IStorageWaehlerListe       = interface
    ['{8298252C-7AB1-459B-9688-7F895C26886D}']
    function upload( data : TJSONObject ) : boolean;
    function getWaehlerList : TJSONObject;
    function getChangeList : TJSONObject;
    function getChange( data : TJSONObject ) : TJSONObject;
    function getLastChangeDate : TJSONObject;

    procedure release;
  end;

  TStorageCreator = function : IStorage;

procedure registerStorage( name : string; func : TStorageCreator );

function getStorage( name : string ) : IStorage;


implementation

uses
  System.Generics.Collections;

var
  list : TDictionary<string, TStorageCreator>;

function getStorage( name : string ) : IStorage;
var
  func : TStorageCreator;
begin
  Result := NIL;

  if list.TryGetValue(name, func) then
  begin
    Result := func();
  end;
end;

procedure registerStorage( name : string; func : TStorageCreator );
begin
  list.AddOrSetValue(name, func);
end;

initialization
  list := TDictionary<string, TStorageCreator>.Create;

finalization
  list.Clear;
  list.Free;
end.
