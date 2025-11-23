unit u_rollen;

interface

const
  roAdmin        = 'admin';
  roWahlVorsitz  = 'vorsitz';
  roWahlVorstand = 'vorstand';
  roWahlHelfer   = 'helfer';
  roPublic       = 'all';


function getRollen : string;

implementation

uses
  System.Classes;

function getRollen : string;
var
  list : TStringList;
begin
  list := TStringList.create;
  list.Add(roAdmin);
  list.Add(roWahlVorsitz);
  list.Add(roWahlVorstand);
  list.Add(roWahlHelfer);
  list.Add(roPublic);

  Result := list.DelimitedText;
  list.Free;
end;

end.

