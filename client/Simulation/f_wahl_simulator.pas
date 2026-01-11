unit f_wahl_simulator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, u_simdata,
  Vcl.Buttons;

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
    BitBtn1: TBitBtn;
    Label8: TLabel;
    Label9: TLabel;
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    m_anzahl      : integer;
    m_male        : integer;
    m_female      : integer;

    m_simdata       : TSimdata;

    procedure rechne;
    procedure UpdateView;
    procedure setBar( sc : TScrollBar; max : integer );
    function perc( sc : TScrollBar ) : integer;

    procedure UpdateData;
    procedure UpdateSimData;

    procedure save;
  public
    class procedure execute;
  end;

var
  WahlsimulatorForm: TWahlsimulatorForm;

implementation

uses
  u_stub, System.JSON, m_glob, u_json, m_res, u_helper;

{$R *.dfm}

{ TWahlsimulatorForm }

procedure TWahlsimulatorForm.BitBtn1Click(Sender: TObject);
begin
  save;
end;

class procedure TWahlsimulatorForm.execute;
begin
  Application.CreateForm(TWahlsimulatorForm, WahlsimulatorForm);
  WahlsimulatorForm.ShowModal;
  WahlsimulatorForm.Free;
end;

procedure TWahlsimulatorForm.FormCreate(Sender: TObject);
begin
  m_simdata := TSimdata.create;

  PageControl1.ActivePage := TabSheet1;
  m_anzahl := 0;
  m_male   := 0;
  m_female := 0;

  UpdateData;
  UpdateView;
end;

procedure TWahlsimulatorForm.FormDestroy(Sender: TObject);
begin
  m_simdata.Free;
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
  beteidigung : double;
begin
  beteidigung := (1.0 * ScrollBar1.Position) / 100.0;

  pers       := trunc( m_anzahl * beteidigung);

  m_simdata.Summe := pers;

  setBar(ScrollBar2, pers);
  setBar(ScrollBar3, pers);
end;

procedure TWahlsimulatorForm.save;
var
  client: TDSSimClient;
  data  : TJSONObject;
begin
  client := TDSSimClient.Create(GM.SQLConnection1.DBXConnection);
  data := client.setSimData(m_simdata.toJson);
  ShowResult(data, true);

  TabSheet1.Enabled := false;
  client.Free;
end;

procedure TWahlsimulatorForm.ScrollBar1Change(Sender: TObject);
begin
  m_simdata.Summe := trunc ( 1.0 * m_anzahl * ( ScrollBar1.Position / 100.0));
  labWahlBeteidigung.Caption := Format('%d %% (%d Personen)',
  [
    ScrollBar1.Position,
    m_simdata.Summe
  ]);
  rechne;
end;

procedure TWahlsimulatorForm.ScrollBar2Change(Sender: TObject);
begin
  m_simdata.BriefWaehler := ScrollBar2.Position;
  labBrief.Caption := Format('%d (%d %%)', [m_simdata.BriefWaehler, perc(Sender as TScrollBar)]);

  setBar(ScrollBar3, m_simdata.BriefWaehler);
end;

procedure TWahlsimulatorForm.ScrollBar3Change(Sender: TObject);
begin
  m_simdata.Doppelt := ScrollBar3.Position;
  Label7.Caption := Format('%d (%d %%)', [m_simdata.Doppelt, perc(Sender as TScrollBar)]);
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
  obj    : TJSONObject;
  arr    : TJSONArray;
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

      Gremium.Caption           := IntToStr(JInt( obj, 'gremium' ));
      Freistellungen.Caption    := IntToStr(JInt( obj, 'freistellungen' ));
      MinderheitnSitze.Caption  := IntToStr(JInt( obj, 'minmin' ));
      Minderheit.Caption        := JString( obj, 'minderheit');

      arr := JArray( data, 'listen');

      if not Assigned(arr) or (arr.Count = 0)then
      begin
        Label8.Font.Color := clRed;
        TabSheet1.Enabled := false;
      end
      else
      begin
        Label8.Caption := format('Vorschlagslisten : %d', [arr.Count]);
      end;

      arr := JArray( data, 'lokale');
      if not Assigned(arr) or (arr.Count = 0)then
      begin
        Label9.Font.Color := clRed;
        TabSheet1.Enabled := false;
      end
      else
      begin
        Label9.Caption := format('Wahllokale : %d', [arr.Count]);
      end;

    end;
  end;
  client.Free;
  UpdateSimData;
end;

procedure TWahlsimulatorForm.UpdateSimData;
var
  client: TDSSimClient;
  data  : TJSONObject;
begin
  client := TDSSimClient.Create(GM.SQLConnection1.DBXConnection);

  data := client.getBasisData;
  m_simdata.fromJson( data );
  client.Free;

  if not m_simdata.IsEmpty then
  begin
    ScrollBar1.Position := trunc(  100.0 * m_simdata.Waehler  / m_anzahl );

    setBar(ScrollBar1, ScrollBar1.Position);
    ScrollBar2.Position := m_simdata.BriefWaehler;
    ScrollBar2Change(ScrollBar2);

    ScrollBar3.Position := m_simdata.Doppelt;
    ScrollBar3Change(ScrollBar3);

    TabSheet1.Enabled := m_simdata.IsEmpty;
  end;
end;

procedure TWahlsimulatorForm.UpdateView;
begin
  Label1.Caption := 'Wahlberechtigt : '+intToStr(m_anzahl);
  Label2.Caption := 'Frauen :'+intToStr(m_female);
  Label3.Caption := 'Männer :'+intToStr(m_male);
end;

end.
