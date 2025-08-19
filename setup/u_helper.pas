unit u_helper;

interface

uses
  System.Classes;

function SaveRCDataToFile( const ResName, filename: string ) : boolean;
procedure LoadRCDataToStream(const ResName: string; Stream: TStream);
function findInPath( PrgName : string ) : Boolean;

implementation

uses
  Windows, SysUtils, system.IOUtils;

function SaveRCDataToFile( const ResName, filename: string ) : boolean;
var
  os : TStream;
begin
  Result := false;
  os := NIL;
  try
    os := TFileStream.Create(filename, fmCreate );
    LoadRCDataToStream( ResName, os );
    Result := true;
  except

  end;
  os.Free;
end;

procedure LoadRCDataToStream(const ResName: string; Stream: TStream);
var
  ResHandle: HRSRC;
  ResDataHandle: HGLOBAL;
  ResPtr: Pointer;
  ResSize: DWORD;
begin
  // Ressource suchen
  ResHandle := FindResource(HInstance, PChar(ResName), RT_RCDATA);
  if ResHandle = 0 then
    raise Exception.CreateFmt('Ressource "%s" nicht gefunden', [ResName]);

  // Ressourcengröße ermitteln
  ResSize := SizeofResource(HInstance, ResHandle);
  if ResSize = 0 then
    raise Exception.CreateFmt('Ressource "%s" hat Größe 0', [ResName]);

  // Ressource laden
  ResDataHandle := LoadResource(HInstance, ResHandle);
  if ResDataHandle = 0 then
    raise Exception.CreateFmt('Ressource "%s" konnte nicht geladen werden', [ResName]);

  // Zeiger auf Ressourcendaten erhalten
  ResPtr := LockResource(ResDataHandle);
  if ResPtr = nil then
    raise Exception.CreateFmt('Ressource "%s" konnte nicht gesperrt werden', [ResName]);

  // Daten in den Stream kopieren
  Stream.WriteBuffer(ResPtr^, ResSize);
end;

function findInPath( PrgName : string ) : Boolean;
var
  list : TStringList;
  i    : integer;
begin
  Result := false;

  list := TStringList.Create;
  list.Delimiter := ';';
  list.StrictDelimiter := true;
  list.DelimitedText := GetEnvironmentVariable('PATH');


  for I := 0 to pred(list.Count) do
  begin
    Result := FileExists(TPath.Combine(list[i], PrgName));
    if Result then
      break;
  end;

  list.Free;
end;

end.

