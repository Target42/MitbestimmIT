unit m_brief;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, m_db,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON;

type
  TBriefWahlMod = class(TDSServerModule)
    MaList: TFDQuery;
    MaListQry: TDataSetProvider;
    MaBw: TFDQuery;
    MaBwQry: TDataSetProvider;
    BWTab: TFDTable;
    procedure MaListBeforeOpen(DataSet: TDataSet);
    procedure MaBwBeforeOpen(DataSet: TDataSet);
  private
    function add( maid : integer; var text : string ) :Boolean;
    function send( maid : integer; var text : string ) :Boolean;
    function recive( maid : integer; var text : string ) :Boolean;
  public
    function setEvent( data : TJSONObject ) : TJSONObject;
    function setInvalid( data : TJSONObject ) : TJSONObject;
    function removeInvalid( data : TJSONObject ) : TJSONObject;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  u_briefwahl, u_json, System.Variants;

{$R *.dfm}

function TBriefWahlMod.add(maid: integer; var text: string): Boolean;
begin
  Result := false;
  if not BWTab.Locate('WA_ID;MA_ID', VarArrayOf([DBMod.WahlID, maid]), []) then
  begin
    BWTab.Append;
    BWTab.FieldByName('WA_ID').AsInteger := DBMod.WahlID;
    BWTab.FieldByName('MA_ID').AsInteger := maid;
    BWTab.FieldByName('BW_ANTRAG').AsDateTime := now;
    BWTab.Post;
    Text := 'Der Antrag ist gespeichert.';
    Result := true;
  end
  else
  if BWTab.FieldByName('BW_ANTRAG').IsNull then
  begin
    BWTab.edit;
    BWTab.FieldByName('BW_ANTRAG').AsDateTime := now;
    BWTab.Post;
    Text := 'Der Antrag ist gespeichert.';
    result := true;
  end
  else
    text := 'Die Briewahl wurde schon beantragt!';

end;

procedure TBriefWahlMod.MaBwBeforeOpen(DataSet: TDataSet);
begin
  MaBw.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

procedure TBriefWahlMod.MaListBeforeOpen(DataSet: TDataSet);
begin
  MaList.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
end;

function TBriefWahlMod.recive(maid: integer; var text: string): Boolean;
begin
  Result := false;
  if BWTab.Locate('WA_ID;MA_ID', VarArrayOf([DBMod.WahlID, maid]), []) then
  begin
    if BWTab.FieldByName('BW_EMPFANGEN').IsNull then
    begin
      BWTab.edit;
      BWTab.FieldByName('BW_EMPFANGEN').AsDateTime := now;
      BWTab.Post;
      Text := 'Die Unterlagen wurden empfangen';
      result := true;
    end
    else
      Text := 'Die Unterlagen wurden schon empfangen';

  end
  else
    text := 'Es wurde noch keine Briefwahl beantragt!';
end;

function TBriefWahlMod.removeInvalid(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TBriefWahlMod.send(maid: integer; var text: string): Boolean;
begin
  Result := false;
  if BWTab.Locate('WA_ID;MA_ID', VarArrayOf([DBMod.WahlID, maid]), []) then
  begin
    if BWTab.FieldByName('BW_VERSENDET').IsNull then
    begin
      BWTab.edit;
      BWTab.FieldByName('BW_VERSENDET').AsDateTime := now;
      BWTab.Post;
      Text := 'Der Antrag ist gespeichert.';
      result := true;
    end
    else
      Text := 'Der Antrag wurde schon versendet.';

  end
  else
    text := 'Es wurde noch keine Briefwahl beantragt!';
end;

function TBriefWahlMod.setEvent(data: TJSONObject): TJSONObject;
var
  maid : integer;
  b    : TBriefwahl;
  ok   : boolean;
  text : string;
begin
  Result := TJSONObject.Create;
  b := TBriefwahl.create;
  b.fromJson(data);
  maid := b.MA_ID;

  ok := false;
  BWTab.Open;
  case b.Event of
    etAntrag:
    begin
      ok := add(maid, text);
    end;
    etVErsendet:
    begin
      ok := send(maid, text);
    end;
    etEmpfangen:
    begin
      ok := recive(maid, text);
    end;
  end;
  b.Free;
  BWTab.Close;
  JReplaceDouble( result, 'date', now);
  JResult( result, ok, text);
end;

function TBriefWahlMod.setInvalid(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

end.

