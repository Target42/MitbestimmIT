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
  JvExStdCtrls, JvHtControls, Vcl.ComCtrls, u_BRWahlFristen;

type
  TWahlverfahrenFrame = class(TFrame)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    m_fristen  : PTWahlFristen;
  public
    procedure init( ptr : PTWahlFristen);
    procedure release;

    procedure save;
  end;

implementation

{$R *.dfm}

{ TWahlverfahrenFrame }

procedure TWahlverfahrenFrame.init(ptr: PTWahlFristen);
begin
  m_fristen := ptr;
  RadioButton1.Checked := m_fristen^.Verfahren = wvVereinfacht;
  RadioButton2.Checked := m_fristen^.Verfahren = wvAllgemein;
end;

procedure TWahlverfahrenFrame.RadioButton1Click(Sender: TObject);
begin
  m_fristen^.Verfahren := wvVereinfacht;
end;

procedure TWahlverfahrenFrame.RadioButton2Click(Sender: TObject);
begin
  m_fristen^.Verfahren := wvVereinfacht;
end;

procedure TWahlverfahrenFrame.release;
begin

end;

procedure TWahlverfahrenFrame.save;
begin

end;

end.
