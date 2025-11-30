{
  This file is part of the MitbestimmIT project.

  Copyright (C) 2025 Stephan Winter

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <https://www.gnu.org/licenses/>.
}
unit f_wahlklokalForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  m_res, fr_base, Vcl.Buttons, u_wahllokal, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

type
  TWahllokalForm = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    DSProviderConnection1: TDSProviderConnection;
    DBGrid1: TDBGrid;
    LokalQry: TClientDataSet;
    LokalSrc: TDataSource;
    HelferQry: TClientDataSet;
    HelferSrc: TDataSource;
    DBGrid2: TDBGrid;
    HelferQryMA_ID: TIntegerField;
    HelferQryMA_PERSNR: TStringField;
    HelferQryMA_NAME: TStringField;
    HelferQryMA_VORNAME: TStringField;
    HelferQryMA_GENDER: TStringField;
    HelferQryMA_ABTEILUNG: TStringField;
    HelferQryMA_MAIL: TStringField;
    HelferQryMA_GEB: TDateField;
    HelferQryWH_ROLLE: TStringField;
    HelferQryWL_ID: TIntegerField;
    HelferQryWA_ID: TIntegerField;
    PopupMenu1: TPopupMenu;
    Bemerkungbearbeiten1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure HelferQryMA_GENDERGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Bemerkungbearbeiten1Click(Sender: TObject);
  private
  public
    class procedure execute;

  end;

var
  WahllokalForm: TWahllokalForm;

implementation

uses
  f_wahllokalRaum, m_glob, u_stub, i_waehlerliste, f_waehlerliste, System.JSON,
  u_json, system.UITypes;

{$R *.dfm}

{ TWahllokalForm }

procedure TWahllokalForm.Bemerkungbearbeiten1Click(Sender: TObject);
var
  s : string;
  client : TLokaleModClient;
  data, res : TJSONOBject;
begin
  if HelferQry.IsEmpty then
    exit;

  s := HelferQry.FieldByName('WH_ROLLE').AsString;

  if InputQuery('Bemerkung', 'Text', s) then
  begin
    data := TJSONObject.Create;

    JReplace(data, 'raumid', HelferQry.FieldByName('WL_ID').AsInteger);
    JReplace(data, 'maid',   HelferQry.FieldByName('MA_ID').AsInteger);
    JReplace(data, 'rolle',  s);

    client := TLokaleModClient.Create(GM.SQLConnection1.DBXConnection);
    res := client.saveHelfer(data);
    if not JBool( res, 'result') then
    begin
      ShowMessage(JString(res, 'text'));
    end;

    HelferQry.Refresh;
    client.Free;

  end;

end;

procedure TWahllokalForm.BitBtn1Click(Sender: TObject);
var
  waehler : IWaehler;
  client : TLokaleModClient;
  data, res : TJSONOBject;
begin
  waehler := TWaehlerListeForm.executeform;

  if Assigned(waehler) then
  begin
    data := TJSONObject.Create;

    JReplace(data, 'raumid', LokalQry.FieldByName('WL_ID').AsInteger);
    JReplace(data, 'maid', waehler.ID );
    JReplace(data, 'persnr', waehler.PersNr);

    client := TLokaleModClient.Create(GM.SQLConnection1.DBXConnection);
    res := client.addHelfer(data);
    if not JBool( res, 'result') then
    begin
      ShowMessage(JString(res, 'text'));
    end;

    HelferQry.Refresh;
    client.Free;
  end;
end;

procedure TWahllokalForm.BitBtn3Click(Sender: TObject);
var
  client : TLokaleModClient;
  data, res : TJSONOBject;
begin
  if MessageDlg('Soll der Wahöhelfer wirklich gelöscht werden?',  mtConfirmation,
  [mbYes, mbNo], 0) <> mrYes then
    exit;

  data := TJSONObject.Create;

  JReplace(data, 'raumid', HelferQry.FieldByName('WL_ID').AsInteger);
  JReplace(data, 'maid', HelferQry.FieldByName('MA_ID').AsInteger);

  client := TLokaleModClient.Create(GM.SQLConnection1.DBXConnection);
  res := client.deleteHelfer(data);
  if not JBool( res, 'result') then
  begin
    ShowMessage(JString(res, 'text'));
  end;
  HelferQry.Refresh;

  client.Free;

end;
procedure TWahllokalForm.btnAddClick(Sender: TObject);
begin
  if TWahllokalRaumform.add then
  begin
    LokalQry.Refresh;
  end;
end;

procedure TWahllokalForm.btnDeleteClick(Sender: TObject);
var
  client : TLokaleModClient;
begin
  if LokalQry.IsEmpty then
    exit;

  if MessageDlg('Soll der Raum wirklich gelöscht werden?',  mtConfirmation,
      [mbYes, mbNo], 0) <> mrYes then
    exit;

  client := TLokaleModClient.Create(GM.SQLConnection1.DBXConnection);
  client.delete(LokalQry.FieldByName('WL_ID').AsInteger);
  client.Free;
  LokalQry.Refresh;
end;

procedure TWahllokalForm.btnEditClick(Sender: TObject);
begin
  if LokalQry.IsEmpty then
    exit;

  if TWahllokalRaumform.edit(LokalQry.FieldByName('WL_ID').AsInteger ) then
  begin
    LokalQry.Refresh;
  end;
end;

class procedure TWahllokalForm.execute;
begin
  Application.CreateForm(TWahllokalForm, WahllokalForm);
  WahllokalForm.ShowModal;
  WahllokalForm.Free;
end;

procedure TWahllokalForm.FormCreate(Sender: TObject);
begin
  LokalQry.Open;
  if GM.MAUserTab.IsEmpty then
    GM.updateMATab;

  HelferQry.Open;

end;

procedure TWahllokalForm.HelferQryMA_GENDERGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString = 'w' then
    Text := 'weiblich'
  else
    Text := 'männlich';
end;

end.
