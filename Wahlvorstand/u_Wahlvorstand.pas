{
  This file is part of the MitbestimmIT project.

  Copyright (C) 2025 Stephan Winter

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <https://www.gnu.org/licenses/>.
}
unit u_Wahlvorstand;

interface

uses
  System.Generics.Collections, system.JSON, System.Classes;

const
  wvPersNr            = 'persnr';
  wvIDLogin           = 'login';
  wvIDAnrede          = 'anrede';
  wvIDName            = 'name';
  wvIDVorname         = 'vorname';
  wvIDStimmberechtigt = 'stimmberechtigt';
  wvIDRolle           = 'rolle';
  wvIDMail            = 'mail';

type
  IWahlvorstandPerson = interface;
  IWahlvorstand       = interface;
  TWahlvorstandsRolle = (wvUnbekannt, wvVorsitz, wvStellvertretung, wvErsatz, wvGewerkschaft);

  IWahlvorstandPerson = interface
    ['{49C3CA09-7600-4881-A484-EDE5237C82F2}']
    // private
    function getPersNr : string;
    procedure setPersNr( value : string );
    function GetName: string;
    procedure SetName(const Value: string);
    function GetVorname: string;
    procedure SetVorname(const Value: string);
    function GetLogin: string;
    procedure SetLogin(const Value: string);
    function GetStimmberechtigt: boolean;
    procedure SetStimmberechtigt(const Value: boolean);
    function GetRolle: TWahlvorstandsRolle;
    procedure SetRolle(const Value: TWahlvorstandsRolle);
    function GeteMail: string;
    procedure SeteMail(const Value: string);
    function GetAnrede: string;
    procedure SetAnrede(const Value: string);

    //public

    property PersNr : string read getPersNr write setPersNr;
    property Login: string read GetLogin write SetLogin;
    property Anrede: string read GetAnrede write SetAnrede;
    property Name: string read GetName write SetName;
    property Vorname: string read GetVorname write SetVorname;
    property Stimmberechtigt: boolean read GetStimmberechtigt write SetStimmberechtigt;
    property Rolle: TWahlvorstandsRolle read GetRolle write SetRolle;
    property eMail: string read GeteMail write SeteMail;

    function toJSON : TJSONObject;
    procedure fromJSON( data : TJSONObject );

    procedure release;
  end;

  IWahlvorstand       = interface
    ['{2292905C-5138-42C7-9464-27DD0EE62745}']
    // private
    function getItems : TList<IWahlvorstandPerson>;
    //public

    property Items : TList<IWahlvorstandPerson> read getItems;

    function new : IWahlvorstandPerson;
    function add( login : string ) : IWahlvorstandPerson;
    function get( login : string ) : IWahlvorstandPerson;

    procedure delete( person : IWahlvorstandPerson );

    function toJSON : TJSONObject;
    procedure fromJSON( data : TJSONObject );

    procedure release;

  end;

function createWahlvorstand : IWahlvorstand;

function StringToTWahlvorstandsRolle(const Text: string): TWahlvorstandsRolle;
function TWahlvorstandsRolleToString(Rolle: TWahlvorstandsRolle): string;
procedure TWahlvorstandsRolleToList( list : TStrings );

implementation

uses
  System.SysUtils, u_json;

type
  TWahlvorstandPersonImpl =  class(TInterfacedObject, IWahlvorstandPerson)
  private
    m_persNr          : string;
    m_login           : string;
    m_name            : string;
    m_vorname         : string;
    m_stimmberechtigt : Boolean;
    m_rolle           : TWahlvorstandsRolle;
    m_mail            : string;
    m_anrede          : string;

    function getPersNr : string;
    procedure setPersNr( value : string );

    function GetName: string;
    procedure SetName(const Value: string);
    function GetVorname: string;
    procedure SetVorname(const Value: string);
    function GetLogin: string;
    procedure SetLogin(const Value: string);
    function GetStimmberechtigt: boolean;
    procedure SetStimmberechtigt(const Value: boolean);
    function GetRolle: TWahlvorstandsRolle;
    procedure SetRolle(const Value: TWahlvorstandsRolle);
    function GeteMail: string;
    procedure SeteMail(const Value: string);
    function GetAnrede: string;
    procedure SetAnrede(const Value: string);
  public
    constructor create;
    Destructor Destroy; override;

    function toJSON : TJSONObject;
    procedure fromJSON( data : TJSONObject );

    procedure release;

  end;

  TWahlvorstandImpl = class(TInterfacedObject, IWahlvorstand)
  private
    m_items : TList<IWahlvorstandPerson>;
    function getItems : TList<IWahlvorstandPerson>;
  public
    constructor create;
    Destructor Destroy; override;

    function new : IWahlvorstandPerson;
    function add( login : string ) : IWahlvorstandPerson;
    function get( login : string ) : IWahlvorstandPerson;
    procedure delete( person : IWahlvorstandPerson );

    function toJSON: TJSONObject;
    procedure fromJSON( data : TJSONObject );

    procedure release;

  end;


