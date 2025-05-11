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
    Wahlbro1: TMenuItem;
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
  public

  end;

var
  MainClientForm: TMainClientForm;

implementation

uses
  f_info, f_planungsform, f_waehlerliste, f_wahlhelfer, f_wahlklokalForm,
  VSoft.CommandLine.Options, Vcl.Dialogs, u_ComandOptions, f_connet;

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
  Timer1.Enabled := true;
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
    end;
  end;

  if not TConnectForm.Execute then
    self.Close;
end;

end.
