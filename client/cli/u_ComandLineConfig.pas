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
unit u_ComandLineConfig;

interface


implementation

uses
  VSoft.CommandLine.Options,
  u_ComandOptions;

//------------------------------------------------------------------------------
// Prozedur: ConfigureOptions
// Beschreibung: Diese Prozedur konfiguriert die verfügbaren Optionen für die 
//               Befehlszeilenparameter. Sie registriert eine Option für die 
//               Angabe des Hosts, zu dem eine Verbindung hergestellt werden soll.
// Parameter: Keine
// Rückgabewert: Keine
// Besonderheiten:
//   - Der Name-Wert-Trenner für Optionen wird auf '=' gesetzt.
//   - Eine Option 'host' (Kurzform: 'h') wird registriert, die den Host definiert.
//   - Der angegebene Hostwert wird in der Klasse THostOptions gespeichert.
//------------------------------------------------------------------------------
procedure ConfigureOptions;
var
  option : IOptionDefinition;
begin

  TOptionsRegistry.NameValueSeparator := '=';

  option := TOptionsRegistry.RegisterOption<string>('host','h','the host to connect',
    procedure(const value : string)
    begin
      THostOptions.Host := value;
    end);

end;



initialization
  ConfigureOptions;

end.
