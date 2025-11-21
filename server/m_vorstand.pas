unit m_vorstand;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.Provider, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.JSON, u_Wahlvorstand, u_rollen;

type
  [TRoleAuth(roWahlVorsitz +' ' +roWahlVorstand)]
  TVortandMod = class(TDSServerModule)
    ListMAQry: TFDQuery;
    ListMAQryWV_ROLLE: TStringField;
    ListMAQryWV_CHEF: TStringField;
    ListMAQryMA_ID: TIntegerField;
    ListMAQryMA_PERSNR: TStringField;
    ListMAQryMA_NAME: TStringField;
    ListMAQryMA_VORNAME: TStringField;
    ListMAQryMA_GENDER: TStringField;
    ListMAQryMA_ABTEILUNG: TStringField;
    ListMAQryMA_MAIL: TStringField;
    ListMAQryMA_GEB: TDateField;
    LoginQry: TFDQuery;
    LoginQryMW_LOGIN: TStringField;
    LoginQryMA_ID: TIntegerField;
    DelQry: TFDQuery;
    UpdateWVQry: TFDQuery;
    UpdateLoginQry: TFDQuery;
    UpdateMailQry: TFDQuery;
    AddVorstandQry: TFDQuery;
    MAPWDTab: TFDTable;
  private
    { Private-Deklarationen }
    procedure addMAData( person : IWahlvorstandPerson );
    procedure addLogin( person : IWahlvorstandPerson );
  public
    [TRoleAuth(roPublic)]
    function getlist : TJSONObject;

    function add( data : TJSONObject ) : TJSONObject;
    function get( ma_id : integer ) : TJSONObject;
    function save( data : TJSONObject ) : TJSONObject;

    [TRoleAuth(roWahlVorsitz)]
    function delete( data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_db, u_json, System.Variants, m_log;

{$R *.dfm}

function TVortandMod.add(data: TJSONObject): TJSONObject;
var
  person : IWahlvorstandPerson;
begin
  person := createWahlvorstandPerson;
  person.fromJSON(data);

  try
    MAPWDTab.Open;
    if not MAPWDTab.Locate('MA_ID', VarArrayOf([person.ID]), []) then
    begin
      MAPWDTab.Append;
      MAPWDTab.FieldByName('MA_ID').AsInteger := person.ID;
    end
    else
    begin
      MAPWDTab.Edit;
    end;
    MAPWDTab.FieldByName('MW_ROLLE').AsString := DBMod.AddRole(roWahlVorstand, MAPWDTab.FieldByName('MW_ROLLE').AsString);
    MAPWDTab.Post;

    MAPWDTab.Close;

    AddVorstandQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    AddVorstandQry.ParamByName('MA_ID').AsInteger := person.ID;
    AddVorstandQry.ExecSQL;

    SaveLog( true, 'Wahlvorstand hinzugefügt', formatJSON(data) );

    Result := save(data);
  except
    on e : exception do
    begin
      Result := TJSONObject.Create;
      JResult( result, false, e.ToString);
    end;
  end;

end;

procedure TVortandMod.addLogin(person: IWahlvorstandPerson);
begin
  person.Login := LoginQryMW_LOGIN.AsString;
end;

procedure TVortandMod.addMAData(person: IWahlvorstandPerson);
begin
  person.PersNr     := ListMAQryMA_PERSNR.AsString;
  person.ID         := ListMAQryMA_ID.AsInteger;
  person.Geschlecht := ListMAQryMA_GENDER.AsString;
  person.Name       := ListMAQryMA_NAME.AsString;
  person.Vorname    := ListMAQryMA_VORNAME.AsString;
  person.Abteilung  := ListMAQryMA_ABTEILUNG.AsString;
  person.eMail      := ListMAQryMA_MAIL.AsString;
  person.Rolle      := StringToTWahlvorstandsRolle(ListMAQryWV_ROLLE.AsString);
end;

function TVortandMod.delete(data: TJSONObject): TJSONObject;
var
  id : integer;
begin
  Result := TJSONObject.Create;
  id     := JInt( data, 'id');

  DelQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  DelQry.ParamByName('MA_ID').AsInteger := id;
  DelQry.ExecSQL;

  if DelQry.RowsAffected = 0 then
  begin
     JResult(Result, false, 'Es wurde niemand gelöscht. Oder die Person ist der Wahlvorstand, den man nicht löschen kann.');
  end
  else
  begin
    JResult(Result, true, 'Das Löschen war erfolgreich.');

    SaveLog(true, 'Wahlvorstand gelöscht', formatJSON(data));
  end;
end;

function TVortandMod.get(ma_id: integer): TJSONObject;
var
  person   : IWahlvorstandPerson;
begin
  Result := NIL;
  person := NIL;

  ListMAQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  ListMAQry.Open;
  while not ListMAQry.Eof do
  begin
    if ListMAQryMA_ID.AsInteger = ma_id then
    begin
      person := createWahlvorstandPerson;
      addMAData(person);
      break;
    end;
    ListMAQry.Next;
  end;
  ListMAQry.Close;

  if Assigned(person) then
  begin
    LoginQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    LoginQry.open;
    while not LoginQry.Eof do
    begin
      if person.ID = LoginQryMA_ID.AsInteger then
      begin
        addLogin(person);
        break;
      end;
      LoginQry.next;
    end;
    LoginQry.close;
  end;

  if Assigned(person) then
    result := person.toJSON;
end;

function TVortandMod.getlist: TJSONObject;
var
  vorstand : IWahlvorstand;
  person   : IWahlvorstandPerson;
begin
  vorstand := createWahlvorstand;

  ListMAQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  ListMAQry.Open;
  while not ListMAQry.Eof do
  begin
    person            := vorstand.new;
    addMAData(person);
    vorstand.add(person);

    ListMAQry.Next;
  end;
  ListMAQry.Close;

  LoginQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  LoginQry.open;
  while not LoginQry.Eof do
  begin
    person := vorstand.get(LoginQryMA_ID.AsInteger);
    if Assigned(person) then
    begin
      addLogin(person);
    end;
    LoginQry.next;
  end;
  LoginQry.close;

  Result := vorstand.toJSON;
end;

function TVortandMod.save(data: TJSONObject): TJSONObject;
var
  person   : IWahlvorstandPerson;
begin
  Result := TJSONObject.Create;
  person := createWahlvorstandPerson;
  person.fromJSON(data);
  // update :-)

  UpdateWVQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  UpdateWVQry.ParamByName('MA_ID').AsInteger := person.ID;
  UpdateWVQry.ParamByName('WV_ROLLE').AsString := TWahlvorstandsRolleToString(person.Rolle);
  if person.Rolle = wvVorsitz then
    UpdateWVQry.ParamByName('WV_CHEF').AsString := 'T'
  else
    UpdateWVQry.ParamByName('WV_CHEF').AsString := 'F';

  UpdateWVQry .ExecSQL;

  UpdateLoginQry.ParamByName('MA_ID').AsInteger   := person.ID;
  UpdateLoginQry.ParamByName('MW_LOGIN').AsString := person.Login;
  UpdateLoginQry.ExecSQL;

  UpdateMailQry.ParamByName('MA_ID').AsInteger   := person.ID;
  UpdateMailQry.ParamByName('MA_MAIL').AsString  := person.eMail;
  UpdateMailQry.ExecSQL;

  JResult(Result, true, 'Update ausgeführt');

  SaveLog(true, 'Wahlvorstandänderung gespeichert', formatJSON(data));
end;

end.

