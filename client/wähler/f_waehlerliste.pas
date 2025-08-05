unit f_waehlerliste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_base, u_Waehlerliste,
  Vcl.StdCtrls;

type
  TWaehlerListeForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LV: TListView;
    GroupBox1: TGroupBox;
    procedure FormCreate(Sender: TObject);
  private
    procedure UpdateView;
    function getWaehler : TWaehler;
  public
    class function executeForm : TWaehler;

    property Waehler : TWaehler read getWaehler;
  end;

var
  WaehlerListeForm: TWaehlerListeForm;

implementation

{$R *.dfm}

uses m_glob, System.JSON, i_waehlerliste;

class function TWaehlerListeForm.executeform: TWaehler;
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
var
  data : TJSONObject;
begin
  if GM.WaehlerListe.Items.Count = 0 then
  begin
    data := GM.Storage.WaehlerListe.getWaehlerList;
    GM.WaehlerListe.fromJSON(data);
    if Assigned(data) then
      data.Free;
  end;
  UpdateView;
end;

function TWaehlerListeForm.getWaehler: TWaehler;
begin
  Result := NIL;
  if Assigned(LV.Selected) then
    Result := LV.Selected.Data;
end;

procedure TWaehlerListeForm.UpdateView;
var
  waehler : IWaehler;
  item    : TListItem;
begin
  for waehler in GM.WaehlerListe.Items do
  begin
    item := Lv.Items.Add;

    item.Data := waehler;
    item.Caption := waehler.PersNr;
    item.SubItems.Add(waehler.Name);
    item.SubItems.Add(waehler.Vorname);
    item.SubItems.Add(waehler.Anrede);
    item.SubItems.Add(waehler.Abteilung);
  end;
end;

end.
