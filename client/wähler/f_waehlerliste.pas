unit f_waehlerliste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Excel4Delphi,
  Excel4Delphi.Stream, Vcl.Mask;

type
  TWaehlerlisteForm = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    GroupBox2: TGroupBox;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    btnUpdate: TBitBtn;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label5: TLabel;
    ComboBox5: TComboBox;
    CheckBox1: TCheckBox;
    LV: TListView;
    btnUse: TBitBtn;
    btnLoad: TBitBtn;
    GroupBox3: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    btnScan: TBitBtn;
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnUseClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnScanClick(Sender: TObject);
  private
    m_workBook: TZWorkBook;
    procedure Fillcombos( sheet : TZSheet );
  public
    class procedure ExecuteForm;
  end;

var
  WaehlerlisteForm: TWaehlerlisteForm;

implementation

{$R *.dfm}

uses
  m_res, System.JSON, u_json;

{ TWaehlerlisteForm }

procedure TWaehlerlisteForm.btnLoadClick(Sender: TObject);
var
  fname : string;
begin
  fname := trim(Edit1.Text);
  if not FileExists(fname) then
  begin
    ShowMessage('Datei nicht gefunden!');
    exit;
  end;
  if Assigned(m_workBook) then
    FreeAndNil(m_workBook);

  m_workBook := TZWorkBook.Create(NIL);
  m_workBook.LoadFromFile(fname);
  FillCombos( m_workBook.Sheets[0] );
end;

procedure TWaehlerlisteForm.btnScanClick(Sender: TObject);
begin
  // suche nach begriffen für Frann/Frau/div.
end;

procedure TWaehlerlisteForm.btnUpdateClick(Sender: TObject);
var
  obj : TJSONObject;
  arr : TJSONArray;
  item : TListItem;
  i    : integer;
  j    : integer;
  data : TJSONArray;
begin
  obj := TJSONObject.Create;
  arr := TJSONArray.Create;
  arr.Add('PersNr');
  arr.Add('Name');
  arr.Add('Vorname');
  arr.Add('Anrede');
  arr.Add('Abteilung');

  JReplace( obj, 'fieldnames', arr);

  data  := TJSONArray.Create;
  for i := 0 to pred(LV. Items.Count) do
  begin
    arr := TJSONArray.Create;

    item := LV.Items[i];
    arr.Add(item.Caption);
    for j := 0 to pred(item.SubItems.Count) do
      arr.Add(item.SubItems[j]);

    data.AddElement(arr);
  end;
  JReplace(obj, 'data', data);
  saveJSON(obj, 'dump.json');
  obj.Free;
end;

procedure TWaehlerlisteForm.btnUseClick(Sender: TObject);
var
  map : array[0..4] of Integer;
  item : TListItem;
  st : integer;
  row : integer;
  sheet : TZSheet;

  function getCol( row, inx : integer ) : string;
  begin
    Result := 'N/A';
    if inx > -1 then
      Result := sheet.Cell[map[inx], row].AsString;
  end;

begin
  map[0] := ComboBox1.ItemIndex;
  map[1] := ComboBox3.ItemIndex;
  map[2] := ComboBox4.ItemIndex;
  map[3] := ComboBox2.ItemIndex;
  map[4] := ComboBox5.ItemIndex;

  LV.Items.Clear;
  st := 0;
  if CheckBox1.Checked then
    st := 1;

  sheet := m_workBook.Sheets[0];
  for row := st to pred( sheet.RowCount) do
  begin
    item := LV.Items.Add;
    item.Caption := getCol( row, 0);
    item.SubItems.Add(getCol( row, 1));
    item.SubItems.Add(getCol( row, 2));
    item.SubItems.Add(getCol( row, 3));
    item.SubItems.Add(getCol( row, 4));
  end;
end;

class procedure TWaehlerlisteForm.ExecuteForm;
begin
  try
    Application.CreateForm(TWaehlerlisteForm, WaehlerlisteForm);
    WaehlerlisteForm.ShowModal;
  finally
    WaehlerlisteForm.free;
  end;
end;

procedure TWaehlerlisteForm.Fillcombos(sheet: TZSheet);
var
  x : integer;
  procedure setindex( cb : TComboBox; inx : integer );
  begin
    if inx < Cb.Items.Count then
      cb.ItemIndex := inx;
  end;
begin
  ComboBox1.Items.Clear;

  for x := 0 to pred(sheet.ColCount) do
  begin
    ComboBox1.Items.Add(sheet.Cell[x, 0].AsString);
  end;
  ComboBox2.Items.Assign(ComboBox1.Items);
  ComboBox3.Items.Assign(ComboBox1.Items);
  ComboBox4.Items.Assign(ComboBox1.Items);
  ComboBox5.Items.Assign(ComboBox1.Items);
  setindex(ComboBox1, 0);
  setindex(ComboBox2, 3);
  setindex(ComboBox3, 2);
  setindex(ComboBox4, 1);
  setindex(ComboBox5, 4);
end;

procedure TWaehlerlisteForm.FormCreate(Sender: TObject);
begin
  m_workBook := NIL;
  Edit1.Text := 'D:\git_d12\MitbestimmIT\testdaten\Firma1\Mitarbeiterliste_120_Personen.xlsx';
end;

procedure TWaehlerlisteForm.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit1.Text := OpenDialog1.FileName;
    btnLoad.Click;
  end;
end;

end.
