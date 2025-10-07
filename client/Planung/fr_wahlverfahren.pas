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
unit fr_wahlverfahren;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  JvExStdCtrls, JvHtControls, Vcl.ComCtrls, u_BRWahlFristen, Vcl.ExtCtrls,
  System.Generics.Collections;

type
  TWahlverfahrenFrame = class(TFrame)
    RadioGroup1: TRadioGroup;
    RichEdit1: TRichEdit;
    procedure RadioGroup1Click(Sender: TObject);
    procedure RichEdit1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    m_list : PTWahlPhasenListe;
    m_normal : TStream;
    m_einfach : TStream;
  public
    procedure setVerfahren( value :TWahlVerfahren );
    procedure init(list : PTWahlPhasenListe);
    procedure release;
  end;

implementation

{$R *.dfm}

uses u_helper;

{ TWahlverfahrenFrame }

procedure TWahlverfahrenFrame.init(list : PTWahlPhasenListe);
begin
  m_normal  := TMemoryStream.Create;
  m_einfach := TMemoryStream.Create;
  m_list    := list;

  LoadRCDataToStream('BER1', m_normal);
  LoadRCDataToStream('BER2', m_einfach);

  RadioGroup1.ItemIndex := 0;
end;

procedure TWahlverfahrenFrame.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
  begin
    m_normal.Position := 0;
    RichEdit1.Lines.LoadFromStream(m_normal);
    releaseWahlPhasen(m_list^);
    m_list^ := getWahlPhasen( wvAllgemein );
  end
  else
  begin
    m_einfach.Position := 0;
    RichEdit1.Lines.LoadFromStream(m_einfach);
    releaseWahlPhasen(m_list^);
    m_list^ := getWahlPhasen( wvVereinfacht );
  end;

end;

procedure TWahlverfahrenFrame.release;
begin
  m_einfach.Free;
  m_normal.Free;
end;

procedure TWahlverfahrenFrame.RichEdit1MouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
const
  // Windows-Konstanten für das vertikale Scrollen
  SB_LINEUP   = 0; // Scrolle eine Zeile nach oben
  SB_LINEDOWN = 1; // Scrolle eine Zeile nach unten
  WM_VSCROLL  = $0115; // Message für vertikales Scrollen
var
  ScrollMessage: Integer;
begin
  // Zuerst setzen wir Handled auf True, damit der Parent nicht scrollt.
  Handled := True;

  // Bestimmen der Scroll-Richtung basierend auf WheelDelta
  if WheelDelta > 0 then // Mausrad nach oben
    ScrollMessage := SB_LINEUP
  else if WheelDelta < 0 then // Mausrad nach unten
    ScrollMessage := SB_LINEDOWN
  else
    Exit; // Kein Scrollen nötig

  // Die Scroll-Message an das RichEdit senden
  // Perform sendet die Message direkt an die Fensterprozedur des Steuerelements.
  TRichEdit(Sender).Perform(WM_VSCROLL, ScrollMessage, 0);

end;

procedure TWahlverfahrenFrame.setVerfahren(value: TWahlVerfahren);
begin
  if value = wvAllgemein then
    RadioGroup1.ItemIndex := 0
  else
    RadioGroup1.ItemIndex := 1;
end;

end.
