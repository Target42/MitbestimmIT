unit m_waehler;

interface

uses
  System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.Provider,
  System.JSON, i_waehlerliste, u_wahlerlisteVergleich, System.SysUtils,
  u_rollen;

type
  [TRoleAuth(roWahlVorstand)]
  TWaehlerMod = class(TDSServerModule)
    MitarbeiterTab: TDataSetProvider;
    MAQry: TFDQuery;
    MAQryMA_ID: TIntegerField;
    MAQryMA_PERSNR: TStringField;
    MAQryMA_NAME: TStringField;
    MAQryMA_VORNAME: TStringField;
    MAQryMA_GENDER: TStringField;
    MAQryMA_MAIL: TStringField;
    MAQryMA_GEB: TDateField;
    NewMaTab: TFDTable;
    FDTransaction1: TFDTransaction;
    DelWahlHelferQry: TFDQuery;
    DelWahlVorQry: TFDQuery;
    DelMaWaQry: TFDQuery;
    DelOldPwdQry: TFDQuery;
    DeloldMAQry: TFDQuery;
    AddMAWAQry: TFDQuery;
    DelWTQry: TFDQuery;
    MCTab: TFDTable;
    MCTabWA_ID: TIntegerField;
    MCTabMC_STAMP: TSQLTimeStampField;
    MCTabMC_ADD: TIntegerField;
    MCTabMC_CHG: TIntegerField;
    MCTabMC_DEL: TIntegerField;
    MCTabMC_DATA: TBlobField;
    MCTabMC_ID: TIntegerField;
    MAQryMA_ABTEILUNG: TStringField;
    Mitarbeiter: TFDQuery;
    procedure MitarbeiterBeforeOpen(DataSet: TDataSet);
  private
    function getOldList: IWaehlerListe;
    procedure update( list : IWaehlerListe );
    procedure add( list : IWaehlerListe );
    procedure remove(list : IWaehlerListe );

    procedure addLog( var cmp : TWaehlerlisteVergleich );

    procedure removeOldMA;

    function safeDate( s : string; var fmt : TFormatSettings) : TDateTime;
  public
    function import( data : TJSONObject ) :TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_db, DSSession, u_Waehlerliste, System.Variants,
  u_json, m_log;

{$R *.dfm}

{ TWaehlerMod }

procedure TWaehlerMod.add(list: IWaehlerListe);
var
  ma : IWaehler;
  waid : integer;
  fmt : TFormatSettings;
begin
  if list.Items.Count = 0 then
    exit;

  fmt := TFormatSettings.Create('de-DE');

  NewMaTab.Open;
  waid := DBMod.WahlID;

  AddMAWAQry.ParamByName('WA_ID').AsInteger := waid;
  for ma in list.Items do
  begin
    NewMaTab.Append;
    NewMaTab.FieldByName('MA_PERSNR').AsString    := ma.PersNr;
    NewMaTab.FieldByName('MA_NAME').AsString      := ma.Name;
    NewMaTab.FieldByName('MA_VORNAME').AsString   := ma.Vorname;
    NewMaTab.FieldByName('MA_GENDER').AsString    := ma.Geschlecht;
    NewMaTab.FieldByName('MA_ABTEILUNG').AsString := ma.Abteilung;
    NewMaTab.FieldByName('MA_GEB').AsDateTime     := safeDate(ma.GebDatum, fmt);
    NewMaTab.Post;

    AddMAWAQry.ParamByName('MA_ID').AsInteger := NewMaTab.FieldByName('MA_ID').AsInteger;
    AddMAWAQry.ExecSQL;
  end;
  NewMaTab.Close;

end;

procedure TWaehlerMod.addLog(var cmp: TWaehlerlisteVergleich);
var
  mem : TStream;
begin
  mem := TMemoryStream.Create;
  cmp.WriteChangeLog(mem);
  mem.Position := 0;

  MCTab.Open;
  MCTab.Append;

  MCTabWA_ID.AsInteger := DBMod.WahlID;
  MCTabMC_STAMP.AsDateTime := now;
  MCTabMC_ADD.AsInteger := cmp.AddList.Items.Count;
  MCTabMC_CHG.AsInteger := cmp.ChgList.Items.Count;
  MCTabMC_DEL.AsInteger := cmp.DelList.Items.Count;
  MCTabMC_DATA.LoadFromStream(mem);
  MCTab.Post;
  MCTab.Close;
  mem.Free;
end;

function TWaehlerMod.getOldList: IWaehlerListe;
var
  ma : IWaehler;
