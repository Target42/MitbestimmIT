unit m_pwd;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet;

type
  TPwdCheckMod = class(TDataModule)
    PwdQry: TFDQuery;
    FDTransaction1: TFDTransaction;
  private
    { Private-Deklarationen }
  public
    type
      TResultTyp = (rtUnknown, rtNoUser, rtWrongPwd, rtOldPwdWrong, rtOk);

      function checkUser( id : integer; pwd : string ) : TResultTyp;
      class function checkUserMod( id : integer; pwd : string ) : TResultTyp;
  end;

var
  PwdCheckMod: TPwdCheckMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_db, u_pwd, u_glob;

{$R *.dfm}

{ TDataModule1 }

function TPwdCheckMod.checkUser(id : integer; pwd: string): TResultTyp;
begin
  PwdQry.ParamByName('MA_ID').AsInteger := id;
  PwdQry.Open;
  if not PwdQry.IsEmpty then
  begin
    if PwdQry.FieldByName('MW_PWD').AsString = CalcPwdHash(pwd, glob.ServerSecret) then
      Result := rtOk
    else
      Result := rtWrongPwd;
  end
  else
    Result := rtNoUser;
  PwdQry.Close;
end;

class function TPwdCheckMod.checkUserMod(id: integer; pwd: string): TResultTyp;
var
  PwdCheckMod: TPwdCheckMod;
begin
  PwdCheckMod := TPwdCheckMod.Create(nil);
  Result := PwdCheckMod.checkUser( id, pwd );
  PwdCheckMod.Free;
end;

end.
