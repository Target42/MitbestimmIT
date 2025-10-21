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
unit f_wahllokalRaum;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, fr_base, u_wahllokal, u_stub;

type
  TWahllokalRaumform = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    BaseFrame1: TBaseFrame;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    FEditMode: boolean;
    FRaumID : integer;
    function GetRaumID: integer;
    procedure SetRaumID(const Value: integer);
  public
    property EditMode: boolean read FEditMode write FEditMode;
    property RaumID: integer read GetRaumID write SetRaumID;

    class function edit(id : integer ) : Boolean;
    class function add : boolean;
  end;

var
  WahllokalRaumform: TWahllokalRaumform;

implementation

{$R *.dfm}

uses m_glob, System.JSON, u_json;


{ TWahllokalRaumform }

class function TWahllokalRaumform.add: boolean;
begin
  Application.CreateForm(TWahllokalRaumform, WahllokalRaumform);
  WahllokalRaumform.EditMode := false;
  Result := WahllokalRaumform.ShowModal = mrOk;
  WahllokalRaumform.Free;
end;

procedure TWahllokalRaumform.BaseFrame1OKBtnClick(Sender: TObject);
var
  lokal : TWahlLokal;
  client: TLokaleModClient;
  res   : TJSONObject;
begin
  lokal := TWahlLokal.create;
  lokal.ID        := FRaumID;
  lokal.Building  := LabeledEdit1.Text;
  lokal.Raum      := LabeledEdit2.Text;
  lokal.Stockwerk := LabeledEdit3.Text;
  lokal.Von       := DateTimePicker1.DateTime;
  lokal.Bis       := DateTimePicker2.DateTime;

  client := TLokaleModClient.Create(GM.SQLConnection1.DBXConnection);

  if not FEditMode then
    res := client.add(lokal.toJSON)
  else
    res := client.save(lokal.toJSON);

  ShowMessage(JString(res, 'text'));

  lokal.Free;
  client.Free;
end;

class function TWahllokalRaumform.edit(id : integer ): Boolean;
begin
  Application.CreateForm(TWahllokalRaumform, WahllokalRaumform);

  WahllokalRaumform.EditMode := true;
  WahllokalRaumform.RaumID   := id;
  Result                     := WahllokalRaumform.ShowModal = mrOk;

  WahllokalRaumform.Free;
end;

procedure TWahllokalRaumform.FormCreate(Sender: TObject);
begin
  FRaumID := 0;
end;

function TWahllokalRaumform.GetRaumID: integer;
begin
  Result := FRaumID;
end;

procedure TWahllokalRaumform.SetRaumID(const Value: integer);
var
  lokal : TWahlLokal;
  client: TLokaleModClient;
  res : TJSONObject;
begin
  FRaumID := value;

  client := TLokaleModClient.Create(GM.SQLConnection1.DBXConnection);

  res := client.get(FRaumID);

  if Assigned(res) then
  begin
    lokal := TWahlLokal.create;
    lokal.fromJSON(res);
    LabeledEdit1.Text := lokal.Building;
    LabeledEdit2.Text  := lokal.Raum;
    LabeledEdit3.Text := lokal.Stockwerk;
    DateTimePicker1.DateTime  := lokal.Von;
    DateTimePicker2.DateTime  := lokal.Bis;
    lokal.Free;
  end;

  client.Free;
end;

end.
