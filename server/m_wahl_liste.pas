unit m_wahl_liste;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, m_db,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, u_rollen, System.JSON;

type
  [TRoleAuth(roWahlVorstand)]
  TWahlListeMod = class(TDSServerModule)
    WahlListe: TFDQuery;
    WahllisteQry: TDataSetProvider;
    WahllisteMA: TFDQuery;
    WahllisteMAQry: TDataSetProvider;
    WahlPersTab: TFDTable;
    DelMAWTQry: TFDQuery;
    DelWTQry: TFDQuery;
    DelMaQry: TFDQuery;
    WahlListeTab: TFDTable;
    procedure WahlListeBeforeOpen(DataSet: TDataSet);
    procedure WahllisteMABeforeOpen(DataSet: TDataSet);
  private
    { Private-Deklarationen }
  public
    // Wahllisten

    function add( data : TJSONObject ) : TJSONObject;
    function save( data : TJSONObject ) : TJSONObject;
    function delete( data : TJSONObject ) : TJSONObject;

    function addMA( data : TJSONObject ) : TJSONObject;
    function saveMA( data : TJSONObject ) : TJSONObject;
    function deleteMA( data : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  u_wahlliste, u_json, System.Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}


{$R *.dfm}

function TWahlListeMod.add(data: TJSONObject): TJSONObject;
var
  wl : TWahlliste;
  p  : TWahllistePerson;
  wtid : integer;
  waid : integer;
begin
  Result := TJSONObject.Create;
  wl := TWahlliste.create;
  wl.fromJson(data);

  if wl.ID <= 0 then
  begin
    waid := DBMod.WahlID;

    WahlListeTab.Open;
    WahlPersTab.Open;

    WahlListeTab.Append;
    WahlListeTab.FieldByName('WT_NAME').AsString := wl.Name;
    WahlListeTab.FieldByName('WT_KURZ').AsString := wl.Kurz;
    WahlListeTab.FieldByName('WA_ID').AsInteger  := waid;
    WahlListeTab.Post;
    wtid := WahlListeTab.FieldByName('WT_ID').AsInteger;

    for p in wl.Personen do
    begin
      WahlPersTab.Append;
      WahlPersTab.FieldByName('WA_ID').AsInteger := waid;
      WahlPersTab.FieldByName('WT_Id').AsInteger := wtid;
      WahlPersTab.FieldByName('MA_ID').AsInteger := p.ID;
      WahlPersTab.FieldByName('WT_MA_POS').AsInteger := p.Nr;
      WahlPersTab.Post;
    end;

    WahlPersTab.Close;
    WahlListeTab.Close;

    JResult( result, true, 'Die Wahlliste wurde hinzugefügt.')
  end
  else
    JResult( result, false, 'Die Liste konnte nicht angelegt werden.');

  wl.Free;
end;

function TWahlListeMod.addMA(data: TJSONObject): TJSONObject;
var
  wl : TWahlliste;
  p  : TWahllistePerson;
  id : integer;
begin
  Result := TJSONObject.Create;

  id := DBMod.WahlID;
  wl := TWahlliste.create;
  wl.fromJson(data);

  if (wl.Personen.Count > 0 ) and ( wl.ID > 0) then
  begin
    WahlPersTab.Open;
    for p in wl.Personen do
    begin
      if not WahlPersTab.Locate('WA_ID;WT_ID;MA_ID', VarArrayOf([id, wl.ID, p.ID]), []) then
      begin
        WahlPersTab.Append;
        WahlPersTab.FieldByName('WA_ID').AsInteger     := id;
        WahlPersTab.FieldByName('WT_Id').AsInteger     := wl.ID;
        WahlPersTab.FieldByName('MA_ID').AsInteger     := p.ID;
        WahlPersTab.FieldByName('WT_WA_POS').AsInteger := p.Nr;
        WahlPersTab.Post;
      end;
    end;
    WahlPersTab.Close;
  end
  else
    JResult( result, false, 'Es wurd niemand hinzugefügt');

  wl.Free;
end;

