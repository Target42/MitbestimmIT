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
unit f_WahlVorstandPerson;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  fr_base, u_Wahlvorstand;

type
  TWahlVorstandPersonForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label2: TLabel;
    LabeledEdit5: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_person : IWahlvorstandPerson;
    function GetPerson: IWahlvorstandPerson;
    procedure SetPerson(const Value: IWahlvorstandPerson);
    procedure Updateview;
  public
    property Person: IWahlvorstandPerson read GetPerson write SetPerson;
  end;

var
  WahlVorstandPersonForm: TWahlVorstandPersonForm;

implementation

{$R *.dfm}

{ TWahlVorstandPersonForm }

procedure TWahlVorstandPersonForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  // übernehmen der Werte !
  m_person.Login  := LabeledEdit1.Text;
  m_person.Name   := LabeledEdit2.Text;
  m_person.Vorname:= LabeledEdit3.Text;
  m_person.eMail  := LabeledEdit4.Text;
  m_person.Login  := LabeledEdit5.Text;

  m_person.Stimmberechtigt := CheckBox1.Checked;
  m_person.Anrede := ComboBox2.Items[ComboBox2.ItemIndex];
  m_person.Rolle  := StringToTWahlvorstandsRolle( ComboBox1.Items[ComboBox1.ItemIndex]);
end;

procedure TWahlVorstandPersonForm.FormCreate(Sender: TObject);
begin
  ComboBox1.Items.Clear;
  TWahlvorstandsRolleToList( ComboBox1.Items );
end;

function TWahlVorstandPersonForm.GetPerson: IWahlvorstandPerson;
begin
  result := m_person;
end;

procedure TWahlVorstandPersonForm.SetPerson(const Value: IWahlvorstandPerson);
begin
  m_person := value;
  Updateview;
end;

procedure TWahlVorstandPersonForm.Updateview;
begin
  if not Assigned(m_person) then
    exit;

  LabeledEdit1.Text := m_person.Login;
  LabeledEdit2.Text := m_person.Name;
  LabeledEdit3.Text := m_person.Vorname;
  LabeledEdit4.Text := m_person.eMail;
  LabeledEdit5.Text := m_person.Login;
  CheckBox1.Checked := m_person.Stimmberechtigt;
  ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(m_person.Anrede);
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(TWahlvorstandsRolleToString(m_person.Rolle));
end;

end.
