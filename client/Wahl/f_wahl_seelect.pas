unit f_wahl_seelect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, fr_base,
  u_stub;

type
  TSelectWahlform = class(TForm)
    BaseFrame1: TBaseFrame;
    FDMemTable1: TFDMemTable;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    class function Execute : boolean;
  end;

var
  SelectWahlform: TSelectWahlform;

implementation

{$R *.dfm}

uses m_glob;

{ TSelectWahlform }

class function TSelectWahlform.Execute: boolean;
begin
  Result := false;
  Application.CreateForm(TSelectWahlform, SelectWahlform);
  if ( SelectWahlform.ShowModal = mrOk ) then
  begin

  end;
  SelectWahlform.Free;

end;

procedure TSelectWahlform.FormCreate(Sender: TObject);
begin
  //
end;

end.
