unit f_wahlliste_name;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  fr_base, u_wahlliste;

type
  TWahllistenNameForm = class(TForm)
    Panel1: TPanel;
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_liste : TWahlliste;
    procedure setWahlliste( value : TWahlliste );
  public
    class function exec( var wl : TWahlliste ) : boolean;
    property Wahlliste : TWahlliste read m_liste write setWahlliste;
  end;

var
  WahllistenNameForm: TWahllistenNameForm;

implementation

{$R *.dfm}

{ TWahllistenNameForm }

procedure TWahllistenNameForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_liste.Name := trim(LabeledEdit1.Text);
  m_liste.Kurz := trim(LabeledEdit2.Text);
end;

class function TWahllistenNameForm.exec(var wl: TWahlliste): boolean;
begin
  Application.CreateForm(TWahllistenNameForm, WahllistenNameForm);
  WahllistenNameForm.Wahlliste := wl;
  result := WahllistenNameForm.ShowModal = mrOk;
  if Result then
    wl := WahllistenNameForm.Wahlliste;

  WahllistenNameForm.Free;
end;

procedure TWahllistenNameForm.setWahlliste(value: TWahlliste);
begin
  m_liste  := value;

  LabeledEdit1.Text := m_liste.Name;
  LabeledEdit2.Text := m_liste.Kurz;
end;

end.
