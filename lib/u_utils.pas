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
unit u_utils;

interface
{
  Converts a boolean value to a string representation of "Ja" or "Nein".
  @param value The boolean value to convert.
  @return A string, "Ja" if the value is True, "Nein" if the value is False.
}
function BoolToJaNein(value: boolean): string;

{
  Converts a string representation of "Ja" or "Nein" to a boolean value.
  @param value The string to convert. Expected values are "Ja" or "Nein".
  @return A boolean, True if the value is "Ja", False if the value is "Nein".  
}
function JaNeinToBool(value: string): Boolean;


implementation

uses
  System.SysUtils;

function BoolToJaNein( value : boolean ) : string;
begin
  if value then
    Result := 'Ja'
  else
    Result := 'Nein';
end;

function JaNeinToBool( value : string) : Boolean;
begin
  Result := SameText( value, 'ja');
end;

end.
