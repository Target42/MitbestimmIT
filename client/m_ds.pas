unit m_ds;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Data.SqlExpr, DbxCompressionFilter;

type
  TDSMod = class(TDataModule)
    SQLConnection1: TSQLConnection;
  private
    { Private-Deklarationen }
  public
    function connect : boolean;
  end;

var
  DSMod: TDSMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TDSMod.connect: boolean;
begin

end;

end.
