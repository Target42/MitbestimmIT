﻿{
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

unit f_connet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  fr_base, m_glob;

type
  {
    TConnectForm:
    Diese Klasse repräsentiert ein Formular zur Eingabe von Verbindungsinformationen.

    Eigenschaften:
      - Host: String-Eigenschaft, die den Hostnamen oder die IP-Adresse repräsentiert.
      - User: String-Eigenschaft, die den Benutzernamen repräsentiert.
      - Passwort: String-Eigenschaft, die das Passwort repräsentiert.

    Methoden:
      - Execute: Eine Klassenmethode, die das Formular anzeigt und einen Boolean-Wert zurückgibt, 
        der angibt, ob die Eingaben bestätigt wurden.
      - FormCreate: Ereignisprozedur, die beim Erstellen des Formulars aufgerufen wird.

    Private Methoden:
      - GetHost: Gibt den aktuellen Wert der Host-Eigenschaft zurück.
      - SetHost: Setzt den Wert der Host-Eigenschaft.
      - GetUser: Gibt den aktuellen Wert der User-Eigenschaft zurück.
      - SetUser: Setzt den Wert der User-Eigenschaft.
      - GetPasswort: Gibt den aktuellen Wert der Passwort-Eigenschaft zurück.
      - SetPasswort: Setzt den Wert der Passwort-Eigenschaft.
  }
  TConnectForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LabeledEdit1: TLabeledEdit;
    CheckBox1: TCheckBox;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
  private
    function GetHost: string;
    procedure SetHost(const Value: string);
    function GetUser: string;
    procedure SetUser(const Value: string);
    function GetPasswort: string;
    procedure SetPasswort(const Value: string);
    { Private-Deklarationen }
  public
    class function Execute : Boolean;

    property Host: string read GetHost write SetHost;
    property User: string read GetUser write SetUser;
    property Passwort: string read GetPasswort write SetPasswort;
  end;

var
  ConnectForm: TConnectForm;

implementation

{$R *.dfm}

{ TConnectForm }

{
  // Diese Klassenfunktion `TConnectForm.Execute` wird verwendet, um eine Verbindung herzustellen.
  // Sie erstellt ein Formular vom Typ `TConnectForm`, initialisiert es mit den aktuellen Verbindungsdaten
  // und zeigt es dem Benutzer an, um die Eingaben zu bestätigen oder zu ändern.
  //
  // Ablauf:
  // 1. Das Formular wird erstellt und mit den aktuellen Werten für Host, Benutzer und Passwort initialisiert.
  // 2. Der Benutzer hat bis zu drei Versuche, die Verbindung herzustellen.
  // 3. Wenn der Benutzer auf "OK" klickt, werden die eingegebenen Werte gespeichert und eine Verbindung versucht.
  // 4. Wenn die Verbindung erfolgreich ist, wird die Schleife beendet.
  // 5. Wenn der Benutzer die Verbindung abbricht oder die Versuche aufgebraucht sind, wird die Schleife ebenfalls beendet.
  //
  // Rückgabewert:
  // - Gibt `True` zurück, wenn die Verbindung erfolgreich hergestellt wurde (`GM.isConnected`).
  // - Gibt `False` zurück, wenn die Verbindung nicht hergestellt werden konnte.
  //
  // Hinweis:
  // - Das Formular wird nach der Ausführung freigegeben, um Speicherlecks zu vermeiden.
}
class function TConnectForm.Execute: Boolean;
var
  counter : integer;
begin
{$IFDEF DEBUG}
  GM.HostAddress := 'ds://localhost:211';
{$ENDIF}

  Application.CreateForm(TConnectForm, ConnectForm);
  ConnectForm.Host := GM.HostAddress;
  ConnectForm.User := GM.User;
  ConnectForm.Passwort := GM.Passwort;

  counter := 3;
  while counter > 0 do
  begin

    if ConnectForm.ShowModal = mrOk then
    begin
      GM.HostAddress := ConnectForm.Host;
      GM.user := ConnectForm.User;
      GM.Passwort  := ConnectForm.Passwort;

      if GM.connect then
        break;
    end
    else
      break;
    dec( Counter );
  end;

  Result := GM.isConnected;

  ConnectForm.Free;
end;

// Diese Prozedur wird beim Erstellen des Formulars aufgerufen.
// Sie setzt den Text von "LabeledEdit2" auf den Wert der Umgebungsvariable "USERNAME".
// Dies ermöglicht es, den aktuellen Benutzernamen des Systems automatisch im Eingabefeld anzuzeigen.
//
// Parameter:
//   Sender: Das Objekt, das das Ereignis ausgelöst hat.
procedure TConnectForm.FormCreate(Sender: TObject);
begin
  LabeledEdit2.Text := GetEnvironmentVariable('USERNAME');
end;

{
  // Gibt den Hostnamen zurück, basierend auf der Auswahl im Formular.
  // Wenn die Checkbox (CheckBox1) aktiviert ist, wird "simulation" zurückgegeben.
  // Andernfalls wird der Text aus dem LabeledEdit1-Feld zurückgegeben, 
  // wobei führende und nachfolgende Leerzeichen entfernt werden.
  //
  // Rückgabewert:
  //   Ein String, der entweder "simulation" oder der bereinigte Text aus LabeledEdit1 ist.
}
function TConnectForm.GetHost: string;
begin
  if CheckBox1.Checked then
    Result := 'simulation'
  else
    Result := trim( LabeledEdit1.Text);

end;

/// <summary>
/// Gibt das Passwort zurück, das im LabeledEdit3-Feld eingegeben wurde.
/// </summary>
/// <returns>
/// Ein String, der das eingegebene Passwort enthält.
/// </returns>
function TConnectForm.GetPasswort: string;
begin
  Result := LabeledEdit3.Text;
end;

{
  // Gibt den Benutzernamen zurück, der im LabeledEdit2-Feld eingegeben wurde.
  //
  // Rückgabewert:
  //   Ein String, der den eingegebenen Benutzernamen enthält.
}
function TConnectForm.GetUser: string;
begin
  Result := LabeledEdit2.Text;
end;

//------------------------------------------------------------------------------
// Setzt den Benutzerwert für das Formular.
//
// Parameter:
//   Value: Der Benutzername, der gesetzt werden soll. Wenn der Wert leer ist,
//          wird der Benutzername aus der Umgebungsvariable 'USERNAME' geladen.
//
// Beschreibung:
//   Diese Prozedur überprüft, ob der übergebene Wert nicht leer ist. Falls
//   der Wert nicht leer ist, wird er in das Textfeld 'LabeledEdit2' eingetragen.
//   Andernfalls wird der Benutzername aus der Umgebungsvariable 'USERNAME'
//   abgerufen und in das Textfeld eingetragen.
//------------------------------------------------------------------------------
procedure TConnectForm.SetHost(const Value: string);
begin
  LabeledEdit1.Text := '';
  CheckBox1.Checked := SameText('simulation', value );

  if not CheckBox1.Checked then
    LabeledEdit1.Text := value;
end;

procedure TConnectForm.SetPasswort(const Value: string);
begin
  LabeledEdit3.Text := value;
end;

procedure TConnectForm.SetUser(const Value: string);
begin
  if value <>'' then
    LabeledEdit2.Text := value
  else
    LabeledEdit2.Text := GetEnvironmentVariable('USERNAME');
end;

end.
