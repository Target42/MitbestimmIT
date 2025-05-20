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
unit u_fonts;

interface

procedure LoadFontsFromResource;
procedure UnloadFonts;

implementation

uses
  Windows, Graphics, System.Classes, System.SysUtils;

var
  FontMem: array[1..18] of Pointer;
  FontHandle: array[1..18] of DWORD;


{
  ------------------------------------------------------------------------------
  Prozedur: LoadFontsFromResource
  Beschreibung:
    Lädt Schriftarten aus Ressourcen und fügt sie dem Speicher hinzu, damit sie
    in der Anwendung verwendet werden können. Die Schriftarten werden aus
    benannten Ressourcen (fnt_1 bis fnt_18) geladen und im Speicher gehalten.
    
  Parameter:
    Keine.

  Lokale Variablen:
    - Res: TResourceStream
      Stream, der die Schriftart-Ressource enthält.
    - FontMemSize: DWORD
      Größe der Schriftart-Ressource im Speicher.
    - i: Integer
      Schleifenvariable, um durch die Schriftart-Ressourcen zu iterieren.

  Ablauf:
    1. Iteriert durch die Ressourcen mit den Namen 'fnt_1' bis 'fnt_18'.
    2. Erstellt einen TResourceStream für jede Ressource.
    3. Reserviert Speicher für die Schriftartdaten und liest die Daten in den
       Speicher.
    4. Fügt die Schriftart mit AddFontMemResourceEx dem System hinzu.
    5. Gibt den TResourceStream nach der Verarbeitung frei.

  Hinweise:
    - Die Schriftarten werden im Speicher gehalten und müssen später manuell
      freigegeben werden, um Speicherlecks zu vermeiden.
    - Die Prozedur setzt voraus, dass die Ressourcen korrekt im Projekt
      eingebunden sind.

  ------------------------------------------------------------------------------
}
procedure LoadFontsFromResource;
var
  Res: TResourceStream;
  FontMemSize: DWORD;
  i   : integer;
begin
  for i := 1 to 18 do
  begin
    Res := TResourceStream.Create(HInstance, format('fnt_%d', [i]), RT_RCDATA);
    try
      FontMemSize := Res.Size;
      GetMem(FontMem[i], FontMemSize);
      Res.Read(FontMem[i]^, FontMemSize);

      AddFontMemResourceEx(FontMem[i], FontMemSize, nil, @FontHandle[i]);
    finally
      Res.Free;
    end;
  end;
end;

{
  /// <summary>
  /// Die Prozedur <c>UnloadFonts</c> entfernt Schriftarten aus dem Speicher und gibt den zugewiesenen Speicher frei.
  /// </summary>
  /// <remarks>
  /// Diese Prozedur iteriert über ein Array von Schriftart-Handles und Speicherblöcken, 
  /// entfernt die Schriftarten mit <c>RemoveFontMemResourceEx</c> und gibt den zugehörigen Speicher mit <c>FreeMem</c> frei.
  /// </remarks>
  /// <param name="i">Indexvariable für die Schleife, die von 1 bis 18 iteriert.</param>
  /// <seealso cref="RemoveFontMemResourceEx"/>
  /// <seealso cref="FreeMem"/>
}
procedure UnloadFonts;
var
  i   : integer;
begin
  for i := 1 to 18 do
  begin
    RemoveFontMemResourceEx(FontHandle[i]);
    FreeMem(FontMem[i]);
  end;
end;

initialization
  LoadFontsFromResource;
finalization
  UnloadFonts
end.
