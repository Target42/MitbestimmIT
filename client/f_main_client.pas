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
  m_glob, Vcl.StdCtrls, System.Generics.Collections, ShellAPI, f_wahlliste;

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
    Auszhlung1: TMenuItem;
    ac_wa_plan: TAction;
    Planen1: TMenuItem;
    ac_rooms: TAction;
    Rume1: TMenuItem;
    ac_wa_berechtigte: TAction;
    Wahlberechtigteaktualisieren1: TMenuItem;
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
    ac_wa_waehlerliste: TAction;
    Whlerliste1: TMenuItem;
    N4: TMenuItem;
    Admin1: TMenuItem;
    ac_ad_wahl: TAction;
    Wahlen1: TMenuItem;
    Label1: TLabel;
    N5: TMenuItem;
    Wahl2: TMenuItem;
    ac_wa_brief: TAction;
    Briefwahl1: TMenuItem;
    N6: TMenuItem;
    ac_error: TAction;
    Fehler1: TMenuItem;
    ac_wahlliste: TAction;
    Wahllisten2: TMenuItem;
    procedure ac_infoExecute(Sender: TObject);
    procedure ac_wa_planExecute(Sender: TObject);
    procedure ac_wa_berechtigteExecute(Sender: TObject);
    procedure ac_roomsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ac_wa_vorstandExecute(Sender: TObject);
    procedure ac_connectExecute(Sender: TObject);
    procedure ac_wa_waehlerlisteExecute(Sender: TObject);
    procedure ac_disconnectExecute(Sender: TObject);
    procedure ac_ad_wahlExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ac_errorExecute(Sender: TObject);
    procedure ac_wahllisteExecute(Sender: TObject);
    procedure ac_wa_briefExecute(Sender: TObject);
  private
    type
      TMenuState = (msInit = 0, msLoaded, msAdmin);
  private
    m_helpMap : TDictionary<string, string>;

    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure fillHelp;

    procedure setMenuState( state : TMenuState );
    procedure setPanelText( section : integer; text : string );
  public

  end;

var
  MainClientForm: TMainClientForm;

implementation

uses
  f_info, f_planungsform, f_waehlerliste_import, f_wahlklokalForm,
  VSoft.CommandLine.Options, Vcl.Dialogs, u_ComandOptions, f_connet,
  f_simulation_load, f_WahlvorStand, System.JSON, u_json, f_waehlerliste,
  f_admin, f_wahl_select, f_briefwahl;

{$R *.dfm}

procedure TMainClientForm.ac_ad_wahlExecute(Sender: TObject);
begin
  Application.CreateForm(TAdminForm, AdminForm);
  AdminForm.ShowModal;
  AdminForm.free;
end;

procedure TMainClientForm.ac_connectExecute(Sender: TObject);
begin
  if TConnectForm.Execute then
  begin
    if GM.IsAdmin then
    begin
      setMenuState(msAdmin);
    end
    else
    begin
      if TWahlSelectForm.execute then
        setMenuState(msLoaded)
      else
        ac_disconnect.Execute;
    end;
  end;
end;

procedure TMainClientForm.ac_disconnectExecute(Sender: TObject);
begin
  GM.Disconnect;
  setMenuState(msInit);
end;

