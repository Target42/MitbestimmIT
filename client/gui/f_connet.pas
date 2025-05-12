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

unit f_connet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  fr_base, m_glob;

type
  TConnectForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    CheckBox1: TCheckBox;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
  private
    function GetHost: string;
    procedure SetHost(const Value: string);
    function GetUser: string;
    procedure SetUser(const Value: string);
    function GetPasswort: string;
    procedure SetPasswort(const Value: string);
    { Private-Deklarationen }
  public
    class function Execute : Boolean;

    property Host: string read GetHost write SetHost;
    property User: string read GetUser write SetUser;
    property Passwort: string read GetPasswort write SetPasswort;
  end;

var
  ConnectForm: TConnectForm;

implementation

{$R *.dfm}

{ TConnectForm }

class function TConnectForm.Execute: Boolean;
var
  counter : integer;
begin
  Application.CreateForm(TConnectForm, ConnectForm);
  ConnectForm.Host := GM.HostAddress;
  ConnectForm.User := GM.User;
  ConnectForm.Passwort := GM.Passwort;

  counter := 3;
  while counter > 0 do
  begin

    if ConnectForm.ShowModal = mrOk then
    begin
      GM.HostAddress := ConnectForm.Host;
      GM.user := ConnectForm.User;
      GM.Passwort  := ConnectForm.Passwort;

      if GM.connect then
        break;
    end;
    dec( Counter );
  end;

  Result := GM.isConnected;

  ConnectForm.Free;
end;

function TConnectForm.GetHost: string;
begin
  if CheckBox1.Checked then
    Result := 'simulation'
  else
    Result := trim( LabeledEdit1.Text);

end;

function TConnectForm.GetPasswort: string;
begin
  Result := LabeledEdit3.Text;
end;

function TConnectForm.GetUser: string;
begin
  Result := LabeledEdit2.Text;
end;

procedure TConnectForm.SetHost(const Value: string);
begin
  LabeledEdit1.Text := '';
  CheckBox1.Checked := SameText('simulation', value );

  if not CheckBox1.Checked then
    LabeledEdit1.Text := value;

end;

procedure TConnectForm.SetPasswort(const Value: string);
begin
  LabeledEdit3.Text := value;
end;

procedure TConnectForm.SetUser(const Value: string);
begin
  LabeledEdit2.Text := value;
end;

end.
