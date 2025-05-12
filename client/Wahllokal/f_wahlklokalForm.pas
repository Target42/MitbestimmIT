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
unit f_wahlklokalForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  m_res, fr_base, Vcl.Buttons;

type
  TWahllokalForm = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    RaumView: TListView;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    GroupBox2: TGroupBox;
    BaseFrame1: TBaseFrame;
    Splitter1: TSplitter;
    ListView1: TListView;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
  private
    { Private-Deklarationen }
  public
    class procedure execute;
  end;

var
  WahllokalForm: TWahllokalForm;

implementation

{$R *.dfm}

{ TWahllokalForm }

class procedure TWahllokalForm.execute;
begin
  Application.CreateForm(TWahllokalForm, WahllokalForm);
  WahllokalForm.ShowModal;
  WahllokalForm.Free;
end;

end.
