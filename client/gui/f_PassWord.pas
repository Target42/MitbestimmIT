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


