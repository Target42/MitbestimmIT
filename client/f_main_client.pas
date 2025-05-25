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
    ac_wa_vorstand: TAction;
    Wahlvorstand1: TMenuItem;
    ac_connect: TAction;
    ac_disconnect: TAction;
    Verbinden1: TMenuItem;
    rennen1: TMenuItem;
    N3: TMenuItem;
    procedure ac_infoExecute(Sender: TObject);
    procedure ac_wa_planExecute(Sender: TObject);
    procedure ac_wa_berechtigteExecute(Sender: TObject);
    procedure ac_helperExecute(Sender: TObject);
    procedure ac_roomsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ac_wa_vorstandExecute(Sender: TObject);
    procedure ac_connectExecute(Sender: TObject);
  private
    type
      TMenuState = (msInit = 0, msLoaded);
  private
    procedure setMenuState( state : TMenuState );
    procedure setPanelText( section : integer; text : string );
  public

  end;

var
  MainClientForm: TMainClientForm;

implementation

uses
  f_info, f_planungsform, f_waehlerliste, f_wahlhelfer, f_wahlklokalForm,
  VSoft.CommandLine.Options, Vcl.Dialogs, u_ComandOptions, f_connet,
  f_simulation_load, f_WahlvorStand, System.JSON, u_json;

{$R *.dfm}

procedure TMainClientForm.ac_connectExecute(Sender: TObject);
var
  data : TJSONObject;
begin
  if TConnectForm.Execute then
  begin
    data := Gm.Storage.select;
    if Assigned(data) then
    begin
      if JBool( data, 'new') then
      begin
        if GM.Storage.new then
        begin
          ac_wa_plan.Execute;
          setMenuState( msLoaded );
        end;
      end
      else
      begin
        if GM.Storage.load(data) then
          setMenuState( msLoaded );
      end;
      data.Free;
    end;
  end;
end;

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

procedure TMainClientForm.ac_wa_vorstandExecute(Sender: TObject);
begin
  TWahlVorstandForm.execute;
end;

procedure TMainClientForm.FormCreate(Sender: TObject);
begin
  setMenuState( msInit );
  Timer1.Enabled := true;
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
        ac_connect.Enabled := true;
        ac_disconnect.Enabled := false;
      end;
    msLoaded:
      begin
        Wahl1.Enabled      := true;
        Wahlbuero1.Enabled := true;
        Briefwahl1.Enabled := true;
        Auszhlung1.Enabled := true;
        ac_connect.Enabled := false;
        ac_disconnect.Enabled := true;
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

  ac_connect.Execute;
end;

end.

