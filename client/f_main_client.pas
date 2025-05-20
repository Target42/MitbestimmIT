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

unit f_main_client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.ActnList, System.Actions,
  Vcl.StdActns, Vcl.Menus, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  m_glob;

type
  TMainClientForm = class(TForm)
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    Programm1: TMenuItem;
    Programm2: TMenuItem;
    FileExit1: TFileExit;
    Windows1: TMenuItem;
    ac_info: TAction;
    Info1: TMenuItem;
    StatusBar1: TStatusBar;
    Wahl1: TMenuItem;
    Briefwahl1: TMenuItem;
    Auszhlung1: TMenuItem;
    Wahlbuero1: TMenuItem;
    ac_wa_plan: TAction;
    Planen1: TMenuItem;
    ac_rooms: TAction;
    ac_helper: TAction;
    Rume1: TMenuItem;
    Wahlhelfer1: TMenuItem;
    ac_wa_berechtigte: TAction;
    Wahlberechtigteaktualisieren1: TMenuItem;
    ac_wa_listen: TAction;
    Wahllisten1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Timer1: TTimer;
    procedure ac_infoExecute(Sender: TObject);
    procedure ac_wa_planExecute(Sender: TObject);
    procedure ac_wa_berechtigteExecute(Sender: TObject);
    procedure ac_helperExecute(Sender: TObject);
    procedure ac_roomsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    type
      TMenuState = (msInit = 0);
  private
    procedure setMenuState( state : TMenuState );
    procedure setPanelText( section : integer; text : string );

    function OpenOrNew : boolean;
  public

  end;

var
  MainClientForm: TMainClientForm;

implementation

uses
  f_info, f_planungsform, f_waehlerliste, f_wahlhelfer, f_wahlklokalForm,
  VSoft.CommandLine.Options, Vcl.Dialogs, u_ComandOptions, f_connet,
  f_simulation_load;

{$R *.dfm}

procedure TMainClientForm.ac_helperExecute(Sender: TObject);
begin
  TWahlhelferForm.Execute;
end;

procedure TMainClientForm.ac_infoExecute(Sender: TObject);
begin
  TinfoForm.ShowInfo;
end;

procedure TMainClientForm.ac_roomsExecute(Sender: TObject);
begin
  TWahllokalForm.execute;
end;

procedure TMainClientForm.ac_wa_berechtigteExecute(Sender: TObject);
begin
  TWaehlerlisteForm.ExecuteForm;
end;

procedure TMainClientForm.ac_wa_planExecute(Sender: TObject);
begin
  TPlanungsform.Execute;
end;

procedure TMainClientForm.FormCreate(Sender: TObject);
begin
  setMenuState( msInit );
  Timer1.Enabled := true;
end;

function TMainClientForm.OpenOrNew: boolean;
begin
  Result := false;
  if not GM.IsSimulation then
  begin
    if not TConnectForm.Execute then
    begin

    end;
  end
  else
  begin
    Result := TSimulationLoadForm.Execute;
  end;

end;

procedure TMainClientForm.setMenuState(state: TMenuState);
begin
  case state of
    msInit :
      begin
        Wahl1.Enabled := false;
        Wahlbuero1.Enabled := false;
        Briefwahl1.Enabled := false;
        Auszhlung1.Enabled := false;
      end;
  end;
end;

procedure TMainClientForm.setPanelText(section: integer; text: string);
var
  len : integer;
begin
  len := StatusBar1.Canvas.TextWidth(text) + 8;
  StatusBar1.Panels.Items[section].Width := len;
  StatusBar1.Panels.Items[section].Text  := text;
end;

procedure TMainClientForm.Timer1Timer(Sender: TObject);
var
  parseresult : ICommandLineParseResult;
begin

  Timer1.Enabled := false;
  if ParamCount >=1 then
  begin
    parseresult := TOptionsRegistry.Parse;
    if parseresult.HasErrors then
    begin
      ShowMessage(parseresult.ErrorText);
    end
    else
    begin
      GM.HostAddress := THostOptions.Host;
      GM.User        := THostOptions.User;
      GM.Passwort    := THostOptions.PWd;
    end;
  end;

  if OpenOrNew then
  begin
    setPanelText( 0, GM.Host );
    setPanelText( 1, GM.User );
  end
  else
  begin
    setPanelText( 0, 'Offline' );
    setPanelText( 1, '' );
  end;
end;

end.

