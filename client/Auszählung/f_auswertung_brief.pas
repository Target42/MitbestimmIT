unit f_auswertung_brief;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Buttons;

type
  TAuswertungBriefForm = class(TForm)
    GroupBox1: TGroupBox;
    StatusBar1: TStatusBar;
    GroupBox2: TGroupBox;
    DSProviderConnection1: TDSProviderConnection;
    DBGrid1: TDBGrid;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    BriefTab: TFDMemTable;
    ClientDataSet1BW_ID: TIntegerField;
    ClientDataSet1MA_ID: TIntegerField;
    ClientDataSet1BW_ANTRAG: TSQLTimeStampField;
    ClientDataSet1BW_VERSENDET: TSQLTimeStampField;
    ClientDataSet1BW_EMPFANGEN: TSQLTimeStampField;
    ClientDataSet1BW_ERROR: TStringField;
    ClientDataSet1MA_PERSNR: TStringField;
    ClientDataSet1MA_NAME: TStringField;
    ClientDataSet1MA_VORNAME: TStringField;
    ClientDataSet1MA_ABTEILUNG: TStringField;
    ClientDataSet1MA_GENDER: TStringField;
    ClientDataSet1MA_GEB: TDateField;
    BriefTabBW_ID: TIntegerField;
    BriefTabMA_ID: TIntegerField;
    BriefTabBW_ANTRAG: TSQLTimeStampField;
    BriefTabBW_VERSENDET: TSQLTimeStampField;
    BriefTabBW_EMPFANGEN: TSQLTimeStampField;
    BriefTabBW_ERROR: TStringField;
    BriefTabMA_PERSNR: TStringField;
    BriefTabMA_NAME: TStringField;
    BriefTabMA_VORNAME: TStringField;
    BriefTabMA_ABTEILUNG: TStringField;
    BriefTabMA_GENDER: TStringField;
    BriefTabMA_GEB: TDateField;
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    GroupBox3: TGroupBox;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Memo1: TMemo;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BriefTabMA_GENDERGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure BriefTabBW_ERRORGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BriefTabAfterScroll(DataSet: TDataSet);
  private
    procedure UpdateText;
    procedure SaveText;
  public
    class procedure execute;
  end;

var
  AuswertungBriefForm: TAuswertungBriefForm;

implementation

{$R *.dfm}

uses m_glob, u_stub, System.JSON, u_json;

procedure TAuswertungBriefForm.BriefTabAfterScroll(DataSet: TDataSet);
var
  st : string;
  c  : char;
begin
  if BriefTab.IsEmpty then
    exit;

  st := BriefTabBW_ERROR.AsString+ ' ';

  c := st[1];
  case c of
    'G' : RadioGroup2.ItemIndex := 0;
    'U' : RadioGroup2.ItemIndex := 1;
    'F' : RadioGroup2.ItemIndex := 2;
    'D' : RadioGroup2.ItemIndex := 3
    else
      RadioGroup2.ItemIndex := 2;
  end;

end;

procedure TAuswertungBriefForm.BriefTabBW_ERRORGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
var
  s : string;
  c : char;
begin
  Text := '???';
  s := Sender.AsString + ' ' ;
  c := s[1];

  case c of
    'F' : Text := '';
    'U' : Text := 'Unvollständig';
    'D' : Text := 'Doppelt';
    'I' : Text := 'Ungültig'
    else
      Text := 'Unbekannt'
  end;

end;

procedure TAuswertungBriefForm.BriefTabMA_GENDERGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  GM.MAListMA_GENDERGetText(Sender, Text, DisplayText);
end;

class procedure TAuswertungBriefForm.execute;
var
  AuswertungBriefForm : TAuswertungBriefForm;
begin
  Application.CreateForm(TAuswertungBriefForm, AuswertungBriefForm);
  AuswertungBriefForm.ShowModal;
  AuswertungBriefForm.free;
end;

procedure TAuswertungBriefForm.FormCreate(Sender: TObject);
begin
  BriefTab.Open;
  ClientDataSet1.Open;
  FDBatchMove1.Execute;
  ClientDataSet1.Close;
  BriefTab.First;
end;

procedure TAuswertungBriefForm.SaveText;
begin

end;

procedure TAuswertungBriefForm.UpdateText;
var
  client : TAuswertungsmodClient;
  data   : TJSONObject;
  req    : TJSONObject;
begin
  client := TAuswertungsmodClient.Create(GM.SQLConnection1.DBXConnection);

  req := TJSONObject.Create;
  JReplace( req, 'bw_id', BriefTabBW_ID.AsInteger);
  JReplace( req, 'ma_id', BriefTabMA_ID.AsInteger);

  data := client.getBriefText(req);

  if Assigned(data) then
  begin
    RadioGroup1.ItemIndex := JInt( data, 'grund_id');
    Memo1.Lines.Text :=   getText(data, 'text');
  end
  else
  begin
    RadioGroup1.ItemIndex := 0;
    Memo1.Lines.Text := '';
  end;

  client.Free;
end;

end.
