unit f_briefwahl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, m_glob, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

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
    BriefTabMA_ID: TIntegerField;
    BriefTabMA_PERSNR: TStringField;
    BriefTabMA_NAME: TStringField;
    BriefTabMA_VORNAME: TStringField;
    BriefTabMA_GENDER: TStringField;
    BriefTabMA_ABTEILUNG: TStringField;
    BriefTabMA_MAIL: TStringField;
    BriefTabMA_GEB: TDateField;
    BriefTabBW_ID: TIntegerField;
    BriefTabBW_ANTRAG: TDateField;
    BriefTabBW_VERSENDET: TDateField;
    BriefTabBW_EMPFANGEN: TDateField;
    BriefTabBW_ERROR: TStringField;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure BriefTabMA_GENDERGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
  private
    procedure search( fieldname : string; key : string );
  public
    class procedure execute;
  end;

var
  BriefwahlForm: TBriefwahlForm;

implementation

{$R *.dfm}

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
