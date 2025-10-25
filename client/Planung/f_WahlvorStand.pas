unit f_WahlvorStand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_wahlvorstand, fr_base,
  u_Wahlvorstand, Vcl.ComCtrls;

type
  TWahlVorstandForm = class(TForm)
    WahlVorstandFrame1: TWahlVorstandFrame;
    StatusBar1: TStatusBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    m_vorstand : IWahlVorstand;

    procedure load;
  public
    class procedure execute;
  end;

var
  WahlVorstandForm: TWahlVorstandForm;

implementation

{$R *.dfm}

uses u_stub, m_glob, System.JSON;

{ TWahlVorstandForm }

class procedure TWahlVorstandForm.execute;
begin
  Application.CreateForm(TWahlVorstandForm, WahlVorstandForm);
  WahlVorstandForm.ShowModal;
  WahlVorstandForm.Free;
end;

procedure TWahlVorstandForm.FormCreate(Sender: TObject);
begin
  WahlVorstandFrame1.init;
  load;
  WahlVorstandFrame1.WahlVorstand := m_vorstand;
end;

procedure TWahlVorstandForm.FormDestroy(Sender: TObject);
begin
  WahlVorstandFrame1.release;
  m_vorstand.release;
end;

procedure TWahlVorstandForm.load;
var
  client : TVortandModClient;
  data   : TJSONObject;

begin
  client := TVortandModClient.Create( GM.SQLConnection1.DBXConnection );
  data := client.getlist;

  m_vorstand := createWahlvorstand;
  m_vorstand.fromJSON(data);

  client.Free;

end;

end.
