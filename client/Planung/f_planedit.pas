unit f_planedit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, fr_wahlfristen, u_stub,
  u_BRWahlFristen;

type
  TPlanEditoForm = class(TForm)
    BaseFrame1: TBaseFrame;
    WahlfristenFrame1: TWahlfristenFrame;
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_client : TWahlModClient;
    m_list   : TWahlPhasenListe;
    m_wv : TWahlVerfahren;
    procedure load;
    procedure save;
  public
    { Public-Deklarationen }
  end;

var
  PlanEditoForm: TPlanEditoForm;

implementation

uses
  System.JSON, u_json, m_glob;

{$R *.dfm}



{ TPlanEditoForm }

procedure TPlanEditoForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  save;
end;

procedure TPlanEditoForm.FormCreate(Sender: TObject);
begin
  m_client := TWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  m_list   := TWahlPhasenListe.Create;
  load;
end;

procedure TPlanEditoForm.FormDestroy(Sender: TObject);
begin
  m_client.Free;
  releaseWahlPhasen(m_list);
  m_list.Free;
  WahlfristenFrame1.release;
end;

procedure TPlanEditoForm.load;
var
  data : TJSONObject;
begin
  data := m_client.loadWahlData;

  m_wv := TWahlVerfahren(JInt(data, 'verfahren'));
  JsonToWahlPhase( m_list, data );
  WahlfristenFrame1.init(@m_list);
  WahlfristenFrame1.updateView;
end;

procedure TPlanEditoForm.save;
var
  data : TJSONObject;
begin
  data := WahlphasenToJson(m_list);
  JReplace( data, 'verfahren', integer(m_wv));
  m_client.updateWahlData(data);
end;

end.
