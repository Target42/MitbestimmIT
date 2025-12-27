unit f_auswertung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect;

type
  TAuswertungForm = class(TForm)
    GroupBox1: TGroupBox;
    StatusBar1: TStatusBar;
    DSProviderConnection1: TDSProviderConnection;
  private
    { Private-Deklarationen }
  public
    class procedure Execute;
  end;

var
  AuswertungForm: TAuswertungForm;

implementation

{$R *.dfm}

uses m_glob, u_BRWahlFristen;

{ TAuswertungForm }

class procedure TAuswertungForm.Execute;
begin
  if not GM.isPhaseActive(SAZ) then
  begin
    ShowMessage('Die Briefwahl ist nicht aktiv.');
    exit;
  end;
  Application.CreateForm(TAuswertungForm, AuswertungForm);
  AuswertungForm.ShowModal;
  AuswertungForm.free;
end;

end.
