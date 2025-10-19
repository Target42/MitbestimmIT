{
  This file is part of the MitbestimmIT project.

  Copyright (C) 2025 Stephan Winter

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <https://www.gnu.org/licenses/>.
}
unit f_waehlerliste_import;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Excel4Delphi,
  Excel4Delphi.Stream, Vcl.Mask;

type
  TWaehlerlisteImportForm = class(TForm)
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
    btnScan: TBitBtn;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ComboBox9: TComboBox;
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnUseClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnScanClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

    m_workBook: TZWorkBook;
    m_sheet   : TZSheet;
    procedure Fillcombos;
  public
    class procedure ExecuteForm;
  end;

var
  WaehlerlisteImportForm: TWaehlerlisteImportForm;

implementation

{$R *.dfm}

uses
  m_res, System.JSON, u_json, u_Waehlerliste, m_glob, i_waehlerliste, u_stub;

{ TWaehlerlisteForm }

procedure TWaehlerlisteImportForm.btnLoadClick(Sender: TObject);
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
  begin
    FreeAndNil(m_workBook);
    m_sheet := NIL;
  end;

  Screen.Cursor := crHourGlass;
  m_workBook := TZWorkBook.Create(NIL);
  try
    m_workBook.LoadFromFile(fname);
    m_sheet := m_workBook.Sheets[0];
    FillCombos;

    btnUse.Click;
    btnScan.Click;

  except
    on E: Exception do
    begin
      FreeAndNil(m_workBook);
      Screen.Cursor := crDefault;
      ShowMessage('Fehler beim Laden der Datei: ' + E.Message);
      Exit;
    end;
  end;
    Screen.Cursor := crDefault;
end;

procedure TWaehlerlisteImportForm.btnScanClick(Sender: TObject);
var
  row : integer;
  inx : integer;
  list : TStringList;
  s    : string;
  st   : integer;
begin
  if not Assigned(m_workBook) or (m_workBook.Sheets.Count = 0) then
  begin
    ShowMessage('Arbeitsmappe ist nicht geladen oder enthält keine Blätter!');
    Exit;
  end;
  inx := ComboBox2.ItemIndex;
  if inx = -1 then
  begin
    ShowMessage('Es wurde keine Spalte für das Geschlecht bestimmt!!!');
    exit;
  end;
  list := TStringList.Create;

  m_sheet := m_workBook.Sheets[0];
  st := 0;
  if CheckBox1.Checked then
    st := 1;
  for row := st to pred(m_sheet.RowCount) do
  begin
    s := trim(m_sheet.Cell[inx, row].AsString);
    if (s <> '') and (list.IndexOf(s) = -1) then
      list.Add(s);
  end;

  ComboBox6.Items.Assign(list);
  ComboBox7.Items.Assign(list);

  ComboBox6.ItemIndex := 0;
  ComboBox7.ItemIndex := 1;

  list.Free;

end;

procedure TWaehlerlisteImportForm.btnUpdateClick(Sender: TObject);
var
  liste : IWaehlerListe;
  i     : integer;
  waehler: IWaehler;
  item  : TListItem;
    m, w, d : string;

  function geschlecht( s : string ) : string;
  begin
    Result := '';

    if SameText( s, m) then
      Result := 'männlich'
    else if SameText(s, w) then
      Result := 'weiblich'
    else
    begin
      Result := d;
    end;
    if Result = '' then
      Result := 'weiblich';
  end;

var
  client : TWaehlerModClient;
  res : TJSONObject;
begin
  Screen.Cursor := crHourGlass;
  m := ComboBox6.Text;
  w := ComboBox7.Text;
  d := ComboBox8.Text;

  liste := TWaehlerListe.create;

  for i := 0 to pred(LV. Items.Count) do
  begin
    item := LV.Items[i];

    waehler := liste.new;
    waehler.PersNr    := item.Caption;
    waehler.Name      := item.SubItems[0];
    waehler.Vorname   := item.SubItems[1];
    waehler.Anrede    := geschlecht(item.SubItems[2]);
    waehler.Abteilung := item.SubItems[3];
    waehler.GebDatum  := item.SubItems[4];

    liste.add(waehler);
  end;

  client := TWaehlerModClient.Create(GM.SQLConnection1.DBXConnection);
  res := client.import(liste.toSimpleJSON);
  client.Free;

  liste.release;
  Screen.Cursor := crDefault;
  Close;
