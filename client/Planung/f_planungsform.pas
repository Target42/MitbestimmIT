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
  fr_PlanStart, u_WahlDef;

type
  TPlanungsform = class(TForm)
    StatusBar1: TStatusBar;
    JvWizard1: TJvWizard;
    JvWizardWelcomePage1: TJvWizardWelcomePage;
    WahlverfahrenFrame1: TWahlverfahrenFrame;
    JvWizardInteriorPage1: TJvWizardInteriorPage;
    WahlfristenFrame1: TWahlfristenFrame;
    JvWizardInteriorPage2: TJvWizardInteriorPage;
    WahlPlanungStartFrame1: TWahlPlanungStartFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure JvWizard1FinishButtonClick(Sender: TObject);
    procedure JvWizard1CancelButtonClick(Sender: TObject);
    procedure JvWizardInteriorPage2EnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure JvWizardInteriorPage2FinishButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardWelcomePage1NextButtonClick(Sender: TObject;
      var Stop: Boolean);
  private
    m_def : TWahlDef;
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
  m_def := GM.Storage.WahlDefinition.getData;

  WahlPlanungStartFrame1.init(m_def);
  WahlverfahrenFrame1.init(@m_def.WahlFristen);
  WahlfristenFrame1.init(@m_def.WahlFristen);

  if m_def.WahlFristen.WahltagStart = 0.0 then
  begin
    m_Def.WahlFristen.Verfahren := wvVereinfacht;
    WahlfristenFrame1.setDefaultDate(StrToDate('15.5.2026'));
  end;
end;

procedure TPlanungsform.FormDestroy(Sender: TObject);
begin
  WahlfristenFrame1.release;
  WahlverfahrenFrame1.release;
  WahlPlanungStartFrame1.release;
end;

procedure TPlanungsform.JvWizard1CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TPlanungsform.JvWizard1FinishButtonClick(Sender: TObject);
begin
  //
  Close;
end;

procedure TPlanungsform.JvWizardInteriorPage2EnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
    JvWizardInteriorPage2.VisibleButtons := [TJvWizardButtonKind.bkBack, TJvWizardButtonKind.bkCancel, TJvWizardButtonKind.bkFinish];
end;


procedure TPlanungsform.JvWizardInteriorPage2FinishButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  // save ...
  WahlPlanungStartFrame1.save;
  WahlverfahrenFrame1.save;
  WahlfristenFrame1.save;
  GM.Storage.WahlDefinition.saveData(m_def);
end;


procedure TPlanungsform.JvWizardWelcomePage1NextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  if not WahlPlanungStartFrame1.isPasswortOk then
  begin
    ShowMessage('Das Passwort ist nicht korrekt!');
    stop := true;
  end;
end;

end.
