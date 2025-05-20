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
  private
    m_vorstand : IWahlvorstand;
    m_map : Tdictionary<string, integer>;
    FWahlVerfahren: TWahlVerfahren;

    procedure setWahlVerfahren( value : TWahlVerfahren );

    procedure setWahlvorstand( value : TJSONObject );
    function   getWahlvorstand : TJSONObject;

    procedure UpdateView;
    procedure UpdateRow( person : IWahlvorstandPerson; item : TListItem );
  public
    procedure init;
    procedure release;

    property WahlVerfahren: TWahlVerfahren read FWahlVerfahren write setWahlVerfahren;
    property WahlVorstand : TJSONObject read getWahlvorstand write setWahlvorstand;
  end;

implementation

{$R *.dfm}
uses
  u_json, u_utils, m_res, f_WahlVorstandPerson, Vcl.Dialogs, system.UITypes;

{ TWahlVorstandFrame }

procedure TWahlVorstandFrame.btnAddClick(Sender: TObject);
var
  person : IWahlvorstandPerson;
begin
  Application.CreateForm(TWahlVorstandPersonForm, WahlVorstandPersonForm);
  person := m_vorstand.new;
  WahlVorstandPersonForm.Person := person;
  if WahlVorstandPersonForm.ShowModal = mrOk then
    UpdateRow(person, LV.Items.Add)
  else
    m_vorstand.delete( person );
  WahlVorstandPersonForm.Free;
end;

procedure TWahlVorstandFrame.btnDeleteClick(Sender: TObject);
var
  person : IWahlvorstandPerson;
  s : string;
begin
  if not Assigned(LV.Selected) then
    exit;

  person := IWahlvorstandPerson(LV.Selected.Data);
  s := format('Der der Benutzer %s, %s aus der Liste gelöscht werden?', [person.Name, person.Vorname]);
  if MessageDlg(s,  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Lv.Items.Delete(LV.Selected.Index);
    m_vorstand.delete(person);
  end;
end;

procedure TWahlVorstandFrame.btnEditClick(Sender: TObject);
var
  person : IWahlvorstandPerson;
begin
  if not Assigned(LV.Selected) then
    exit;

  Application.CreateForm(TWahlVorstandPersonForm, WahlVorstandPersonForm);
  person := IWahlvorstandPerson(LV.Selected.Data);

  WahlVorstandPersonForm.Person := person;
  if WahlVorstandPersonForm.ShowModal = mrOk then
    UpdateRow(person, LV.Selected);

  WahlVorstandPersonForm.Free;
end;

function TWahlVorstandFrame.getWahlvorstand: TJSONObject;
begin
  Result := m_vorstand.toJSON;
end;

procedure TWahlVorstandFrame.init;
var
  list : TStringList;
  i    : Integer;
  grp  : TListGroup;
begin
  m_vorstand := createWahlvorstand;

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

procedure TWahlVorstandFrame.release;
begin
  m_map.Free;
  if Assigned(m_vorstand) then
    m_vorstand.release;
  m_vorstand := NIL;
end;

procedure TWahlVorstandFrame.setWahlVerfahren(value: TWahlVerfahren);
begin
  FWahlVerfahren := value;
end;

procedure TWahlVorstandFrame.setWahlvorstand(value: TJSONObject);
begin
  m_vorstand.fromJSON(value);

  UpdateView;
end;

procedure TWahlVorstandFrame.UpdateRow(person: IWahlvorstandPerson;
  item: TListItem);
var
  id : integer;
begin
  item.Data := person;
  item.Caption := person.Login;
  item.SubItems.Clear;

  Item.SubItems.Add(person.Name);
  Item.SubItems.Add(person.Vorname);
  Item.SubItems.Add(person.Anrede);
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