end;

procedure TWaehlerlisteImportForm.btnUseClick(Sender: TObject);
var
  map : array[0..5] of Integer;
  item : TListItem;
  st : integer;
  row : integer;

  function getCol( row, inx : integer ) : string;
  begin
    Result := 'N/A';
    if inx > -1 then
      Result := m_sheet.Cell[map[inx], row].AsString;
  end;

var
  s : string;
begin
  map[0] := ComboBox1.ItemIndex; // PersNr
  map[1] := ComboBox3.ItemIndex; // Name
  map[2] := ComboBox4.ItemIndex; // Vorname
  map[3] := ComboBox2.ItemIndex; // Geschlecht
  map[4] := ComboBox5.ItemIndex; // Abteilung
  map[5] := ComboBox9.ItemIndex; // GebDat

  LV.Items.Clear;
  st := 0;
  if CheckBox1.Checked then
    st := 1;

  for row := st to pred( m_sheet.RowCount) do
  begin
    s := trim(getCol( row, 0));
    if s <> '' then
    begin
      item := LV.Items.Add;
      item.Caption := s;
      item.SubItems.Add(getCol( row, 1));
      item.SubItems.Add(getCol( row, 2));
      item.SubItems.Add(getCol( row, 3));
      item.SubItems.Add(getCol( row, 4));
      item.SubItems.Add(getCol( row, 5));
    end;
  end;
end;

class procedure TWaehlerlisteImportForm.ExecuteForm;
begin
  try
    Application.CreateForm(TWaehlerlisteImportForm, WaehlerlisteImportForm);
    WaehlerlisteImportForm.ShowModal;
  finally
    WaehlerlisteImportForm.free;
  end;
end;

procedure TWaehlerlisteImportForm.Fillcombos;
var
  x : integer;

  procedure setindex( cb : TComboBox; inx : integer );
  begin
    if inx < Cb.Items.Count then
      cb.ItemIndex := inx;
  end;
begin
  ComboBox1.Items.Clear;

  for x := 0 to pred(m_sheet.ColCount) do
  begin
    ComboBox1.Items.Add(m_sheet.Cell[x, 0].AsString);
  end;

  ComboBox2.Items.Assign(ComboBox1.Items);
  ComboBox3.Items.Assign(ComboBox1.Items);
  ComboBox4.Items.Assign(ComboBox1.Items);
  ComboBox5.Items.Assign(ComboBox1.Items);
  ComboBox9.Items.Assign(ComboBox1.Items);

  setindex(ComboBox1, 0);
  setindex(ComboBox2, 3);
  setindex(ComboBox3, 2);
  setindex(ComboBox4, 1);
  setindex(ComboBox5, 4);
  setindex(ComboBox9, 5);
end;

procedure TWaehlerlisteImportForm.FormCreate(Sender: TObject);
begin
  m_workBook := NIL;
  m_sheet := NIL;

  ComboBox1.Text := '';
  ComboBox2.Text := '';
  ComboBox3.Text := '';
  ComboBox4.Text := '';
  ComboBox5.Text := '';
  ComboBox6.Text := '';
  ComboBox7.Text := '';
  ComboBox9.Text := '';

{$ifdef DEBUG}
  Edit1.Text := 'D:\git_d12\MitbestimmIT\testdaten\Firma1\Wahlvorstand_120_Personen.xlsx';
{$ENDIF}
end;

procedure TWaehlerlisteImportForm.FormDestroy(Sender: TObject);
begin
  if Assigned(m_workBook) then
  begin
    m_workBook.Free;
  end;
end;

procedure TWaehlerlisteImportForm.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit1.Text := OpenDialog1.FileName;
    btnLoad.Click;
  end;
end;

end.
