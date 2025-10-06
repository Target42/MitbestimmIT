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
unit f_planungsform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, JvWizard, JvExControls,
  fr_wahlverfahren, fr_wahlfristen, u_BRWahlFristen, fr_wahlvorstand,
  System.Generics.Collections;

type
  TPlanungsform = class(TForm)
    StatusBar1: TStatusBar;
    JvWizard1: TJvWizard;
    JvWizardWelcomePage1: TJvWizardWelcomePage;
    JvWizardInteriorPage1: TJvWizardInteriorPage;
    JvWizardInteriorPage2: TJvWizardInteriorPage;
    WahlverfahrenFrame1: TWahlverfahrenFrame;
    WahlfristenFrame1: TWahlfristenFrame;
    procedure FormDestroy(Sender: TObject);
    procedure JvWizardInteriorPage2EnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure FormCreate(Sender: TObject);
    procedure JvWizardInteriorPage1EnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
  private
    m_list : TWahlPhasenListe;
  public
    class procedure Execute;
  end;

var
  Planungsform: TPlanungsform;

implementation

{$R *.dfm}

uses m_glob;

{ TPlanungsform }

class procedure TPlanungsform.Execute;
begin
  Application.CreateForm(TPlanungsform, Planungsform);
  Planungsform.ShowModal;
  Planungsform.Free;
end;

procedure TPlanungsform.FormCreate(Sender: TObject);
begin
  m_list := getWahlPhasen(wvAllgemein);
  WahlverfahrenFrame1.init(@m_list);
  WahlfristenFrame1.init(@m_list)
end;

procedure TPlanungsform.FormDestroy(Sender: TObject);
begin
  WahlverfahrenFrame1.release;

  if Assigned(m_list) then
    releaseWahlPhasen(m_list);
end;

procedure TPlanungsform.JvWizardInteriorPage1EnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  WahlfristenFrame1.updateView;
end;

procedure TPlanungsform.JvWizardInteriorPage2EnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
    JvWizardInteriorPage2.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel, TJvWizardButtonKind.bkFinish];
end;


end.