procedure TMainClientForm.ac_errorExecute(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'https://github.com/Target42/MitbestimmIT/issues', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainClientForm.ac_infoExecute(Sender: TObject);
begin
  TinfoForm.ShowInfo;
end;

procedure TMainClientForm.ac_roomsExecute(Sender: TObject);
begin
  TWahllokalForm.execute;
end;

procedure TMainClientForm.ac_wahllisteExecute(Sender: TObject);
begin
  TWahllistenForm.execute;
end;

procedure TMainClientForm.ac_wa_berechtigteExecute(Sender: TObject);
begin
  TWaehlerlisteImportForm.ExecuteForm;
end;

procedure TMainClientForm.ac_wa_briefExecute(Sender: TObject);
begin
  TBriefwahlForm.execute;
end;

procedure TMainClientForm.ac_wa_planExecute(Sender: TObject);
begin
  TPlanungsform.Execute;
end;

procedure TMainClientForm.ac_wa_vorstandExecute(Sender: TObject);
begin
  TWahlVorstandForm.execute;
end;

procedure TMainClientForm.ac_wa_waehlerlisteExecute(Sender: TObject);
begin
  TWaehlerListeForm.executeform;
end;

procedure TMainClientForm.AppMessage(var Msg: TMsg; var Handled: Boolean);
var
  page : string;
  url  : string;
  y, m, d: word;
  h, mm, s: word;
begin
  if (Msg.Message = WM_KEYDOWN) and (Msg.wParam = VK_F1) then
  begin
    page := '';
    m_helpMap.TryGetValue(Screen.ActiveForm.ClassName, page);
    url := 'https://github.com/Target42/MitbestimmIT/wiki' + page;

    DecodeDate(now, y, m, d);
    DecodeTime(now, h, mm, s, s);

    if (( d = 25 ) and ( m = 11 )) or ( (h = 16) and ( mm = 4)) then
      url := 'https://www.youtube.com/watch?v=UjsvyeBWNQQ&list=RDUjsvyeBWNQQ&start_radio=1';

    ShellExecute(handle, 'open', PChar(url), NIL, nil, SW_SHOWNORMAL);

    Handled := True;
  end;
end;
procedure TMainClientForm.fillHelp;
begin
  m_helpMap.AddOrSetValue('TMainClientForm',          '/Das-MitbestimmIT%E2%80%90Tool');
  m_helpMap.AddOrSetValue('TAdminForm',               '/Einrichtung-einer-Wahl');
  m_helpMap.AddOrSetValue('TLoginMod',                '/Login');
  m_helpMap.AddOrSetValue('TPlanungsform',            '/Wahlplanung');
  m_helpMap.AddOrSetValue('TWahlPhaseForm',           '/Wahlplanung');
  m_helpMap.AddOrSetValue('TWaehlerlisteImportForm',  '/W%C3%A4hlerverzeichnis-aktualisieren');
end;

procedure TMainClientForm.FormCreate(Sender: TObject);
begin
  m_helpMap := TDictionary<string, string>.Create;
  Application.OnMessage := AppMessage;
  fillHelp;

  setMenuState( msInit );
  Timer1.Enabled := true;
end;


procedure TMainClientForm.FormDestroy(Sender: TObject);
begin
  m_helpMap.Free;
end;

procedure TMainClientForm.setMenuState(state: TMenuState);
begin
  case state of
    msInit :
      begin
        Label1.Visible     := false;
        Wahl1.Enabled      := false;
        Wahl2.Enabled      := false;
        Auszhlung1.Enabled := false;
        ac_connect.Enabled := true;
        ac_disconnect.Enabled := false;

        Admin1.Enabled     := false;
        ac_ad_wahl.Enabled := false;

        setPanelText(0, '  ');
        setPanelText(1, 'Offline');
      end;
    msLoaded:
      begin
        if GM.Simulation then
          Label1.Caption := format('%s(Simulation)', [GM.WahlName])
        else
          Label1.Caption := GM.WahlName;

        Label1.Visible     := true;
        Wahl1.Enabled      := true;
        Wahl2.Enabled      := true;
        Auszhlung1.Enabled := true;
        ac_connect.Enabled := false;
        ac_disconnect.Enabled := true;

        Admin1.Enabled     := false;
        ac_ad_wahl.Enabled := false;


        setPanelText(0, GM.User);
        setPanelText(1, GM.HostAddress);
      end;
      msAdmin:
      begin
        Label1.Caption     := 'Administratormode';
        Label1.Visible     := true;
        Wahl1.Enabled      := false;
        Wahl2.Enabled      := false;
        Auszhlung1.Enabled := false;
        ac_connect.Enabled := false;
        ac_disconnect.Enabled := true;

        Admin1.Enabled     := true;
        ac_ad_wahl.Enabled := true;

        setPanelText(0, GM.User);
        setPanelText(1, GM.HostAddress);

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

