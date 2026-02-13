unit f_auswertung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Buttons;

type
  TAuswertungForm = class(TForm)
    StatusBar1: TStatusBar;
    DSProviderConnection1: TDSProviderConnection;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    TabSheet5: TTabSheet;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    procedure checkBtn;
  public
    class procedure Execute;
  end;

var
  AuswertungForm: TAuswertungForm;

implementation

{$R *.dfm}

uses m_glob, u_BRWahlFristen;

{ TAuswertungForm }

procedure TAuswertungForm.BitBtn1Click(Sender: TObject);
var
  s : string;
begin
  s := 'Achtung ' + sLineBreak+
       'Die Auswertung sollte erst gestartet werden, wenn alle Briefwahlunterlagen in der Urne sind.'+sLineBreak+
       'Der Beginn der Auswertung deaktiviert die Möglichkeit weitere Stimmzettel anzunehmen.';

  if not MessageDlg(s,  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    exit;

  GM.setPhase(bwu, false);
  checkBtn;

end;

procedure TAuswertungForm.BitBtn2Click(Sender: TObject);
begin
  if GM.isPhaseActive(SAZ) then
  begin
    MessageDlg('Die Auszählung ist schon aktiv',  mtInformation, [mbOK], 0);
  end;
  GM.setPhase(bwu, true);
  checkBtn;
end;

procedure TAuswertungForm.BitBtn3Click(Sender: TObject);
begin
  if not GM.isPhaseActive(BWU) then
  begin
    MessageDlg('Diese Phase ist gerade nicht aktiv',  mtInformation, [mbOK], 0);
    exit;
  end;
  GM.setPhase(bwu, false);
  checkBtn;
end;

procedure TAuswertungForm.checkBtn;
var
  saz, bwu : boolean;
begin
  saz := GM.isPhaseActive(u_BRWahlFristen.SAZ);
  bwu := GM.isPhaseActive(u_BRWahlFristen.BWU);

  BitBtn2.Enabled := ( not saz ) and ( not bwu);
  BitBtn3.Enabled := ( not saz ) and bwu;

  BitBtn1.Enabled := ( not bwu) and ( not saz );
  BitBtn4.Enabled := ( not bwu) and saz;

end;

class procedure TAuswertungForm.Execute;
begin
  Application.CreateForm(TAuswertungForm, AuswertungForm);
  AuswertungForm.ShowModal;
  AuswertungForm.free;
end;

procedure TAuswertungForm.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet5;

  BitBtn1.Enabled := false;
  BitBtn2.Enabled := false;
  // BWU
  BitBtn3.Enabled := false;
  BitBtn4.Enabled := false;

  checkBtn;
end;

end.
