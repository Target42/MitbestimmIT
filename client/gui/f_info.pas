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
unit f_info;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  TinfoForm = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Label1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    class procedure ShowInfo;
  end;

var
  infoForm: TinfoForm;

implementation

{$R *.dfm}

uses
  ShellAPI;

procedure TinfoForm.Label1Click(Sender: TObject);
var
  dest : string;
begin
  dest := ( Sender as TLabel).Caption;
  Shellexecute( self.Handle, 'open', PWideChar(dest) , nil, nil, SW_NORMAL);
end;

class procedure TinfoForm.ShowInfo;
begin
  Application.CreateForm(TinfoForm, infoForm);
  infoForm.ShowModal;
  infoForm.Free;
end;

end.
