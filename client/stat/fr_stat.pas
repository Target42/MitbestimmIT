unit fr_stat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus,
  Vcl.StdCtrls, VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs,
  VCLTee.Chart, Vcl.ComCtrls, System.JSON;

type
  TStatFrame = class(TFrame)
    GroupBox1: TGroupBox;
    Chart1: TChart;
    Series1: THorizBarSeries;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Gremium: TLabel;
    Label2: TLabel;
    Freistellungen: TLabel;
    Label3: TLabel;
    Minderheit: TLabel;
    Label4: TLabel;
    MinderheitnSitze: TLabel;
    GroupBox3: TGroupBox;
    Wahllisten: TListView;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    GroupBox4: TGroupBox;
    Wahllokale: TListView;
    Splitter4: TSplitter;
    GroupBox5: TGroupBox;
    Wahlphasen: TListView;
    Briefwahl: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    BriefLab: TLabel;
    SendLab: TLabel;
    ErhaltenLab: TLabel;
    Stimzettel: TLabel;
  private
    procedure updateMAData( data : TJSONObject );
    procedure updateBriefWahl( data : TJSONObject );
    procedure UpdateWahllisten( arr : TJSONArray);
    procedure UpdateWahllokale( arr : TJSONArray);
    procedure UpdateWahlphasen( arr : TJSONArray);
  public
    procedure UpdateData;
  end;

implementation

{$R *.dfm}

uses u_stub, u_json, m_glob;

{ TStatFrame }

procedure TStatFrame.updateBriefWahl(data: TJSONObject);
begin
  BriefLab.Caption   := IntToStr(  JInt( data, 'antrag'));
  SendLab.Caption     := IntToStr( JInt( data, 'versendet'));
  ErhaltenLab.Caption := IntToStr( JInt( data, 'empfangen'));
end;

procedure TStatFrame.UpdateData;
var
  client : TStadModClient;
  data   : TJSONObject;
begin
  client := TStadModClient.Create(GM.SQLConnection1.DBXConnection);
  data   := client.getStats;

  if Assigned(data) then
  begin
    updateMAData(JObject(data, 'ma'));
    updateBriefWahl(JObject(data, 'brief'));

    UpdateWahllisten(JArray( data, 'listen'));
    UpdateWahllokale(JArray( data, 'lokale'));
    UpdateWahlphasen(JArray( data, 'wahl'));
  end;


  client.Free;
end;

procedure TStatFrame.updateMAData(data: TJSONObject);
begin
  if not Assigned(data) then
    exit;
  Series1.XValues.Value[0] := JInt( data, 'w');
  Series1.XValues.Value[1] := JInt( data, 'm');
  Series1.XValues.Value[2] := JInt( data, 'summe');

  Series1.Repaint;

  Gremium.Caption := IntToStr(JInt( data, 'gremium' ));
  Freistellungen.Caption := IntToStr(JInt( data, 'freistellungen' ));
  MinderheitnSitze.Caption := IntToStr(JInt( data, 'minmin' ));
  Minderheit.Caption := JString( data, 'minderheit');
  Stimzettel.Caption := IntToStr( JInt( data, 'stimmen'));
end;

procedure TStatFrame.UpdateWahllisten(arr: TJSONArray);
var
  row : TJSONObject;
  i   :integer;
  item : TListItem;
begin
  if not Assigned(arr) then
    exit;

  Wahllisten.Items.Clear;
  for I := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    item := Wahllisten.Items.Add;

    item.Caption := JString( row, 'kurz');
    item.SubItems.Add(JString( row, 'name'));
    item.SubItems.Add(JString( row, 'count'));
  end;
end;

procedure TStatFrame.UpdateWahllokale(arr: TJSONArray);
var
  row : TJSONObject;
  i   :integer;
  item : TListItem;
begin
  if not Assigned(arr) then
    exit;

  Wahllokale.Items.Clear;
  for I := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    item := Wahllokale.Items.Add;

    item.Caption := JString( row, 'bau');
    item.SubItems.Add(JString( row, 'stockwerk'));
    item.SubItems.Add(JString( row, 'raum'));
    item.SubItems.Add(JString( row, 'count'));
  end;
end;


procedure TStatFrame.UpdateWahlphasen(arr: TJSONArray);
var
  row : TJSONObject;
  i   :integer;
  item : TListItem;
  typ : integer;
//   TDatumTyp      = (dtKeines = 0, dtTag = 1, dtZeitraum = 2, dtZeitpunkte = 3);
begin
  if not Assigned(arr) then
    exit;

  Wahlphasen.Items.Clear;
  for I := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    item := Wahlphasen.Items.Add;

    typ := JInt( row, 'typ');
    item.Caption := JString( row, 'titel');

    case typ of
      1 :
      begin
        item.SubItems.Add(FormatDateTime('dd.MM.yyyy', JDouble(row, 'start')));
        item.SubItems.Add('');
      end;
      2 : begin
        item.SubItems.Add(FormatDateTime('dd.MM.yyyy', JDouble(row, 'start')));
        item.SubItems.Add(FormatDateTime('dd.MM.yyyy', JDouble(row, 'ende')));
      end;
      3 : begin
        item.SubItems.Add(FormatDateTime('dd.MM.yy hh:mm', JDouble(row, 'start')));
        item.SubItems.Add(FormatDateTime('dd.MM.yy hh:mm', JDouble(row, 'ende')));
      end;
    else
      item.SubItems.Add('');
      item.SubItems.Add('');
    end;
  end;
end;

end.
