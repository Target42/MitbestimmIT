unit m_res;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  PngImageList;

type
  TResmod = class(TDataModule)
    PngImageList1: TPngImageList;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Resmod: TResmod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
