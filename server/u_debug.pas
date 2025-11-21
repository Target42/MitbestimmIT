unit u_debug;

interface

procedure DebugMsg( text : string );

implementation

procedure DebugMsg( text : string );
begin
{$ifdef DEBUG}
  Writeln(text);
{$ENDIF}
end;

end.
