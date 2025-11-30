unit u_pwd;

interface

function CalcPwdHash( pwd, secret : string ) : string;

implementation

uses
  System.Hash, System.SysUtils;

function CalcPwdHash( pwd, secret : string ) : string;
begin
  Result := THashSHA2.GetHashString( pwd + secret );
end;

end.