begin
  Result := TWaehlerListe.create;

  MAQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  MAQry.Open;
  while not MAQry.Eof do
  begin
    ma := Result.new;
    ma.ID     := MAQryMA_ID.AsInteger;
    ma.PersNr := MAQryMA_PERSNR.AsString;
    ma.Name   := MAQryMA_NAME.AsString;
    ma.Vorname:= MAQryMA_VORNAME.AsString;
    ma.Geschlecht := MAQryMA_GENDER.AsString;
    ma.Abteilung := MAQryMA_ABTEILUNG.AsString;
    ma.GebDatum  := FormatDateTime('dd.MM.yyyy', MAQryMA_GEB.AsDateTime );

    Result.add(ma);

    MAQry.Next;
  end;
  MAQry.Close;
end;

function TWaehlerMod.import(data: TJSONObject): TJSONObject;
var
  cmp : TWaehlerlisteVergleich;
  old : IWaehlerListe;
  new : IWaehlerListe;
begin
  Result := TJSONObject.Create;

  FDTransaction1.StartTransaction;
  try
    cmp := TWaehlerlisteVergleich.create;

    new := TWaehlerListe.create;
    new.fromJSON(data);
    old := getOldList;

    cmp.execute(new, old);

    update(cmp.ChgList);
    add(cmp.AddList);
    remove(cmp.DelList);

    JReplace( Result, 'add', cmp.AddList.Items.Count);
    JReplace( Result, 'del', cmp.DelList.Items.Count);
    JReplace(Result, 'chg', cmp.ChgList.Items.Count);

    addLog(cmp);
    removeOldMA;

    SaveLog(true, 'Import Wählerliste', Format('add:%d, del:%d, chg:%d',
    [
      cmp.AddList.Items.Count,
      cmp.DelList.Items.Count,
      cmp.ChgList .Items.Count
    ]));

    cmp.Free;
    FDTransaction1.Commit;
    JResult( result, true, '');


  except
    on e : exception do
    begin
      JResult(Result, false, e.ToString);
    end;
  end;

end;

procedure TWaehlerMod.MitarbeiterBeforeOpen(DataSet: TDataSet);
begin
  Mitarbeiter.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

procedure TWaehlerMod.remove(list: IWaehlerListe);
var
  ma : IWaehler;
  wa_id : integer;
begin
  if list.Items.Count = 0 then
    exit;

  wa_id := DBMod.WahlID;
  DelWahlVorQry.ParamByName('WA_ID').AsInteger    := wa_id;
  DelWahlHelferQry.ParamByName('WA_ID').AsInteger := wa_id;
  DelMaWaQry.ParamByName('WA_ID').AsInteger       := wa_id;
  DelWTQry.ParamByName('WA_ID').AsInteger         := wa_id;

  for ma in list.Items do
  begin
    DelWahlHelferQry.ParamByName('MA_ID').AsInteger := ma.ID;
    DelWahlHelferQry.ExecSQL;

    DelWahlVorQry.ParamByName('MA_ID').AsInteger := ma.ID;
    DelWahlVorQry.ExecSQL;

    DelMaWaQry.ParamByName('MA_ID').AsInteger := ma.ID;
    DelMaWaQry.ExecSQL;

    DelWTQry.ParamByName('MA_ID').AsInteger := ma.ID;
    DelWTQry.ExecSQL;
  end;

end;

procedure TWaehlerMod.removeOldMA;
begin
  DelOldPwdQry.ExecSQL;
  DeloldMAQry.ExecSQL;
end;

function TWaehlerMod.safeDate(s: string; var fmt: TFormatSettings): TDateTime;
begin
  Result := 0.0;

  TryStrToDate( s, result, fmt);
end;

procedure TWaehlerMod.update(list: IWaehlerListe);
var
  ma : IWaehler;
  id : integer;
  fmt : TFormatSettings;
begin
  if list.Items.Count = 0 then
    exit;

  fmt := TFormatSettings.Create('de-DE');

  NewMaTab.Open;

  for ma in list.Items do
  begin
    id := ma.ID;
    if NewMaTab.Locate('MA_ID', VarArrayOf([id]), []) then
    begin
      NewMaTab.Edit;
      NewMaTab.FieldByName('MA_PERSNR').AsString    := ma.PersNr;
      NewMaTab.FieldByName('MA_NAME').AsString      := ma.Name;
      NewMaTab.FieldByName('MA_VORNAME').AsString   := ma.Vorname;
      NewMaTab.FieldByName('MA_GENDER').AsString    := ma.Geschlecht;
      NewMaTab.FieldByName('MA_ABTEILUNG').AsString := ma.Abteilung;
      NewMaTab.FieldByName('MA_GEB').AsDateTime     := safeDate(ma.GebDatum, fmt);
      NewMaTab.Post;
    end;
  end;
  NewMaTab.Close;
end;

end.

