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
  System.Generics.Collections, u_stub, u_json, Vcl.WinXCalendars;

type
  TPlanungsform = class(TForm)
    StatusBar1: TStatusBar;
    JvWizard1: TJvWizard;
    JvWizardWelcomePage1: TJvWizardWelcomePage;
    JvWizardInteriorPage1: TJvWizardInteriorPage;
    WahlverfahrenFrame1: TWahlverfahrenFrame;
    WahlfristenFrame1: TWahlfristenFrame;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JvWizardInteriorPage1FinishButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure JvWizardInteriorPage1EnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
  private
    m_client : TWahlModClient;
    m_list   : TWahlPhasenListe;
    procedure loadData;
    procedure saveData;
  public
    class procedure Execute;
  end;

var
  Planungsform: TPlanungsform;

implementation

{$R *.dfm}

uses
  m_glob, System.JSON, f_planedit, system.DateUtils;

{ TPlanungsform }

class procedure TPlanungsform.Execute;
var
  client : TWahlModClient;
  editMode : boolean;
begin
  if not GM.isPhaseActive(WPE) then
  begin
    ShowMessage('Die Wahlplanung ist  bereits abgeschlossen.');
    exit;
  end;

  client := TWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  editMode := client.hasWahl;
  client.Free;

  if not editMode then
  begin
    Application.CreateForm(TPlanungsform, Planungsform);
    Planungsform.ShowModal;
    Planungsform.Free;
  end
  else
  begin
    Application.CreateForm(TPlanEditoForm, PlanEditoForm);
    PlanEditoForm.ShowModal;
    PlanEditoForm.Free;
  end;

end;

procedure TPlanungsform.FormCreate(Sender: TObject);
begin
  m_list := getWahlPhasen(wvAllgemein);

  m_client := TWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  WahlverfahrenFrame1.init(@m_list);
  loadData;
  WahlfristenFrame1.init(@m_list)
end;

procedure TPlanungsform.FormDestroy(Sender: TObject);
begin
  WahlverfahrenFrame1.release;

  if Assigned(m_list) then
    releaseWahlPhasen(m_list);
  m_client.free;
  m_list.Free;
end;

procedure TPlanungsform.JvWizardInteriorPage1EnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  if WahlverfahrenFrame1.getVerfahren  = wvAllgemein then
    WahlfristenFrame1.setDefaultDate(now -10 * 7,  WahlverfahrenFrame1.getVerfahren)
  else
    WahlfristenFrame1.setDefaultDate(now - 4 * 7, WahlverfahrenFrame1.getVerfahren);

end;

procedure TPlanungsform.JvWizardInteriorPage1FinishButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  stop := true;
  saveData;
  Close;
end;

procedure TPlanungsform.loadData;
var
  data : TJSONObject;
  wv : TWahlVerfahren;
begin
  data := m_client.loadWahlData;

  wv := TWahlVerfahren(JInt(data, 'verfahren'));
  WahlverfahrenFrame1.setVerfahren(wv);
  JsonToWahlPhase( m_list, data );
end;


procedure TPlanungsform.saveData;
var
  data : TJSONObject;
begin
  data := WahlphasenToJson(m_list);
  JReplace( data, 'verfahren', WahlverfahrenFrame1.RadioGroup1.ItemIndex);
  m_client.saveWahlData(data);
end;

end.
