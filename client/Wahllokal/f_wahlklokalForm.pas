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
