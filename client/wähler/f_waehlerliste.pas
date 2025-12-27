unit f_waehlerliste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_base, u_Waehlerliste,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, i_waehlerliste, Vcl.Mask,
  Vcl.ExtCtrls;

type
  TWaehlerListeForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
  private
    type
      searchType = (stPersNr, stName);

    function getWaehler : IWaehler;
    procedure find( text : string; typ : searchType);
  public
    class function executeForm : IWaehler;

    property Waehler : IWaehler read getWaehler;
  end;

var
  WaehlerListeForm: TWaehlerListeForm;

implementation

{$R *.dfm}

uses
  m_glob, System.JSON, System.Masks, system.IOUtils;

procedure TWaehlerListeForm.DBGrid1DblClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Click;
end;

class function TWaehlerListeForm.executeform: IWaehler;
begin
  Result := NIL;
  Application.CreateForm(TWaehlerListeForm, WaehlerListeForm);
  if WaehlerListeForm.ShowModal = mrOk then
  begin
    Result := WaehlerListeForm.Waehler;
  end;
  WaehlerListeForm.Free;
end;

procedure TWaehlerListeForm.find(text: string; typ: searchType);
var
  field : string;
  row : integer;
  mask  : TMask;
begin
  case typ of
    stPersNr: Field := 'MA_PERSNR';
    stName  : Field := 'MA_NAME';
  end;

  mask := TMask.Create(text);

  if GM.MAList.Eof then
    GM.MAList.First;

  row := GM.MAList.RecNo;
  while GM.MAList.Eof = false do
  begin
    if Mask.Matches(GM.MAList.FieldByName(field).AsString) then
    begin
      if row <> GM.MAList.RecNo then
        break;
    end;
    GM.MAList.Next;
  end;
  mask.Free;
end;

procedure TWaehlerListeForm.FormCreate(Sender: TObject);
begin
  if GM.MAList.IsEmpty then
    GM.updateMATab;

  GM.MAList.Open;
end;

function TWaehlerListeForm.getWaehler: IWaehler;
begin
  Result := NIL;

  if DataSource1.DataSet.IsEmpty then
    exit;

  Result  := TWaehler.create;
  Result.ID        := DataSource1.DataSet.FieldByName('MA_ID').AsInteger;
  Result.PersNr    := DataSource1.DataSet.FieldByName('MA_PERSNR').AsString;
  Result.Name      := DataSource1.DataSet.FieldByName('MA_NAME').AsString;
  Result.Vorname   := DataSource1.DataSet.FieldByName('MA_VORNAME').AsString;
  Result.Geschlecht:= DataSource1.DataSet.FieldByName('MA_GENDER').AsString;
  Result.Abteilung := DataSource1.DataSet.FieldByName('MA_ABTEILUNG').AsString;

end;

procedure TWaehlerListeForm.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    find( trim(LabeledEdit1.Text), stPersNr);
  end;
end;

procedure TWaehlerListeForm.LabeledEdit2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    find( trim(LabeledEdit2.Text), stName);
  end;

end;

end.
