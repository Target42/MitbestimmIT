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
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_BRWahlFristen,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons,
  System.Generics.Collections, System.JSON;

type
  TWahlVorstandFrame = class(TFrame)
    GroupBox1: TGroupBox;
    LV: TListView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
  private
    m_data : TJSONObject;
    m_map : Tdictionary<string, integer>;
    FWahlVerfahren: TWahlVerfahren;

    procedure setWahlVerfahren( value : TWahlVerfahren );

    procedure setWahlvorstand( value : TJSONObject );
    function   getWahlvorstand : TJSONObject;

    procedure UpdateView;
  public
    procedure init;
    procedure release;

    property WahlVerfahren: TWahlVerfahren read FWahlVerfahren write setWahlVerfahren;
    property WahlVorstand : TJSONObject read getWahlvorstand write setWahlvorstand;
  end;

implementation

{$R *.dfm}
uses
  u_Wahlvorstand, u_json, u_utils;

{ TWahlVorstandFrame }

function TWahlVorstandFrame.getWahlvorstand: TJSONObject;
begin

end;

procedure TWahlVorstandFrame.init;
var
  list : TStringList;
  i    : Integer;
  grp  : TListGroup;
begin
  m_data := TJSONObject.Create;
  JReplace( m_data, 'personen', TJSONArray.Create);

  m_map := Tdictionary<string, integer>.Create;
  list := TStringList.Create;
  TWahlvorstandsRolleToList( list );
  for i := 0 to pred(list.Count) do
  begin
    grp := LV.Groups.Add;
    grp.Header  := list[i];
    grp.GroupID := i+1;
  end;
  list.Free
end;

procedure TWahlVorstandFrame.release;
begin
  m_map.Free;
  if Assigned(m_data) then
    m_data.Free;
end;

procedure TWahlVorstandFrame.setWahlVerfahren(value: TWahlVerfahren);
begin
  FWahlVerfahren := value;
end;

procedure TWahlVorstandFrame.setWahlvorstand(value: TJSONObject);
begin
  if Assigned(m_data) then
    m_data.Free;
  m_data := value.Clone as TJSONObject;

  UpdateView;
end;

procedure TWahlVorstandFrame.UpdateView;
var
  arr : TJSONArray;
  row : TJSONObject;
  i   : integer;
  item : TListItem;
  id   : Integer;
begin
  LV.Items.Clear;
  arr := JArray( m_data, 'personen');
  if not Assigned(arr) then
    exit;

  for i := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);

    item := LV.Items.Add;
    item.Caption := JString( row, wvIDLogin);
    Item.SubItems.Add(JString(row, wvIDName));
    Item.SubItems.Add(JString(row, wvIDVorname));
    Item.SubItems.Add(JString(row, wvIDAnrede));
    Item.SubItems.Add( BoolToJaNein(JBool(row, wvIDStimmberechtigt)));
    Item.SubItems.Add(JString(row, wvIDMail));

    if m_map.TryGetValue(JString(row, wvIDRolle), id) then
      item.GroupID := id;
  end;
end;

end.
