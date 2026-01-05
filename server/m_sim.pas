unit m_sim;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  System.JSON, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  TDSSim = class(TDSServerModule)
    DataQry: TFDQuery;
    FDTransaction1: TFDTransaction;
    DataTab: TFDTable;
  private
    { Private-Deklarationen }
  public
    function getBasisData : TJSONObject;
    function setSimData( data : TJSONObject ) : TJSONObject;
    function Auswertung( data : TJSONObject ) : TJSONObject;
  end;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

uses m_db, u_json, u_simdata;

{$R *.dfm}

{ TDSSim }

function TDSSim.Auswertung(data: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
end;

function TDSSim.getBasisData: TJSONObject;
var
  simdata : TSimData;
begin
  DataQry.ParamByName('WA_ID').AsInteger := DBMod.WahlID;
  DataQry.Open;

  simdata := TSimData.create;
  simdata.IsEmpty := DataQry.IsEmpty;
  if not DataQry.IsEmpty then
  begin
    simdata.BriefWaehler    := DataQry.FieldByName('WD_BRIEF').AsInteger;
    simdata.Waehler         := DataQry.FieldByName('WD_WAEHLER').AsInteger;
    simdata.Doppelt         := DataQry.FieldByName('WD_DOPPELT').AsInteger;
    simdata.Summe           := DataQry.FieldByName('WD_SUMME').AsInteger;
    simdata.Korrektur       := DataQry.FieldByName('WD_KORREKTUR').AsInteger;
    simdata.Wahlzettel      := DataQry.FieldByName('WD_ZETTEL').AsInteger;
    simdata.Invalid_Urne    := DataQry.FieldByName('WD_INVALID_URNE').AsInteger;
    simdata.Invalid_Brief   := DataQry.FieldByName('WD_INVALID_BRIEF').AsInteger;
    simdata.Rem             := DataQry.FieldByName('WD_REM').AsString;
    simdata.Wahlzettel      := DataQry.FieldByName('WD_ZETTEL').AsInteger;

  end;
  DataQry.Close;

  Result := simdata.toJson;

  simdata.Free;
end;

function TDSSim.setSimData(data: TJSONObject): TJSONObject;
var
  simdata : TSimData;
begin
  Result := TJSONObject.Create;

  simdata := TSimData.create;
  simdata.fromJson(data);

  DataTab.Open;
  if not DataTab.Locate('WA_ID', DBMod.WahlID, []) then
  begin
    DataTab.Append;
    DataTab.FieldByName('WA_ID').AsInteger := DBMod.WahlID;
  end
  else
    DataTab.Edit;

  DataTab.FieldByName('WD_BRIEF').AsInteger         := simdata.BriefWaehler;
  DataTab.FieldByName('WD_WAEHLER').AsInteger       := simdata.Waehler;
  DataTab.FieldByName('WD_DOPPELT').AsInteger       := simdata.Doppelt;
  DataTab.FieldByName('WD_SUMME').AsInteger         := simdata.Summe;
  DataTab.FieldByName('WD_KORREKTUR').AsInteger     := simdata.Korrektur;
  DataTab.FieldByName('WD_ZETTEL').AsInteger        := simdata.Wahlzettel;
  DataTab.FieldByName('WD_INVALID_URNE').AsInteger  := simdata.Invalid_Urne;
  DataTab.FieldByName('WD_INVALID_BRIEF').AsInteger := simdata.Invalid_Brief;
  DataTab.FieldByName('WD_REM').AsString            := simdata.Rem;
  DataTab.FieldByName('WD_ZETTEL').AsInteger        := simdata.Summe - simdata.Korrektur - simdata.Invalid_Brief;

  DataTab.Post;

  JResult( Result, true, 'Die Simulationsdaten wurden erfolgreich gespeichert.');

  simdata.Free;
end;

end.

