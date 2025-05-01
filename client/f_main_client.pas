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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, System.Actions,
  Vcl.StdActns, Vcl.Menus, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

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
    procedure ac_infoExecute(Sender: TObject);
    procedure ac_wa_planExecute(Sender: TObject);
  private
  public

  end;

var
  MainClientForm: TMainClientForm;

implementation

uses
  f_info, f_planungsform;

{$R *.dfm}

procedure TMainClientForm.ac_infoExecute(Sender: TObject);
begin
  TinfoForm.ShowInfo;
end;

procedure TMainClientForm.ac_wa_planExecute(Sender: TObject);
begin
  TPlanungsform.Execute;
end;

end.
