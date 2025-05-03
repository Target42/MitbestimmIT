unit fr_PlanStart;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TWahlPlanungStartFrame = class(TFrame)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    btnPwdTest: TBitBtn;
    Image1: TImage;
    procedure btnPwdTestClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure init;
    procedure release;
  end;

implementation

{$R *.dfm}

uses
  m_res, f_PassWord;

{ TWahlPlanungStartFrame }

procedure TWahlPlanungStartFrame.btnPwdTestClick(Sender: TObject);
var
  s : string;
begin
  if (LabeledEdit1.Text = '') or (LabeledEdit1.Text <> LabeledEdit2.text) then
  begin
    ShowMessage('Das Passwort darf nicht leer sein und die beiden Passwörter müssen übereinstimmen.');
    exit;
  end;

  if TPasswordDlg.getPwd( s ) then
  begin
    if s = LabeledEdit1.Text then
      ShowMessage('Test erfolgreich!')
    else
      ShowMessage('Test NICHT erfolgreich!')

  end;
end;

procedure TWahlPlanungStartFrame.init;
begin

end;

procedure TWahlPlanungStartFrame.release;
begin

end;

end.
