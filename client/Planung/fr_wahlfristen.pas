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

unit fr_wahlfristen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  VclTee.TeeGDIPlus, JvExControls, JvCalendar, VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart,
  u_BRWahlFristen, Vcl.StdCtrls, Vcl.Buttons, System.Generics.Collections,
  System.Actions, Vcl.ActnList, Vcl.Menus, VCLTee.GanttCh, m_res;

type
  TWahlfristenFrame = class(TFrame)
    Chart1: TChart;
    Series1: TGanttSeries;
    GroupBox1: TGroupBox;
    LV: TListView;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    ac_edit: TAction;
    Bearbeiten1: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    ac_berechnen: TAction;
    procedure LVDblClick(Sender: TObject);
    procedure ac_editExecute(Sender: TObject);
    procedure ac_berechnenExecute(Sender: TObject);
  private
    m_type : TWahlVerfahren;
    m_list : PTWahlPhasenListe;

    m_fmt  : TFormatSettings;
    procedure updateItem( item : TListItem; phase : PTWahlPhase );
    procedure CreateGanttChart;
  public
    procedure init(list : PTWahlPhasenListe);
    procedure setDefaultDate( date : TDateTime; verfahren: TWahlVerfahren );
    procedure release;
    procedure updateView;
  end;

implementation

uses
  System.DateUtils, f_wahl_phase, f_wahldate;

{$R *.dfm}

procedure TWahlfristenFrame.ac_berechnenExecute(Sender: TObject);
begin
  Application.CreateForm(TWahlDateform, WahlDateform);
  if ( WahlDateform.ShowModal = mrOk) then
  begin
    if m_type = wvAllgemein then
      AutoFillNormal(WahlDateform.Date, m_list^)
    else
      AutoFillEinfach(WahlDateform.Date, m_list^);
    updateView;
  end;
  WahlDateform.free;
end;

procedure TWahlfristenFrame.ac_editExecute(Sender: TObject);
var
  ptr : PTWahlPhase;
begin
  if not Assigned(Lv.Selected) then
    exit;

  ptr := Lv.Selected.Data;
  if ptr^.typ <> dtKeines then
  begin
    Application.CreateForm(TWahlPhaseForm, WahlPhaseForm);
    WahlPhaseForm.WahlPhase := ptr;
    if WahlPhaseForm.ShowModal = mrOk then
    begin
      updateItem(LV.Selected, ptr);
    end;
    WahlPhaseForm.Free;
  end;
end;

procedure TWahlfristenFrame.CreateGanttChart;
var
  GanttSeries: TGanttSeries;
  i : integer;
  inx : integer;
  ptr : PTWahlPhase;
begin
  Chart1.RemoveAllSeries;
  GanttSeries := TGanttSeries.Create(Self);
  Chart1.AddSeries(GanttSeries);
  GanttSeries.Title := 'Wahl';
  Chart1.BottomAxis.DateTimeFormat := 'dd.mm.yy'; // Datumsformat für die X-Achse
  inx := -1;
  for i := pred(m_list.Count) downto 0 do
  begin
    ptr := m_list^[i];
    if (ptr^.typ <> dtKeines) then
    begin
      if ( ptr^.typ = dtTag) then
        ptr^.ende := ptr^.start;

      inx := GanttSeries.AddGantt(ptr^.start,  ptr^.ende, inx, ptr^.titel);
    end;
  end;

end;

procedure TWahlfristenFrame.init(list : PTWahlPhasenListe);
begin
  m_list := list;
  m_fmt  := TFormatSettings.Create('de-DE');
  m_type := wvAllgemein;
end;

procedure TWahlfristenFrame.LVDblClick(Sender: TObject);
begin
  ac_edit.Execute;
end;

procedure TWahlfristenFrame.release;
begin

end;

procedure TWahlfristenFrame.setDefaultDate(date: TDateTime; verfahren: TWahlVerfahren);
begin
  m_type := verfahren;

  ac_berechnen.Execute;
  updateView;

end;

procedure TWahlfristenFrame.updateItem(item: TListItem; phase: PTWahlPhase);
begin
  item.Data       := phase;
  item.Caption    := intToStr(phase^.nr + 1);

  item.SubItems.Clear;
  item.SubItems.Add(phase^.titel);
  if (phase^.typ = dtTag) then
  begin
    item.SubItems.Add(FormatDateTime('ddd dd.MM.yy', phase^.start, m_fmt));
  end
  else
  if (phase^.typ = dtZeitraum) then
  begin
    item.SubItems.Add(FormatDateTime('ddd dd.MM.yy', phase^.start,m_fmt));
    item.SubItems.Add(FormatDateTime('ddd dd.MM.yy', phase^.ende, m_fmt));
  end
  else
  if (phase^.typ = dtZeitpunkte) then
  begin
    item.SubItems.Add(FormatDateTime('ddd dd.MM.yy hh:mm', phase^.start,m_fmt));
    item.SubItems.Add(FormatDateTime('ddd dd.MM.yy hh:mm', phase^.ende, m_fmt));
  end;

end;

procedure TWahlfristenFrame.updateView;
var
  i : integer;
  item : TListItem;
  phase : PTWahlPhase;
begin
  Lv.Items.Clear;
  for i := 0 to pred(m_list^.Count) do
  begin
    phase           := m_list^.Items[i];
    item            := LV.Items.Add;
    updateItem(item, phase);
  end;
  CreateGanttChart;
end;

end.
