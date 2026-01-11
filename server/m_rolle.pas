unit m_rolle;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet;

type
  TRollenMod = class(TDataModule)
    GetQry: TFDQuery;
    FDTransaction1: TFDTransaction;
    SetQry: TFDQuery;
  private
    function doGetRollls( wa_id, ma_id : integer ) : string;
    function DoSetRolls( wa_id, ma_id : integer; newRolls : string ) : boolean;
  public
    class function getRolls( wa_id, ma_id : integer ) : string;
    class function setRolls( wa_id, ma_id : integer; newRolls : string ) : boolean;


  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses m_db;

{$R *.dfm}

{ TRollenMod }

function TRollenMod.doGetRollls(wa_id, ma_id: integer): string;
begin
  Result := '';
  GetQry.ParamByName('WA_ID').AsInteger := wa_id;
  GetQry.ParamByName('MA_ID').AsInteger := ma_id;

  GetQry.Open();

  if not GetQry.IsEmpty then
    Result := GetQry.FieldByName('MW_ROLLE').AsString;

  GetQry.Close;
end;

function TRollenMod.DoSetRolls(wa_id, ma_id: integer;
  newRolls: string): boolean;
var
  old : string;
begin
  old := doGetRollls(wa_id, ma_id);

  SetQry.ParamByName('MW_ROLLE').AsString := DBMod.AddRole(newRolls, old );
  SetQry.ParamByName('WA_ID').AsInteger   := wa_id;
  SetQry.ParamByName('MA_ID').AsInteger   := ma_id;
  SetQry.ExecSQL;

  Result := SetQry.RowsAffected > 0;
end;

class function TRollenMod.getRolls(wa_id, ma_id: integer): string;
var
  RollenMod: TRollenMod;
begin
  RollenMod := TRollenMod.Create(nil);
  Result := RollenMod.doGetRollls(wa_id, ma_id);
  RollenMod.Free;
end;

class function TRollenMod.setRolls(wa_id, ma_id: integer;
  newRolls: string): boolean;
var
  RollenMod: TRollenMod;
begin
  RollenMod := TRollenMod.Create(nil);
  Result := RollenMod.DoSetRolls(wa_id, ma_id, newRolls);
  RollenMod.Free;
end;

end.