{ TWahlvorstandImpl }

function TWahlvorstandImpl.add(login: string): IWahlvorstandPerson;
begin

end;

constructor TWahlvorstandImpl.create;
begin
  m_items := TList<IWahlvorstandPerson>.Create;
end;

procedure TWahlvorstandImpl.delete(person: IWahlvorstandPerson);
begin
  m_items.Remove(person);
  person.release;
end;

destructor TWahlvorstandImpl.Destroy;
begin
  release;
  m_items.Free;

  inherited;
end;

procedure TWahlvorstandImpl.fromJSON(data: TJSONObject);
var
  arr : TJSONArray;
  row : TJSONObject;
  i   : integer;
  person : IWahlvorstandPerson;
begin
  arr := JArray( data, 'personen');
  if not Assigned(arr) then
    exit;

 for i := 0 to pred(arr.Count) do

 begin
   row := getRow(arr, i);
   person := TWahlvorstandPersonImpl.create;
   m_items.Add(person);
   person.fromJSON(row);
 end;
end;

function TWahlvorstandImpl.get(login: string): IWahlvorstandPerson;
var
  person : IWahlvorstandPerson;
begin
  Result := NIL;
  for person in m_items do
  begin
    if SameText(login, person.Login) then
    begin
      Result := person;
      break;
    end;
  end;
  if not Assigned(Result) then
  begin
    Result := TWahlvorstandPersonImpl.create;
    Result.Login := login;
    m_items.Add(Result);
  end;
end;

function TWahlvorstandImpl.getItems: TList<IWahlvorstandPerson>;
begin
  Result := m_items;
end;

function TWahlvorstandImpl.new: IWahlvorstandPerson;
begin
  Result := TWahlvorstandPersonImpl.create;
  m_items.Add(Result);
end;

procedure TWahlvorstandImpl.release;
var
  person : IWahlvorstandPerson;
begin
  for person in m_items do
    person.release;
  m_items.Clear;
end;

function TWahlvorstandImpl.toJSON: TJSONObject;
var
  arr : TJSONArray;
  person : IWahlvorstandPerson;
begin
  Result := TJSONObject.Create;
  arr := TJSONArray.Create;
  for person in m_items do
    arr.AddElement(person.toJSON);


  JReplace( Result, 'personen', arr);
end;

{ TWahlvorstandPersonImpl }

constructor TWahlvorstandPersonImpl.create;
begin

end;

destructor TWahlvorstandPersonImpl.Destroy;
begin

  inherited;
end;

procedure TWahlvorstandPersonImpl.fromJSON(data: TJSONObject);
begin
  m_persNr            := JString( data, wvPersNr );
  m_login             := JString( data, wvIDLogin);
  m_anrede            := JString( data, wvIDAnrede);
  m_name              := JString( data, wvIDName);
  m_vorname           := JString( data, wvIDVorname);
  m_stimmberechtigt   := JBool(  data,  wvIDStimmberechtigt);
  m_mail              := JString( data, wvIDMail);
  m_rolle             := StringToTWahlvorstandsRolle(JString( data, wvIDRolle));
end;

function TWahlvorstandPersonImpl.GetAnrede: string;
begin
  Result := m_anrede;
end;

function TWahlvorstandPersonImpl.GeteMail: string;
begin
  Result := m_mail;
