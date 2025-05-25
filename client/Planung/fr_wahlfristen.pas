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
  VclTee.TeeGDIPlus, JvExControls, JvCalendar, VCLTee.TeEngine, VCLTee.Series,
  VCLTee.GanttCh, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart,
  u_BRWahlFristen, Vcl.StdCtrls, Vcl.Buttons;

type
  TWahlfristenFrame = class(TFrame)
    Panel1: TPanel;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    DateTimePicker5: TDateTimePicker;
    DateTimePicker6: TDateTimePicker;
    DateTimePicker7: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Chart1: TChart;
    Series1: TGanttSeries;
    DateTimePicker8: TDateTimePicker;
    Label15: TLabel;
    Label16: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
  private
    m_fristen  : PTWahlFristen;
    m_inUpdate : boolean;
    procedure UpdateEdits;
  public
    procedure init( ptr : PTWahlFristen);
    procedure setDefaultDate( date : TDateTime );
    procedure release;
    procedure save;
  end;

implementation

uses
  System.DateUtils;

{$R *.dfm}

procedure TWahlfristenFrame.BitBtn1Click(Sender: TObject);
var
  s : string;
begin
  if not PruefeWahlFristen(m_fristen^, s) then
    ShowMessage(s);
end;

procedure TWahlfristenFrame.Button1Click(Sender: TObject);
begin
  m_fristen^ := BerechneWahlFristen( DateTimePicker1.Date, DateTimePicker8.Date, m_fristen^.Verfahren);
  UpdateEdits;
end;

procedure TWahlfristenFrame.DateTimePicker1Change(Sender: TObject);
var
  dtp : TDateTimePicker;
begin
  if m_inUpdate then
    exit;

  dtp := sender as TDateTimePicker;
  case dtp.tag of
    1 : m_fristen^.WahltagStart            := dtp.Date;
    2 : m_fristen^.SpaetesterWahlvorstand  := dtp.Date;
    3 : m_fristen^.WahlausschreibenDatum   := dtp.Date;
    4 : m_fristen^.VorschlagsfristEnde     := dtp.Date;
    5 : m_fristen^.BekanntgabeVorschlaege  := dtp.Date;
    6 : m_fristen^.BekanntgabeErgebnis     := dtp.Date;
    7 : m_fristen^.AnfechtungsfristEnde    := dtp.Date;
    8 : m_fristen^.Wahltagende             := dtp.Date;
  end;

  UpdateEdits;
end;

procedure TWahlfristenFrame.init(ptr: PTWahlFristen);
begin
  m_fristen := ptr;
end;

procedure TWahlfristenFrame.release;
begin

end;

procedure TWahlfristenFrame.save;
begin

end;

procedure TWahlfristenFrame.setDefaultDate(date: TDateTime);
begin
  while( DayOftheWeek( date ) > 5 ) do
  begin
    date := IncDay(date, -1)
  end;
  DateTimePicker1.Date := date;
  DateTimePicker8.Date := date;
  Button1.Click;
end;

procedure TWahlfristenFrame.UpdateEdits;
  procedure setDate( da : TDateTime;  dtp : TDateTimePicker; lab : TLabel );
  begin
    dtp.Date := da;
    if DayOftheWeek( da ) > 5  then
    begin
      lab.Font.Color := clRed;
    end
    else
    begin
      lab.Font.Color := clBlack;
      dtp.Color := clBlack;
    end;
    lab.Caption := FormatDateTime('ddd', dtp.DateTime);
  end;
var
  gn : TGanttSeries;
begin
  m_inUpdate := true;

  setDate(m_fristen^.WahltagStart,           DateTimePicker1, Label8);
  setDate(m_fristen^.WahltagEnde ,           DateTimePicker8, Label15);
  setDate(m_fristen^.SpaetesterWahlvorstand, DateTimePicker2, Label9 );
  setDate(m_fristen^.WahlausschreibenDatum,  DateTimePicker3, Label10 );
  setDate(m_fristen^.VorschlagsfristEnde,    DateTimePicker4, Label11 );
  setDate(m_fristen^.BekanntgabeVorschlaege, DateTimePicker5, Label12 );
  setDate(m_fristen^.BekanntgabeErgebnis,    DateTimePicker6, Label13 );
  setDate(m_fristen^.AnfechtungsfristEnde,   DateTimePicker7, Label14 );

  gn := Chart1.SeriesList.Items[0] as TGanttSeries;
  gn.Clear;
  gn.AddGanttColor(m_fristen^.SpaetesterWahlvorstand,  m_fristen^.WahlausschreibenDatum,   0, 'Wahlausschreiben', clYellow);
  gn.AddGanttColor(m_fristen^.WahlausschreibenDatum,   m_fristen^.VorschlagsfristEnde,     1, 'Vorschlagsfrist',  clGreen);
  gn.AddGanttColor(m_fristen^.BekanntgabeVorschlaege,  m_fristen^.BekanntgabeVorschlaege,  2, 'Bekanntgabe',      clMoneyGreen);
  gn.AddGanttColor(m_fristen^.WahltagStart,            m_fristen^.WahltagEnde,             3, 'Wahltag/Ergbnis',  clRed);
  gn.AddGanttColor(m_fristen^.WahltagEnde,             m_fristen^.AnfechtungsfristEnde,    4, 'Anfechtungsfrist', clNavy);

  gn.NextTask[0] := 1;
  gn.NextTask[1] := 2;
  gn.NextTask[2] := 3;
  gn.NextTask[3] := 4;
  gn.Marks.Item[0].Visible := true;

  m_inUpdate := false;

end;

end.
