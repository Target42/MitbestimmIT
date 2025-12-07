unit f_wahllokal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Datasnap.DBClient, Datasnap.DSConnect, m_glob,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.BatchMove.DataSet,
  FireDAC.Comp.BatchMove, Vcl.Buttons, u_stub, u_json, u_helper,
  FireDAC.Stan.StorageXML;

type
  TWahlForm = class(TForm)
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    DSProviderConnection1: TDSProviderConnection;
    MaListQry: TClientDataSet;
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    MAList: TFDMemTable;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    MaListQryMA_ID: TIntegerField;
    MaListQryMA_PERSNR: TStringField;
    MaListQryMA_NAME: TStringField;
    MaListQryMA_VORNAME: TStringField;
    MaListQryMA_GENDER: TStringField;
    MaListQryMA_ABTEILUNG: TStringField;
    MaListQryMA_GEB: TDateField;
    MaListQryWL_BAU: TStringField;
    MaListQryWL_STOCKWERK: TStringField;
    MaListQryWL_RAUM: TStringField;
    MaListQryWL_TIMESTAMP: TSQLTimeStampField;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
    ClientDataSet1: TClientDataSet;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    ma_id : integer;
    procedure UpdateList;
    procedure updateHelfer;
  public
    class procedure execute;
  end;

var
  WahlForm: TWahlForm;

implementation

uses
  System.JSON, system.UITypes, f_helfer_wechsel;

{$R *.dfm}

{ TWahlForm }

procedure TWahlForm.BitBtn1Click(Sender: TObject);
var
  s : string;
  ma_id : integer;
  client : TWahlLokalModClient ;
  data : TJSONobject;
  res  : TJSONObject;
begin
  if MAList.IsEmpty then
    exit;

  with MAList do
  begin
    ma_id := FieldByName('ma_id').AsInteger;
    s := Format('Die Wahlunterlagen werden an:%s %s, %s (%s)%s ausgegeben.',
    [
      sLineBreak,
      FieldByName('MA_NAME').AsString,
      FieldByName('MA_VORNAME').AsString,
      FieldByName('MA_PERSNR').AsString,
      sLineBreak
    ]);
  end;
  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;

  data :=TJSONObject.Create;
  JReplace( data, 'maid', ma_id);

  client := TWahlLokalModClient.Create(GM.SQLConnection1.DBXConnection);
  res := client.wahl(data);

  MAList.Edit;
  MAList.FieldByName('wl_timestamp').AsString := JString( res, 'stamp');
  MAList.FieldByName('wl_bau').AsString := JString( res, 'bau');
  MAList.FieldByName('wl_stockwerk').AsString := JString( res, 'stockwerk');
  MAList.FieldByName('wl_raum').AsString := JString( res, 'raum');
  MAList.Post;
  ShowResult( res);

  client.Free;

end;

procedure TWahlForm.BitBtn2Click(Sender: TObject);
begin
  if THelferWechselForm.execute then
  begin
    updateHelfer
  end;
end;

class procedure TWahlForm.execute;
begin
  Application.CreateForm(TWahlForm, WahlForm);
  WahlForm.ShowModal;
  WahlForm.Free;
end;

procedure TWahlForm.FormCreate(Sender: TObject);
begin
  MaListQry.Open;
  FDBatchMove1.Execute;
  MaListQry.Close;

  MAList.FieldByName('wl_timestamp').ReadOnly := false;
  MAList.FieldByName('wl_bau').ReadOnly := false;
  MAList.FieldByName('wl_stockwerk').ReadOnly := false;
  MAList.FieldByName('wl_raum').ReadOnly := false;
  MAList.First;

  UpdateList;
//  MAList.SaveToFile('data.xml', sfXML);
  updateHelfer;
end;

procedure TWahlForm.updateHelfer;
var
  client : TWahlLokalModClient;
  res : TJSONObject;
begin
  client := TWahlLokalModClient.Create( GM.SQLConnection1.DBXConnection);

  res := client.getHelfer;

  if not JBool(res, 'result') then
    ShowMessage(JString(res, 'text'))
  else
  begin
    StatusBar1.SimpleText := format('%s, %s (%s)',
    [
      JString( res, 'name'),
      JString( res, 'vorname'),
      JString( res, 'abteilung')
    ]
    );
  end;

  client.Free;
end;

procedure TWahlForm.UpdateList;
begin
  ClientDataSet1.Open;
  while not  ClientDataSet1.Eof do
  begin
     if MAList.Locate('MA_ID', ClientDataSet1.FieldByName('MA_ID').AsInteger, []) then
     begin
      MAList.Edit;
      MAList.FieldByName('wl_timestamp').AsString := ClientDataSet1.FieldByName('wl_timestamp').AsString;
      MAList.FieldByName('wl_bau').AsString       := ClientDataSet1.FieldByName('wl_bau').AsString;
      MAList.FieldByName('wl_stockwerk').AsString := ClientDataSet1.FieldByName('wl_stockwerk').AsString;
      MAList.FieldByName('wl_raum').AsString      := ClientDataSet1.FieldByName('wl_raum').AsString;
      MAList.Post;
     end;
     ClientDataSet1.Next
  end;
   ClientDataSet1.Close;

end;

end.
