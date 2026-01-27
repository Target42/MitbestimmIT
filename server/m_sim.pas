unit m_sim;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, System.Generics.Collections;

type
  TDSSim = class(TDSServerModule)
    DataQry: TFDQuery;
    FDTransaction1: TFDTransaction;
    DataTab: TFDTable;
    SelAllQry: TFDQuery;
    BWTab: TFDTable;
    FillLokalQry: TFDQuery;
    MAWLTab: TFDTable;
    DisableQry: TFDQuery;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    m_all     : TList<integer>;
    m_brief   : TList<Integer>;
    m_doppelt : TList<Integer>;
    m_summe   : TList<Integer>;

    m_lokale  : TList<Integer>;

    procedure createLists;
    procedure DestroyLists;
    procedure SelectWaehler( Summe, Brief, Doppelt : integer);
    procedure fillAll;
    procedure createBrief( Brief, Doppelt : integer );

    procedure fillBW;
    procedure fillSumme;
    procedure fillLokal;
  public
    function getBasisData : TJSONObject;
    function setSimData( data : TJSONObject ) : TJSONObject;
    function Auswertung( data : TJSONObject ) : TJSONObject;
  end;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

uses m_db, u_json, u_simdata, System.DateUtils;

{$R *.dfm}

{ TDSSim }

