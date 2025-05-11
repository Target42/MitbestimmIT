unit u_ComandOptions;

interface

uses
   VSoft.CommandLine.Parser;

type
  THostOptions =  class
  public
    class var
      Host : string;
    class var
      User : string;
    class var
      PWd  : string;
  end;

implementation

end.
