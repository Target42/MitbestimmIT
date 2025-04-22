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
