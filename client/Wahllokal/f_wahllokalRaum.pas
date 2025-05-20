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
  Vcl.ExtCtrls, fr_base, u_wahllokal;

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
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    FRaum: TWahlLokal;
    procedure setRaum( value : TWahlLokal );
  public
    property Raum: TWahlLokal read FRaum write setRaum;

    class function edit( lokal : TWahlLokal ) : Boolean;
    class function add : TWahlLokal;
  end;

var
  WahllokalRaumform: TWahllokalRaumform;

implementation

{$R *.dfm}

{ TWahllokalRaumform }

class function TWahllokalRaumform.add: TWahlLokal;
begin
  Result := TWahlLokal.create;

  Application.CreateForm(TWahllokalRaumform, WahllokalRaumform);
  WahllokalRaumform.Raum := Result;
  if WahllokalRaumform.ShowModal <> mrOk then
    FreeAndNil(Result);
  WahllokalRaumform.Free;
end;

procedure TWahllokalRaumform.BaseFrame1OKBtnClick(Sender: TObject);
begin
  FRaum.Building  := LabeledEdit1.Text;
  FRaum.Raum      := LabeledEdit2.Text;
  FRaum.Stockwerk := LabeledEdit3.Text;

  FRaum.Von := DateTimePicker1.DateTime;
  FRaum.bis := DateTimePicker2.DateTime;

end;

class function TWahllokalRaumform.edit(lokal: TWahlLokal): Boolean;
begin
  Application.CreateForm(TWahllokalRaumform, WahllokalRaumform);
  WahllokalRaumform.Raum := lokal;
  Result := WahllokalRaumform.ShowModal = mrOk;
  WahllokalRaumform.Free;
end;

procedure TWahllokalRaumform.setRaum(value: TWahlLokal);
begin
  FRaum := value;
  LabeledEdit1.Text := FRaum.Building;
  LabeledEdit2.Text := FRaum.Raum;
  LabeledEdit3.Text := FRaum.Stockwerk;

  DateTimePicker1.DateTime := FRaum.Von;
  DateTimePicker2.DateTime := FRaum.bis;
end;

end.
