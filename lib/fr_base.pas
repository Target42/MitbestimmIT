unit fr_base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TBaseFrame = class(TFrame)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    CancelBtn: TBitBtn;
    OKBtn: TBitBtn;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

end.
