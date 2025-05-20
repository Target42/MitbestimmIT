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
unit f_wahlklokalForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  m_res, fr_base, Vcl.Buttons, u_wahllokal;

type
  TWahllokalForm = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    RaumView: TListView;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    GroupBox2: TGroupBox;
    BaseFrame1: TBaseFrame;
    Splitter1: TSplitter;
    Helferview: TListView;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    procedure btnAddClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_items : TWahlLokalListe;
    procedure UpdateView;
    procedure UpdateRow( item : TListItem; lokal : TWahlLokal );

  public
    class procedure execute;

    procedure load;
  end;

var
  WahllokalForm: TWahllokalForm;

implementation

uses
  f_wahllokalRaum, m_glob;

{$R *.dfm}

{ TWahllokalForm }

procedure TWahllokalForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  if GM.IsSimulation then
  begin
    Gm.Simulation.WahlLokale.assign(m_items);
  end
  else
  begin

  end;
end;

procedure TWahllokalForm.btnAddClick(Sender: TObject);
var
  lokal :TWahllokal;
begin
  lokal := TWahllokalRaumform.add;
  if Assigned(lokal) then
  begin
    m_items.add(lokal);
  end;
end;

procedure TWahllokalForm.btnEditClick(Sender: TObject);
var
  lokal : TWahlLokal;
begin
  if not Assigned(RaumView.Selected) then
    exit;

  lokal := RaumView.Selected.Data;
  if TWahllokalRaumform.edit(lokal) then
  begin
    UpdateRow(RaumView.Selected, lokal);
  end;
end;

class procedure TWahllokalForm.execute;
begin
  Application.CreateForm(TWahllokalForm, WahllokalForm);
  WahllokalForm.load;
  WahllokalForm.ShowModal;
  WahllokalForm.Free;
end;

procedure TWahllokalForm.FormCreate(Sender: TObject);
begin
  m_items := TWahlLokalListe.create;
end;

procedure TWahllokalForm.FormDestroy(Sender: TObject);
begin
  m_items.free;
end;

procedure TWahllokalForm.load;
begin
  if GM.IsSimulation then
  begin
    if Assigned(m_items) then
      FreeAndNil(m_items);
    m_items := Gm.Simulation.WahlLokale.clone;
  end
  else
  begin
    if not Assigned(m_items) then
      m_items := TWahlLokalListe.create;

  end;
  UpdateView;
end;

procedure TWahllokalForm.UpdateRow(item: TListItem; lokal: TWahlLokal);
begin
  item.Data := lokal;
  item.Caption := lokal.Building;
  item.SubItems.Clear;
  item.SubItems.Add(lokal.Raum);
  item.SubItems.Add(lokal.Stockwerk);
  item.SubItems.Add(FormatDateTime('dd.MM.yyyy hh:mm', lokal.Von));
  item.SubItems.Add(FormatDateTime('dd.MM.yyyy hh:mm', lokal.Bis));
end;

procedure TWahllokalForm.UpdateView;
var
  lokal : TWahlLokal;
begin
  RaumView.Items.BeginUpdate;
  RaumView.Items.Clear;
  Helferview.Items.Clear;

  for lokal in m_items.Items do
    UpdateRow(RaumView.Items.Add, lokal);

  RaumView.Items.EndUpdate;
end;

end.
