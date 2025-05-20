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
unit f_simulation_load;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TSimulationLoadForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LV: TListView;
    Panel1: TPanel;
    btnNeueWahl: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure btnNeueWahlClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Scan;
  public
    class function Execute : Boolean;
  end;

var
  SimulationLoadForm: TSimulationLoadForm;

implementation

{$R *.dfm}

uses
  m_glob, system.IOUtils, System.Types, m_res;

{ TSimulationLoadForm }

procedure TSimulationLoadForm.btnNeueWahlClick(Sender: TObject);
begin
  //
end;

class function TSimulationLoadForm.Execute: Boolean;
begin
  Application.CreateForm(TSimulationLoadForm, SimulationLoadForm);
  Result := SimulationLoadForm.ShowModal = mrOk;

  if Result then
  begin

  end;
  SimulationLoadForm.Free;
end;

procedure TSimulationLoadForm.FormCreate(Sender: TObject);
begin
  Scan;
end;

procedure TSimulationLoadForm.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TSimulationLoadForm.Scan;
var
  dirs : TStringDynArray;
  i    : integer;
  fname: string;
  list : TStringList;
  item : TListItem;
begin
  Screen.Cursor := crHourGlass;
  list := TStringList.Create;
  dirs := TDirectory.GetDirectories(GM.SimulationPath);
  for i := low(dirs) to High(dirs) do
  begin
    fname := TPath.Combine(dirs[i], 'info.txt');
    if FileExists(fname) then
    begin
      list.LoadFromFile(fname);
      if list.Count > 0 then
      begin
        item := LV.Items.Add;
        item.Caption := ExtractFileName(dirs[i]);
        item.SubItems.Add(list[0]);
      end;
    end;
  end;
  list.Free;
  SetLength(dirs, 0);

  BaseFrame1.OKBtn.Enabled := LV.Items.Count > 0;

  Screen.Cursor := crDefault;
end;

end.
