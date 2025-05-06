unit f_wahlhelfer_person;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  fr_base, u_Wahlhelfer;

type
  TWahlhelferPersonForm = class(TForm)
    LabeledEdit1: TLabeledEdit;
    ComboBox1: TComboBox;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    BaseFrame1: TBaseFrame;
    Label1: TLabel;
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_person : TWahlhelfer;
    function GetPerson: TWahlhelfer;
    procedure SetPerson(const Value: TWahlhelfer);
  public
    property Person: TWahlhelfer read GetPerson write SetPerson;
  end;

var
  WahlhelferPersonForm: TWahlhelferPersonForm;

implementation

{$R *.dfm}

{ TWahlhelferPersonForm }

procedure TWahlhelferPersonForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_person.Personamnummer := LabeledEdit1.Text;
  m_person.Name           := LabeledEdit2.Text;
  m_person.Vorname        := LabeledEdit3.Text;
  m_person.Abteilung      := LabeledEdit4.Text;

  m_person.Geschlecht     := ComboBox1.Text;
end;

function TWahlhelferPersonForm.GetPerson: TWahlhelfer;
begin
  Result := m_person;
end;

procedure TWahlhelferPersonForm.SetPerson(const Value: TWahlhelfer);
begin
  m_person := Value;

  LabeledEdit1.Text := m_person.Personamnummer;
  LabeledEdit2.Text := m_person.Name;
  LabeledEdit3.Text := m_person.Vorname;
  LabeledEdit4.Text := m_person.Abteilung;

  ComboBox1.Text    := m_person.Geschlecht;
end;

end.
