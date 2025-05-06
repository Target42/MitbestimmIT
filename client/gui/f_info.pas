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
