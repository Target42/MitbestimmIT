unit f_briefwahl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, m_glob, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList;

type
  TBriefwahlForm = class(TForm)
    StatusBar1: TStatusBar;
    DSProviderConnection1: TDSProviderConnection;
    MaTable: TClientDataSet;
    BriefTab: TFDMemTable;
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ActionList1: TActionList;
    ac_request: TAction;
    ac_send: TAction;
    ac_received: TAction;
    BriefTabMA_ID: TIntegerField;
    BriefTabMA_PERSNR: TStringField;
    BriefTabMA_NAME: TStringField;
    BriefTabMA_VORNAME: TStringField;
    BriefTabMA_GENDER: TStringField;
    BriefTabMA_ABTEILUNG: TStringField;
    BriefTabMA_MAIL: TStringField;
    BriefTabMA_GEB: TDateField;
    BriefTabBW_ID: TIntegerField;
    BriefTabBW_ANTRAG: TSQLTimeStampField;
    BriefTabBW_VERSENDET: TSQLTimeStampField;
    BriefTabBW_EMPFANGEN: TSQLTimeStampField;
    BriefTabBW_ERROR: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure BriefTabMA_GENDERGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure ac_requestExecute(Sender: TObject);
    procedure ac_sendExecute(Sender: TObject);
    procedure ac_receivedExecute(Sender: TObject);
    procedure BriefTabBW_ANTRAGGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    procedure search( fieldname : string; key : string );
  public
    class procedure execute;
  end;

var
  BriefwahlForm: TBriefwahlForm;

implementation

{$R *.dfm}

uses m_res, u_briefwahl, System.JSON, u_stub, u_json, u_helper;

procedure TBriefwahlForm.ac_receivedExecute(Sender: TObject);
var
  brief : TBriefwahl;
  res   : TJSONObject;
  client : TBriefWahlModClient;
begin
  if BriefTab.IsEmpty then
    exit;

  if not BriefTab.FieldByName('BW_EMPFANGEN').IsNull then
  begin
    ShowMessage('Die Briefwahl wurden schon empfangen!');
    exit;
  end;

  brief := TBriefwahl.create;
  brief.Date  := now;
  brief.MA_ID := BriefTabMA_ID.AsInteger;
  brief.Event := etEmpfangen;

  client := TBriefWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  res := Client.setEvent(brief.toJson);
  if ShowResult(res) then
  begin
    BriefTab.Edit;
    BriefTabBW_EMPFANGEN.AsDateTime := JDouble( res, 'date', now);
    BriefTab.Post;
  end;
  client.Free;

  brief.Free;
end;

procedure TBriefwahlForm.ac_requestExecute(Sender: TObject);
var
  brief : TBriefwahl;
  res   : TJSONObject;
  client : TBriefWahlModClient;
begin
  if BriefTab.IsEmpty then
    exit;

  if not BriefTabBW_ANTRAG.IsNull then
  begin
    ShowMessage('Die Briefwahl wurde schon beantragt!');
    exit;
  end;

  brief := TBriefwahl.create;
  brief.Date  := now;
  brief.MA_ID := BriefTabMA_ID.AsInteger;
  brief.Event := etAntrag;

  client := TBriefWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  res := Client.setEvent(brief.toJson);
  if ShowResult(res) then
  begin
    BriefTab.Edit;
    BriefTabBW_ANTRAG.AsDateTime := JDouble( res, 'date', now);
    BriefTab.Post;
  end;
  client.Free;

  brief.Free;
end;

procedure TBriefwahlForm.ac_sendExecute(Sender: TObject);
var
  brief : TBriefwahl;
  res   : TJSONObject;
  client : TBriefWahlModClient;
begin
  if BriefTab.IsEmpty then
    exit;

  if not BriefTab.FieldByName('BW_VERSENDET').IsNull then
  begin
    ShowMessage('Die Briefwahlunterlagen wurde schon versendet');
    exit;
  end;

  brief := TBriefwahl.create;
  brief.Date  := now;
  brief.MA_ID := BriefTabMA_ID.AsInteger;
  brief.Event := etVErsendet;

  client := TBriefWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  res := Client.setEvent(brief.toJson);
  if ShowResult(res) then
  begin
    BriefTab.Edit;
    BriefTabBW_VERSENDET.AsDateTime := JDouble( res, 'date', now);
    BriefTab.Post;
  end;
  client.Free;

  brief.Free;
end;

procedure TBriefwahlForm.BriefTabBW_ANTRAGGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
    Text := FormatDateTime('dd.MM.yyyy hh:mm', Sender.AsDateTime);
end;

procedure TBriefwahlForm.BriefTabMA_GENDERGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString = 'w' then
    text := 'weiblich'
  else
    text := 'männlich';
end;

class procedure TBriefwahlForm.execute;
begin
  Application.CreateForm(TBriefwahlForm, BriefwahlForm);
  BriefwahlForm.ShowModal;
  BriefwahlForm.Free;
end;

procedure TBriefwahlForm.FormCreate(Sender: TObject);
begin
  FDBatchMove1.Options := [poClearDest, poCreateDest, poIdentityInsert];
  FDBatchMove1.Execute;
  BriefTab.First;
end;

procedure TBriefwahlForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    search('MA_PERSNR', trim(LabeledEdit1.Text));
  end;

end;

procedure TBriefwahlForm.LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    search('MA_NAME', trim(LabeledEdit2.Text));
  end;

end;

procedure TBriefwahlForm.search(fieldname, key: string);
begin
  BriefTab.First;

  BriefTab.Locate(fieldname, key, [loCaseInsensitive, loPartialKey]);
end;

end.
