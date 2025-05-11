unit u_ComandLineConfig;

interface


implementation

uses
  VSoft.CommandLine.Options,
  u_ComandOptions;

procedure ConfigureOptions;
var
  option : IOptionDefinition;
  cmd    : TCommandDefinition;
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
