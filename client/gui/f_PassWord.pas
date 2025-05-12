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
unit f_PassWord;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
  private
    { Private-Deklarationen }
  public
    class function getPwd( var pwd : string ) : Boolean;
  end;

var
  PasswordDlg: TPasswordDlg;

implementation

{$R *.dfm}

{ TPasswordDlg }

class function TPasswordDlg.getPwd(var pwd: string): Boolean;
begin
  Application.CreateForm(TPasswordDlg, PasswordDlg);
  Result := PasswordDlg.ShowModal = mrOk;
  if Result then
    pwd := PasswordDlg.Password.Text;
  PasswordDlg.Free;
end;

end.


