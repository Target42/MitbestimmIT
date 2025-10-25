unit f_waehlerliste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_base, u_Waehlerliste,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, i_waehlerliste;

type
  TWaehlerListeForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
  private
    function getWaehler : IWaehler;
  public
    class function executeForm : IWaehler;

    property Waehler : IWaehler read getWaehler;
  end;

var
  WaehlerListeForm: TWaehlerListeForm;

implementation

{$R *.dfm}

uses m_glob, System.JSON;

class function TWaehlerListeForm.executeform: IWaehler;
begin
  Result := NIL;
  Application.CreateForm(TWaehlerListeForm, WaehlerListeForm);
  if WaehlerListeForm.ShowModal = mrOk then
  begin
    Result := WaehlerListeForm.Waehler;
  end;
  WaehlerListeForm.Free;
end;

procedure TWaehlerListeForm.FormCreate(Sender: TObject);
begin
  if GM.MAList.IsEmpty then
    GM.updateMATab;

  GM.MAList.Open;
end;

function TWaehlerListeForm.getWaehler: IWaehler;
begin
  Result := NIL;

  if DataSource1.DataSet.IsEmpty then
    exit;

  Result  := TWaehler.create;
  Result.ID        := DataSource1.DataSet.FieldByName('MA_ID').AsInteger;
  Result.PersNr    := DataSource1.DataSet.FieldByName('MA_PERSNR').AsString;
  Result.Name      := DataSource1.DataSet.FieldByName('MA_NAME').AsString;
  Result.Vorname   := DataSource1.DataSet.FieldByName('MA_VORNAME').AsString;
  Result.Geschlecht:= DataSource1.DataSet.FieldByName('MA_GENDER').AsString;
  Result.Abteilung := DataSource1.DataSet.FieldByName('MA_ABTEILUNG').AsString;

end;

end.