end;

function TWahlvorstandPersonImpl.GetLogin: string;
begin
  Result := m_login;
end;

function TWahlvorstandPersonImpl.GetName: string;
begin
  Result := m_name;
end;

function TWahlvorstandPersonImpl.getPersNr: string;
begin
  Result := m_persNr;
end;

function TWahlvorstandPersonImpl.GetRolle: TWahlvorstandsRolle;
begin
  Result :=  m_rolle;
end;

function TWahlvorstandPersonImpl.GetStimmberechtigt: boolean;
begin
  Result := m_stimmberechtigt;
end;

function TWahlvorstandPersonImpl.GetVorname: string;
begin
  Result := m_vorname;
end;

procedure TWahlvorstandPersonImpl.release;
begin

end;

procedure TWahlvorstandPersonImpl.SetAnrede(const Value: string);
begin
  m_anrede := value;
end;

procedure TWahlvorstandPersonImpl.SeteMail(const Value: string);
begin
  m_mail := value;
end;

procedure TWahlvorstandPersonImpl.SetLogin(const Value: string);
begin
  m_login := value;
end;

procedure TWahlvorstandPersonImpl.SetName(const Value: string);
begin
  m_name := value;
end;

procedure TWahlvorstandPersonImpl.setPersNr(value: string);
begin
  m_persNr := value;
end;

procedure TWahlvorstandPersonImpl.SetRolle(const Value: TWahlvorstandsRolle);
begin
  m_rolle := value;

  case m_rolle of
    wvVorsitz:
      begin
        m_stimmberechtigt := true;
      end;
    wvStellvertretung:
      begin
        m_stimmberechtigt := true;
      end;
    wvErsatz:
      begin
        m_stimmberechtigt := false
      end;
    wvGewerkschaft:
      begin
        m_stimmberechtigt := false
      end;
  end;
end;

procedure TWahlvorstandPersonImpl.SetStimmberechtigt(const Value: boolean);
begin
  m_stimmberechtigt := value;
end;

procedure TWahlvorstandPersonImpl.SetVorname(const Value: string);
begin
  m_vorname := value;
end;

function TWahlvorstandPersonImpl.toJSON: TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace(Result, wvPersNr,            m_persNr);
  JReplace(Result, wvIDLogin,           m_login );
  JReplace(Result, wvIDAnrede,          m_anrede);
  JReplace(Result, wvIDName,            m_name );
  JReplace(Result, wvIDVorname,         m_vorname );
  JReplace(Result, wvIDStimmberechtigt, m_stimmberechtigt );
  JReplace(Result, wvIDRolle,           TWahlvorstandsRolleToString(m_rolle));
  JReplace(Result, wvIDMail,            m_mail );
end;


function TWahlvorstandsRolleToString(Rolle: TWahlvorstandsRolle): string;
begin
  case Rolle of
    wvVorsitz: Result := 'Vorsitz';
    wvStellvertretung: Result := 'Stellvertretung';
    wvErsatz: Result := 'Ersatz';
    wvGewerkschaft: Result := 'Gewerkschaft';
  else
    Result := 'Unbekannt';
  end;
end;

function StringToTWahlvorstandsRolle(const Text: string): TWahlvorstandsRolle;
begin
  if Text = 'Vorsitz' then
    Result := wvVorsitz
  else if Text = 'Stellvertretung' then
    Result := wvStellvertretung
  else if Text = 'Ersatz' then
    Result := wvErsatz
  else if Text = 'Gewerkschaft' then
    Result := wvGewerkschaft
  else
    Result := wvUnbekannt;
end;

procedure TWahlvorstandsRolleToList( list : TStrings );
begin
  list.Add(TWahlvorstandsRolleToString(wvVorsitz));
  list.Add(TWahlvorstandsRolleToString(wvStellvertretung));
  list.Add(TWahlvorstandsRolleToString(wvErsatz));
  list.Add(TWahlvorstandsRolleToString(wvGewerkschaft));
  list.Add(TWahlvorstandsRolleToString(wvUnbekannt));
end;

function createWahlvorstand : IWahlvorstand;
begin
  Result := TWahlvorstandImpl.create;
end;

end.
