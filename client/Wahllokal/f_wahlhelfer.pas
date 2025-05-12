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
unit f_wahlhelfer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, fr_base, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, u_WahlhelferListe, u_Wahlhelfer;

type
  TWahlhelferForm = class(TForm)
    LV: TListView;
    GroupBox1: TGroupBox;
    BaseFrame1: TBaseFrame;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    m_helfer : TWahlhelferListe;
    procedure updateRow( item : TListItem; helfer : TWahlhelfer);
    procedure UpdateView;
  public

    class procedure Execute;
  end;

var
  WahlhelferForm: TWahlhelferForm;

implementation

{$R *.dfm}

uses
  m_res, f_wahlhelfer_person, Vcl.Dialogs, system.UITypes;

{ TForm1 }

procedure TWahlhelferForm.btnAddClick(Sender: TObject);
var
  helfer : TWahlhelfer;
begin
  helfer := TWahlhelfer.Create;
  Application.CreateForm(TWahlhelferPersonForm, WahlhelferPersonForm);
  WahlhelferPersonForm.Person := helfer;
  if WahlhelferPersonForm.ShowModal = mrOk then
  begin
    m_helfer.AddWahlhelfer(helfer);
    updateRow(LV.Items.Add, helfer);
  end
  else
    m_helfer.Free;

  WahlhelferPersonForm.Free;
end;

procedure TWahlhelferForm.btnDeleteClick(Sender: TObject);
var
  helfer : TWahlhelfer;
begin
  if not Assigned(Lv.Selected) then
    exit;

  if MessageDlg('Soll der Wahlhelfer wirklich gelöscht werden?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    helfer := LV.Selected.Data;
    m_helfer.RemoveWahlhelfer(helfer);
    LV.Items.Delete(LV.Selected.Index);
  end;
end;

procedure TWahlhelferForm.btnEditClick(Sender: TObject);
var
  helfer : TWahlhelfer;
begin
  if not Assigned(Lv.Selected) then
    exit;

  helfer := Lv.Selected.Data;
  Application.CreateForm(TWahlhelferPersonForm, WahlhelferPersonForm);
  WahlhelferPersonForm.Person := helfer;

  if WahlhelferPersonForm.ShowModal = mrOk then
    updateRow(LV.Selected, helfer);

  WahlhelferPersonForm.Free;
end;

class procedure TWahlhelferForm.Execute;
begin
  Application.CreateForm(TWahlhelferForm, WahlhelferForm);
  WahlhelferForm.ShowModal;
  WahlhelferForm.Free;
end;

procedure TWahlhelferForm.FormCreate(Sender: TObject);
begin
  m_helfer := TWahlhelferListe.Create;
  UpdateView;
end;

procedure TWahlhelferForm.FormDestroy(Sender: TObject);
begin
  m_helfer.Free;
end;

procedure TWahlhelferForm.updateRow(item: TListItem; helfer: TWahlhelfer);
begin
  item.SubItems.Clear;
  item.Data := helfer;
  item.Caption := helfer.Personamnummer;
  item.SubItems.Add(helfer.Name);
  item.SubItems.Add(helfer.Vorname);
  item.SubItems.Add(helfer.Geschlecht);
  item.SubItems.Add(helfer.Abteilung);
end;

procedure TWahlhelferForm.UpdateView;
var
  i : integer;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;
  for i := 0 to pred(m_helfer.Count) do
  begin
    updateRow(Lv.Items.Add, m_helfer.Items[i]);
  end;
  LV.Items.EndUpdate;
end;

end.
