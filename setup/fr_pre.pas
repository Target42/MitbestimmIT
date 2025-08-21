unit fr_pre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TPreFrame = class(TFrame)
    RichEdit1: TRichEdit;
  private
    { Private-Deklarationen }
  public
    procedure prepare;
  end;

implementation

{$R *.dfm}

uses
  u_helper;

{ TPreFrame }

procedure TPreFrame.prepare;
var
  st : TStream;
begin
  st := TMemoryStream.Create;
  LoadRCDataToStream('pre', st );
  st.Position := 0;
  RichEdit1.Lines.LoadFromStream(st);
  st.Free;
end;

end.
