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
  Vcl.Buttons, Vcl.ExtCtrls, System.JSON;

type
  TSimulationLoadForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LV: TListView;
    Panel1: TPanel;
    btnNeueWahl: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure btnNeueWahlClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LVClick(Sender: TObject);
  private
    m_newProject : boolean;
  public
    class function Execute( data : TJSONObject ) : TJSONObject;

    procedure fromJSON( data : TJSONObject );
    function getData : TJSONObject;
  end;

var
  SimulationLoadForm: TSimulationLoadForm;

implementation

{$R *.dfm}

uses
  m_glob, system.IOUtils, System.Types, m_res, u_json;

{ TSimulationLoadForm }

procedure TSimulationLoadForm.btnNeueWahlClick(Sender: TObject);
begin
  m_newProject := true;
  LV.Selected := NIL;
  BaseFrame1.OKBtn.Click;
end;

class function TSimulationLoadForm.Execute( data : TJSONObject ) : TJSONObject;
begin
  Result := NIL;
  Application.CreateForm(TSimulationLoadForm, SimulationLoadForm);
  SimulationLoadForm.fromJSON(data);

  if (SimulationLoadForm.ShowModal = mrOk) then
  begin
    Result := SimulationLoadForm.getData;
  end;
  SimulationLoadForm.Free;
end;

procedure TSimulationLoadForm.FormCreate(Sender: TObject);
begin
  m_newProject := false;
end;

procedure TSimulationLoadForm.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TSimulationLoadForm.fromJSON(data: TJSONObject);
var
  iter : TArrayIterator;
  item : TListItem;
begin
  LV.Items.Clear;
  iter := TArrayIterator.Create(JArray(data, 'items'));
  while iter.Next do
  begin
    item := LV.Items.Add;
    item.Caption := JString( iter.CurrentItem, 'kurz');
    item.SubItems.Add(JString( iter.CurrentItem, 'name'));
    item.SubItems.Add(JString( iter.CurrentItem, 'id'));
  end;
  iter.Free;
end;


function TSimulationLoadForm.getData: TJSONObject;
begin
  Result := NIL;
  if not m_newProject then
  begin
    if Assigned(LV.Selected) then
    begin
      Result := TJSONObject.Create;
      JReplace( Result, 'load', true);
      JReplace( Result, 'kurz', LV.Selected.Caption);
      JReplace( Result, 'name', Lv.Selected.SubItems[0]);
      JReplace( Result, 'id', Lv.Selected.SubItems[1]);
    end;
  end
  else
  begin
    Result := TJSONObject.Create;
    JReplace( Result, 'new', true);
  end;
end;

procedure TSimulationLoadForm.LVClick(Sender: TObject);
begin
  if BaseFrame1.OKBtn.Enabled then
    BaseFrame1.OKBtn.Click;
end;

end.
