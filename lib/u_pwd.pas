unit u_pwd;

interface

function CalcPwdHash( pwd : string ) : string;

implementation

uses
  System.Hash, System.SysUtils;

function CalcPwdHash( pwd : string ) : string;
begin
  Result := THashSHA2.GetHashString( pwd );
end;

end.
