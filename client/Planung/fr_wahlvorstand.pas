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
unit fr_wahlvorstand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, u_BRWahlFristen,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons,
  System.Generics.Collections, System.JSON, u_Wahlvorstand;

type
  TWahlVorstandFrame = class(TFrame)
    GroupBox1: TGroupBox;
    LV: TListView;
    Panel1: TPanel;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
  private
    m_vorstand : IWahlvorstand;
    m_map : Tdictionary<string, integer>;
    FWahlVerfahren: TWahlVerfahren;

    procedure setWahlVerfahren( value : TWahlVerfahren );

    procedure setWahlvorstand( value : IWahlvorstand );
    function   getWahlvorstand : IWahlvorstand;

    procedure UpdateView;
    procedure UpdateRow( person : IWahlvorstandPerson; item : TListItem );
  public
    procedure init;
    procedure release;

    property WahlVerfahren: TWahlVerfahren read FWahlVerfahren write setWahlVerfahren;
    property WahlVorstand : IWahlvorstand read getWahlvorstand write setWahlvorstand;
  end;

implementation

{$R *.dfm}
uses
  u_json, u_utils, m_res, f_WahlVorstandPerson, Vcl.Dialogs, system.UITypes,
  u_stub, m_glob, i_waehlerliste, f_waehlerliste;

{ TWahlVorstandFrame }

procedure TWahlVorstandFrame.btnAddClick(Sender: TObject);
var
  person : IWahlvorstandPerson;
  w : IWaehler;
  client : TVortandModClient;
begin
  w := TWaehlerListeForm.executeform;
  if not Assigned(w) then
    exit;

  person := createWahlvorstandPerson;
  person.ID         := w.ID;
  person.PersNr     := w.PersNr;
  person.Name       := w.Name;
  person.Vorname    := w.Vorname;
  person.Abteilung  := w.Abteilung;
  person.Geschlecht := w.Geschlecht;

  Application.CreateForm(TWahlVorstandPersonForm, WahlVorstandPersonForm);

  WahlVorstandPersonForm.Person := person;
  if WahlVorstandPersonForm.ShowModal = mrOk then
  begin
    UpdateRow(person, LV.Items.Add);
    m_vorstand.add(person);

    client := TVortandModClient.Create(GM.SQLConnection1.DBXConnection);
    client.add(person.toJSON);
    client.Free
  end
  else
    person .release;

  WahlVorstandPersonForm.Free;
end;

procedure TWahlVorstandFrame.btnDeleteClick(Sender: TObject);
var
  person : IWahlvorstandPerson;
  s : string;
  client : TVortandModClient;
  res : TJSONObject;
begin
  if not Assigned(LV.Selected) then
    exit;

  person := IWahlvorstandPerson(LV.Selected.Data);
  s := format('Der der Benutzer %s, %s aus der Liste gelöscht werden?', [person.Name, person.Vorname]);
  if MessageDlg(s,  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    client := TVortandModClient.Create(GM.SQLConnection1.DBXConnection);

    res := client.delete(person.toJSON);
    if JBool(res, 'result') then
    begin
      Lv.Items.Delete(LV.Selected.Index);
      m_vorstand.delete(person);
    end;
    client.Free;
  end;
end;

procedure TWahlVorstandFrame.btnEditClick(Sender: TObject);
var
  person : IWahlvorstandPerson;
  client : TVortandModClient;
begin
  if not Assigned(LV.Selected) then
    exit;

  Application.CreateForm(TWahlVorstandPersonForm, WahlVorstandPersonForm);
  person := IWahlvorstandPerson(LV.Selected.Data);

  WahlVorstandPersonForm.Person := person;
  if WahlVorstandPersonForm.ShowModal = mrOk then
  begin
    UpdateRow(person, LV.Selected);
    client := TVortandModClient.Create(GM.SQLConnection1.DBXConnection);
    client.save(person.toJSON);
    client.Free;
  end;

  WahlVorstandPersonForm.Free;
end;

function TWahlVorstandFrame.getWahlvorstand: IWahlvorstand;
begin
  Result := m_vorstand;
end;

procedure TWahlVorstandFrame.init;
var
  list : TStringList;
  i    : Integer;
  grp  : TListGroup;
begin
  m_map := Tdictionary<string, integer>.Create;
  list := TStringList.Create;
  TWahlvorstandsRolleToList( list );
  for i := 0 to pred(list.Count) do
  begin
    grp := LV.Groups.Add;
    grp.Header  := list[i];
    grp.GroupID := i+1;
    m_map.Add(grp.Header, grp.GroupID);
  end;
  list.Free
end;

procedure TWahlVorstandFrame.LVDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

procedure TWahlVorstandFrame.release;
begin
  m_map.Free;
  m_vorstand := NIL;
end;

procedure TWahlVorstandFrame.setWahlVerfahren(value: TWahlVerfahren);
begin
  FWahlVerfahren := value;
end;

procedure TWahlVorstandFrame.setWahlvorstand(value: IWahlvorstand);
begin
  m_vorstand := value;

  UpdateView;
end;

procedure TWahlVorstandFrame.UpdateRow(person: IWahlvorstandPerson;
  item: TListItem);
var
  id : integer;
begin
  item.Data := person;
  item.SubItems.Clear;

  item.Caption := person.PersNr;
  Item.SubItems.Add(person.Name);
  Item.SubItems.Add(person.Vorname);
  Item.SubItems.Add(person.GeschlechtStr);
  Item.SubItems.Add(person.RolleStr);
  Item.SubItems.Add( BoolToJaNein(person.Stimmberechtigt));
  Item.SubItems.Add(person.Login);
  Item.SubItems.Add(person.eMail);

  if m_map.TryGetValue(TWahlvorstandsRolleToString(person.Rolle), id) then
    item.GroupID := id
  else
    item.GroupID := 1;
end;

procedure TWahlVorstandFrame.UpdateView;
var
  person : IWahlvorstandPerson;
  item : Tlistitem;
begin
  LV.Items.Clear;

  for person in m_vorstand.Items do
  begin
    item := LV.Items.Add;
    UpdateRow(person, item);
  end;
end;

end.
