unit fr_wahlverfahren;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  JvExStdCtrls, JvHtControls, Vcl.ComCtrls, u_BRWahlFristen;

type
  TWahlverfahrenFrame = class(TFrame)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    m_fristen  : PTWahlFristen;
  public
    procedure init( ptr : PTWahlFristen);
    procedure release;
  end;

implementation

{$R *.dfm}

{ TWahlverfahrenFrame }

procedure TWahlverfahrenFrame.init(ptr: PTWahlFristen);
begin
  m_fristen := ptr;
  RadioButton1.Checked := m_fristen^.Verfahren = wvVereinfacht;
  RadioButton2.Checked := m_fristen^.Verfahren = wvAllgemein;
end;

procedure TWahlverfahrenFrame.RadioButton1Click(Sender: TObject);
begin
  m_fristen^.Verfahren := wvVereinfacht;
end;

procedure TWahlverfahrenFrame.RadioButton2Click(Sender: TObject);
begin
  m_fristen^.Verfahren := wvVereinfacht;
end;

procedure TWahlverfahrenFrame.release;
begin

end;

end.