function TDSSim.Auswertung(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

procedure TDSSim.createBrief(Brief, Doppelt: integer);
var
  i : integer;
  inx : integer;
  tmp : TList<Integer>;
begin

// Briefwähler aus der Liste der aller Wähler entnehmen
  for i := 0 to pred( Brief ) do
  begin
    inx := Random(m_all.Count);
    m_brief.Add(m_all[inx]);
    m_all.Delete(inx);
  end;


  // briefwähler in die doppelt liste intragen und in die liste der wähler
  tmp := TList<Integer>.Create(m_brief);
  while m_doppelt.Count < Doppelt do
  begin
    inx := Random(tmp.Count);

    m_doppelt.Add(tmp[inx]);
    m_summe.Add(tmp[inx]);
    tmp.Delete(inx);
  end;
  tmp.Free;
end;

procedure TDSSim.createLists;
begin
  m_all     := TList<integer>.Create;
  m_brief   := TList<Integer>.Create;
  m_doppelt := TList<Integer>.Create;
  m_summe   := TList<Integer>.Create;
  m_lokale  := TList<Integer>.Create;

end;

procedure TDSSim.DestroyLists;
begin
  m_all.Free;
  m_brief.Free;
  m_doppelt.Free;
  m_summe.Free;
  m_lokale.Free;
end;

procedure TDSSim.DSServerModuleCreate(Sender: TObject);
begin
  Randomize;
end;

procedure TDSSim.fillAll;
begin
  SelAllQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  SelAllQry.Open;

  while not SelAllQry.Eof do
  begin
    m_all.Add(SelAllQry.FieldByName('MA_ID').AsInteger);
    SelAllQry.Next;
  end;
  SelAllQry.Close;
end;

procedure TDSSim.fillBW;
var
  wa_id : integer;
  ma_id : integer;
begin
  wa_id := DBMod.WahlID;
  BWTab.Open;

  for ma_id in m_brief do
  begin
    BWTab.Append;
    BWTab.FieldByName('WA_ID').AsInteger          := wa_id;
    BWTab.FieldByName('MA_ID').AsInteger          := ma_id;
    BWTab.FieldByName('BW_ANTRAG').AsDateTime     := IncDay(now, - 4);
    BWTab.FieldByName('BW_VERSENDET').AsDateTime  := IncDay(now, - 2);
    BWTab.FieldByName('BW_EMPFANGEN').AsDateTime  := now;
    if m_doppelt.IndexOf(ma_id) > -1 then
      BWTab.FieldByName('BW_ERROR').AsString := 'D'
    else
      BWTab.FieldByName('BW_ERROR').AsString := 'F';
    BWTab.Post;
  end;
  BWTab.Close;

end;

procedure TDSSim.fillLokal;
begin
  FillLokalQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  FillLokalQry.Open;
  while not FillLokalQry.Eof do
  begin
    m_lokale.Add(FillLokalQry.FieldByName('WL_ID').AsInteger);
    FillLokalQry.Next;
  end;
  FillLokalQry.Close;
end;

procedure TDSSim.fillSumme;
var
  ma_id : integer;
  wa_id : integer;
  inx   : integer;
begin
  wa_id := DBMod.WahlID;
  inx := 0;
  MAWLTab.Open;
  for ma_id in m_summe do
  begin
    MAWLTab.Append;
    MAWLTab.FieldByName('WA_ID').AsInteger := wa_id;
    MAWLTab.FieldByName('WL_ID').AsInteger := m_lokale[inx];
    MAWLTab.FieldByName('MA_ID').AsInteger := ma_id;
    MAWLTab.FieldByName('WL_TIMESTAMP').AsDateTime := now;
    MAWLTab.Post;

    inc(inx);
    if inx >= m_lokale.Count then
      inx := 0;
  end;
  MAWLTab.Close;
end;

function TDSSim.getBasisData: TJSONObject;
var
  simdata : TSimData;
begin
  DataQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  DataQry.Open;

  simdata := TSimData.create;
  simdata.IsEmpty := DataQry.IsEmpty;
  if not DataQry.IsEmpty then
  begin
    simdata.BriefWaehler    := DataQry.FieldByName('WD_BRIEF').AsInteger;
    simdata.Waehler         := DataQry.FieldByName('WD_WAEHLER').AsInteger;
    simdata.Doppelt         := DataQry.FieldByName('WD_DOPPELT').AsInteger;
    simdata.Summe           := DataQry.FieldByName('WD_SUMME').AsInteger;
    simdata.Korrektur       := DataQry.FieldByName('WD_KORREKTUR').AsInteger;
    simdata.Wahlzettel      := DataQry.FieldByName('WD_ZETTEL').AsInteger;
    simdata.Invalid_Urne    := DataQry.FieldByName('WD_INVALID_URNE').AsInteger;
    simdata.Invalid_Brief   := DataQry.FieldByName('WD_INVALID_BRIEF').AsInteger;
    simdata.Rem             := DataQry.FieldByName('WD_REM').AsString;
    simdata.Wahlzettel      := DataQry.FieldByName('WD_ZETTEL').AsInteger;
  end;
  DataQry.Close;

  Result := simdata.toJson;

  simdata.Free;
end;

procedure TDSSim.SelectWaehler(Summe, Brief, Doppelt: integer);

  procedure fillRest;
  var
    rest : integer;
    inx  : integer;
  begin
    rest := Summe - Brief;
    while m_summe.Count < rest do
    begin
      inx := Random(m_all.Count);
      m_summe.Add(m_all[inx]);
      m_all.Delete(inx);
    end;
  end;

begin
  fillAll;
  createBrief( Brief, Doppelt );
  fillRest;

  fillBW;
  fillSumme;
end;

function TDSSim.setSimData(data: TJSONObject): TJSONObject;
var
  simdata : TSimData;
begin
  Result := TJSONObject.Create;

  simdata := TSimData.create;
  simdata.fromJson(data);

  createLists;
  fillLokal;

  if m_lokale.Count > 0 then
  begin
    DataTab.Open;
    if not DataTab.Locate('WA_ID', DBMod.WahlID, []) then
    begin
      DataTab.Append;
      DataTab.FieldByName('WA_ID').AsInteger := DBMod.WahlID;

      DataTab.FieldByName('WD_BRIEF').AsInteger         := simdata.BriefWaehler;
      DataTab.FieldByName('WD_SUMME').AsInteger         := simdata.Summe;
      DataTab.FieldByName('WD_DOPPELT').AsInteger       := simdata.Doppelt;

      DataTab.FieldByName('WD_WAEHLER').AsInteger       := simdata.Waehler;
      DataTab.FieldByName('WD_KORREKTUR').AsInteger     := simdata.Korrektur;
      DataTab.FieldByName('WD_ZETTEL').AsInteger        := simdata.Wahlzettel;
      DataTab.FieldByName('WD_INVALID_URNE').AsInteger  := simdata.Invalid_Urne;
      DataTab.FieldByName('WD_INVALID_BRIEF').AsInteger := simdata.Invalid_Brief;
      DataTab.FieldByName('WD_REM').AsString            := simdata.Rem;
      DataTab.FieldByName('WD_ZETTEL').AsInteger        := simdata.Summe;

      DataTab.Post;

      DisableQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
      DisableQry.ExecSQL;

      SelectWaehler( simdata.Summe, simdata.BriefWaehler, simdata.Doppelt);

      JResult( Result, true, 'Die Simulationsdaten wurden erfolgreich gespeichert.');
    end
    else
      JResult( Result, false, 'simulationsdaten wurden schon angelegt!');
  end
  else
    JResult( Result, false, 'Es gibzt noch keine Wahllokale!');

  DestroyLists;
  simdata.Free;
end;

end.

