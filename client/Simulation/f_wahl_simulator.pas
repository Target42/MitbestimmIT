unit f_wahl_simulator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TWahlsimulatorForm = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ScrollBar1: TScrollBar;
    Label4: TLabel;
    labWahlBeteidigung: TLabel;
    Label5: TLabel;
    ScrollBar2: TScrollBar;
    labBrief: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ScrollBar3: TScrollBar;
    Label8: TLabel;
    Label9: TLabel;
    ScrollBar4: TScrollBar;
    Label10: TLabel;
    Label11: TLabel;
    ScrollBar5: TScrollBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label12: TLabel;
    Gremium: TLabel;
    Label13: TLabel;
    Freistellungen: TLabel;
    Label14: TLabel;
    Minderheit: TLabel;
    Label15: TLabel;
    MinderheitnSitze: TLabel;
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure ScrollBar5Change(Sender: TObject);
  private
    m_anzahl      : integer;
    m_male        : integer;
    m_female      : integer;
    m_beteidigung : double;
    m_brief       : integer;
    m_doppel      : integer;
    m_inv_urne    : integer;
    m_inv_brief   : integer;

    procedure rechne;
    procedure UpdateView;
    procedure setBar( sc : TScrollBar; max : integer );
    function perc( sc : TScrollBar ) : integer;

    procedure UpdateData;
  public
    class procedure execute;
  end;

var
  WahlsimulatorForm: TWahlsimulatorForm;

implementation

uses
  u_stub, System.JSON, m_glob, u_json;

{$R *.dfm}

{ TWahlsimulatorForm }

class procedure TWahlsimulatorForm.execute;
begin
  Application.CreateForm(TWahlsimulatorForm, WahlsimulatorForm);
  WahlsimulatorForm.ShowModal;
  WahlsimulatorForm.Free;
end;

procedure TWahlsimulatorForm.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;
  m_anzahl := 0;
  m_male   := 0;
  m_female := 0;
  UpdateData;
  UpdateView;
end;

function TWahlsimulatorForm.perc(sc: TScrollBar): integer;
begin
  if sc.Position = 0 then
    result := 0
  else
    result := trunc(100.0* sc.Position / sc.Max);
end;

procedure TWahlsimulatorForm.rechne;
var
  pers : integer;
begin
  m_beteidigung := (1.0 * ScrollBar1.Position) / 100.0;

  pers       := trunc( m_anzahl * m_beteidigung);

  setBar(ScrollBar2, pers);
  setBar(ScrollBar3, pers);
  setBar(ScrollBar4, pers);
  setBar(ScrollBar5, pers);
end;

procedure TWahlsimulatorForm.ScrollBar1Change(Sender: TObject);
begin

  labWahlBeteidigung.Caption := Format('%d %% (%d Personen)',
  [
    ScrollBar1.Position,
    trunc ( 1.0 * m_anzahl * ( ScrollBar1.Position / 100.0))
  ]);
  setBar(ScrollBar4, ScrollBar1.Position);
  rechne;
end;

procedure TWahlsimulatorForm.ScrollBar2Change(Sender: TObject);
begin
  m_brief := ScrollBar2.Position;
  labBrief.Caption := Format('%d (%d %%)', [m_brief, perc(Sender as TScrollBar)]);

  setBar(ScrollBar3, m_brief);
  setBar(ScrollBar5, ScrollBar2.Position);
end;

procedure TWahlsimulatorForm.ScrollBar3Change(Sender: TObject);
begin
  m_doppel := ScrollBar3.Position;
  Label7.Caption := Format('%d (%d %%)', [m_doppel, perc(Sender as TScrollBar)]);
end;

procedure TWahlsimulatorForm.ScrollBar4Change(Sender: TObject);
begin
  m_inv_urne := ScrollBar4.Position;
  Label9.Caption := Format('%d (%d %%)', [m_inv_urne, perc(Sender as TScrollBar)]);
end;

procedure TWahlsimulatorForm.ScrollBar5Change(Sender: TObject);
begin
  m_inv_brief := ScrollBar5.Position;
  Label11.Caption := Format('%d (%d %%)',
  [
    m_inv_brief,
    perc(Sender as TScrollBar)
  ]);
end;

procedure TWahlsimulatorForm.setBar(sc: TScrollBar; max: integer);
begin
  if sc.Position > max then
    sc.Position := max;
  sc.Max := max;

  if Assigned(Sc.OnChange) then
    sc.OnChange(sc);

end;

procedure TWahlsimulatorForm.UpdateData;
var
  client : TStadModClient;
  data   : TJSONObject;
  obj    :TJSONObject;
begin
  client := TStadModClient.Create(GM.SQLConnection1.DBXConnection);
  data   := client.getStats;

  if Assigned(data) then
  begin
    obj := JObject(data, 'ma');
    if Assigned(obj) then
    begin
      m_anzahl := JInt(obj, 'summe');
      m_female := JInt(obj, 'w');
      m_male   := JInt(obj, 'm');

      Gremium.Caption := IntToStr(JInt( obj, 'gremium' ));
      Freistellungen.Caption := IntToStr(JInt( obj, 'freistellungen' ));
      MinderheitnSitze.Caption := IntToStr(JInt( obj, 'minmin' ));
      Minderheit.Caption := JString( obj, 'minderheit');

    end;

  end;


  client.Free;
end;

procedure TWahlsimulatorForm.UpdateView;
begin
  Label1.Caption := 'Wahlberechtigt : '+intToStr(m_anzahl);
  Label2.Caption := 'Frauen :'+intToStr(m_female);
  Label3.Caption := 'Männer :'+intToStr(m_male);

end;

end.
