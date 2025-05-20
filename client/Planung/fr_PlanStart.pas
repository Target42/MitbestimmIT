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
unit fr_PlanStart;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TWahlPlanungStartFrame = class(TFrame)
    GroupBox2: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    btnPwdTest: TBitBtn;
    Image1: TImage;
    Panel1: TPanel;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    procedure btnPwdTestClick(Sender: TObject);
    procedure LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private-Deklarationen }
  public
    procedure init;
    procedure release;
  end;

implementation

{$R *.dfm}

uses
  m_res, f_PassWord, system.IOUtils;

{ TWahlPlanungStartFrame }

procedure TWahlPlanungStartFrame.btnPwdTestClick(Sender: TObject);
var
  s : string;
begin
  if (LabeledEdit1.Text = '') or (LabeledEdit1.Text <> LabeledEdit2.text) then
  begin
    ShowMessage('Das Passwort darf nicht leer sein und die beiden Passwörter müssen übereinstimmen.');
    exit;
  end;

  if TPasswordDlg.getPwd( s ) then
  begin
    if s = LabeledEdit1.Text then
      ShowMessage('Test erfolgreich!')
    else
      ShowMessage('Test NICHT erfolgreich!')

  end;
end;

procedure TWahlPlanungStartFrame.init;
begin

end;

procedure TWahlPlanungStartFrame.LabeledEdit3KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not TPath.IsValidPathChar(Key) then
    key := #0;
end;

procedure TWahlPlanungStartFrame.release;
begin

end;

end.
