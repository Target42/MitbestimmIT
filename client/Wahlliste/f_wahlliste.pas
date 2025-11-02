unit f_wahlliste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, m_glob, Datasnap.DBClient, Datasnap.DSConnect,
  Vcl.ExtCtrls, m_res, Vcl.Buttons, u_wahlliste, u_json;

type
  TWahllistenForm = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    DSProviderConnection1: TDSProviderConnection;
    ListenQry: TClientDataSet;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    MAQry: TClientDataSet;
    DBGrid2: TDBGrid;
    Panel2: TPanel;
    DataSource2: TDataSource;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    class procedure execute;
  end;

var
  WahllistenForm: TWahllistenForm;

implementation

uses
  u_stub, System.JSON, f_wahlliste_name, f_wahlliste_personen;
{$R *.dfm}

{ TWahllistenForm }

procedure TWahllistenForm.BitBtn1Click(Sender: TObject);
var
  wl : TWahlliste;
  p  : TWahllistePerson;
  client : TWahlListeModClient;
  res    : TJSONObject;
begin
  if ListenQry.IsEmpty then
    exit;

  ListenQry.DisableControls;
  MAQry.DisableControls;

  wl      := TWahlliste.create;
  wl.ID   := ListenQry.FieldByName('WT_ID').AsInteger;
  wl.Name := ListenQry.FieldByName('WT_NAME').AsString;
  wl.Kurz := ListenQry.FieldByName('WT_KURZ').AsString;

  MAQry.First;
  while not MAQry.Eof do
  begin
    p := wl.add;
    p.Nr := MAQry.FieldByName('WT_WA_POS').AsInteger;
    p.ID := MAQry.FieldByName('MA_ID').AsInteger;
    MAQry.Next;
  end;

  if TWahllistenPersonenForm.execute(wl) then
  begin
    client := TWahlListeModClient.Create(GM.SQLConnection1.DBXConnection);
    client.saveMA(wl.toJSON);
    client.Free;
  end;
  wl.Free;

  MAQry.EnableControls;
  ListenQry.EnableControls;
end;

procedure TWahllistenForm.btnAddClick(Sender: TObject);
var
  wl : TWahlliste;
  client : TWahlListeModClient;
  res : TJSONObject;
begin
  wl := TWahlliste.create;
  if TWahllistenNameForm.exec(wl) then
  begin
    client := TWahlListeModClient.Create(GM.SQLConnection1.DBXConnection);
    res := client.add(wl.toJSON);

    if not Jbool( res, 'result') then
      ShowMessage( JString( res, 'text'));

    client.Free;
    ListenQry.Refresh;
  end;
  wl.Free;
end;

procedure TWahllistenForm.btnDeleteClick(Sender: TObject);
var
  wl : TWahlliste;
  client : TWahlListeModClient;
  res    : TJSONObject;
begin
  if ListenQry.IsEmpty then
    exit;

  wl := TWahlliste.create;
  wl.ID := ListenQry.FieldByName('WT_ID').AsInteger;

  client := TWahlListeModClient.Create(GM.SQLConnection1.DBXConnection);

  res := client.delete(wl.toJSON);

  if not JBool(res, 'result') then
    ShowMessage(Jstring(res, 'text'));

  client.Free;
  wl.Free;

  ListenQry.Refresh;
end;

procedure TWahllistenForm.btnEditClick(Sender: TObject);
var
  wl : TWahlliste;
  client : TWahlListeModClient;
  res    : TJSONObject;
begin
  if ListenQry.IsEmpty then
    exit;

  wl      := TWahlliste.create;
  wl.ID   := ListenQry.FieldByName('WT_ID').AsInteger;
  wl.Name := ListenQry.FieldByName('WT_NAME').AsString;
  wl.Kurz := ListenQry.FieldByName('WT_KURZ').AsString;

  if TWahllistenNameForm.exec(wl) then
  begin
    client := TWahlListeModClient.Create(GM.SQLConnection1.DBXConnection);

    res := client.save(wl.toJSON);

    if not JBool(res, 'result') then
      ShowMessage(Jstring(res, 'text'));

    client.Free;
  end;
  wl.Free;

  ListenQry.Refresh;
end;

class procedure TWahllistenForm.execute;
begin
  Application.CreateForm(TWahllistenForm, WahllistenForm);
  WahllistenForm.ShowModal;
  WahllistenForm.Free;
end;

procedure TWahllistenForm.FormCreate(Sender: TObject);
begin
  ListenQry.Open;
  MAQry.Open;
end;

end.
