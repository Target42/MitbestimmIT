unit u_imageinfo;

interface

uses
  System.Classes, System.SysUtils;

type
  TImageInfo = class(TPersistent)
  public
    FileName: string;
    Data: TBytes;
  end;

implementation

end.

