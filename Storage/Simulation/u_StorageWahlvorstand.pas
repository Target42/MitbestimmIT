unit u_StorageWahlvorstand;

interface

uses
  i_Storage, System.JSON;

type
  TStorageWahlVorstandImpl = class( TInterfacedObject, IStorageWahlVorstand)
    private
    public
      constructor create;
      Destructor Destroy; override;

      function getVorstand : TJSONObject;
      function saveVorstand( data : TJSONObject ) : TJSONObject;
      function updatePerson( data : TJSONObject ) : TJSONObject;
      function removePerson( data : TJSONObject ) : TJSONObject;

      procedure release;
  end;

implementation

{ TStorageWahlVorstandImpl }

constructor TStorageWahlVorstandImpl.create;
begin

end;

destructor TStorageWahlVorstandImpl.Destroy;
begin

  inherited;
end;

function TStorageWahlVorstandImpl.getVorstand: TJSONObject;
begin

end;

procedure TStorageWahlVorstandImpl.release;
begin

end;

function TStorageWahlVorstandImpl.removePerson(data: TJSONObject): TJSONObject;
begin

end;

function TStorageWahlVorstandImpl.saveVorstand(data: TJSONObject): TJSONObject;
begin

end;

function TStorageWahlVorstandImpl.updatePerson(data: TJSONObject): TJSONObject;
begin

end;

end.