function TWahlListeMod.delete(data: TJSONObject): TJSONObject;
var
  wl : TWahlliste;
begin
  Result := TJSONObject.Create;
  wl := TWahlliste.create;
  wl.fromJson(data);

  try
    DelMAWTQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    DelMAWTQry.ParamByName('WT_ID').AsInteger := wl.ID;
    DelMAWTQry.ExecSQL;

    DelWTQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
    DelWTQry.ParamByName('WT_ID').AsInteger := wl.ID;
    DelWTQry.ExecSQL;

    JResult( result, true, 'Die Wahlliste wurde gelöscht')
  except
    on e: exception do
    begin
      JResult( result, false, e.ToString);
    end;
  end;


  wl.Free;
end;

function TWahlListeMod.deleteMA(data: TJSONObject): TJSONObject;
var
  wl : TWahlliste;
  p  : TWahllistePerson;
begin
  Result := TJSONObject.Create;

  wl := TWahlliste.create;
  wl.fromJson(data);

  if ( wl.ID > 0 ) and ( wl.Personen.Count > 0 ) then
  begin
    DelMaQry.ParamByName('wa_id').AsInteger := DBMod.WahlID;
    DelMaQry.ParamByName('wt_id').AsInteger := wl.ID;
    for p in wl.Personen do
    begin
      DelMaQry.ParamByName('MA_ID').AsInteger := p.id;
      DelMaQry.ExecSQL;
    end;
  end;

  wl.Free;
end;

function TWahlListeMod.save(data: TJSONObject): TJSONObject;
var
  wl : TWahlliste;
begin
  Result := TJSONObject.Create;

  wl := TWahlliste.create;
  wl.fromJson(data);

  WahlListeTab.Open;
  if WahlListeTab.Locate('WA_ID;WT_ID', VarArrayOf([DBMod.WahlID, wl.id]), []) then
  begin
    WahlListeTab.Edit;
    WahlListeTab.FieldByName('WT_NAME').AsString := wl.Name;
    WahlListeTab.FieldByName('WT_KURZ').AsString := wl.Kurz;
    WahlListeTab.Post;
    JResult( result, true, 'Die Liste wurde geändert');
  end
  else
    JResult( result, false, 'Die Liste wurde nicht gefunden');
  WahlListeTab.Close;

  wl.Free;
end;

function TWahlListeMod.saveMA(data: TJSONObject): TJSONObject;
var
  wl : TWahlliste;
  p  : TWahllistePerson;
  waid : integer;
begin
  Result := TJSONObject.Create;
  wl := TWahlliste.create;
  wl.fromJson(data);

  waid := DBMod.WahlID;
  if ( wl.Personen.Count > 0 ) then
  begin
    DelMAWTQry.ParamByName('WT_ID').AsInteger := wl.ID;
    DelMAWTQry.ParamByName('WA_ID').AsInteger := waid;
    DelMAWTQry.ExecSQL;

    WahlPersTab.Open;
    for p in wl.Personen do
    begin
      if WahlPersTab.Locate('WA_ID;WT_ID;MA_ID', VarArrayOf([waid, wl.ID, p.ID]), []) then
      begin
        WahlPersTab.edit;
      end
      else
      begin
        WahlPersTab.Append;
        WahlPersTab.FieldByName('WA_ID').AsInteger := waid;
        WahlPersTab.FieldByName('MA_ID').AsInteger := p.ID;
        WahlPersTab.FieldByName('WT_ID').AsInteger := wl.ID;
      end;

      WahlPersTab.FieldByName('WT_WA_JOB').AsString  := p.Job;
      WahlPersTab.FieldByName('WT_WA_POS').AsInteger := p.Nr;
      WahlPersTab.Post;
    end;
    WahlPersTab.Close;
  end;
  wl.Free;

  JResult( result, true, 'Mitglieder gespeichert!');
end;

procedure TWahlListeMod.WahlListeBeforeOpen(DataSet: TDataSet);
begin
  WahlListe.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

procedure TWahlListeMod.WahllisteMABeforeOpen(DataSet: TDataSet);
begin
  WahllisteMA.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

end.


