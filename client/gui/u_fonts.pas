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
