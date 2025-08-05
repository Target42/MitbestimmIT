unit u_glob;

interface

type
  TGlob = class

  private
    FHomeDir: string;
    FTempDir: string;
  public
    property HomeDir: string read FHomeDir write FHomeDir;
    property TempDir: string read FTempDir write FTempDir;

  end;

var
  Glob : TGlob;

implementation

initialization

  Glob := TGlob.Create;

finalization
  Glob.Free;
  Glob := nil;


end.
