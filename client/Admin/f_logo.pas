unit f_logo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, fr_base,
  Vcl.ExtDlgs, Vcl.Buttons, m_res;

type
  TLogoForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    Image1: TImage;
    BitBtn1: TBitBtn;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_filename : string;
    procedure loadLogo;
  public
    class function execute : boolean;
  end;

var
  LogoForm: TLogoForm;

function DSloadLogo( image : TImage ) : string;

implementation

{$R *.dfm}

uses u_stub, u_imageinfo, m_glob;

function DSloadLogo( image : TImage ) : string;
var
  client: TWahlModClient;
  info: TImageInfo;
  mem: TMemoryStream;
begin
  result := '';
  client := TWahlModClient.Create(GM.SQLConnection1.DBXConnection);
  info := client.getLogo;

  try
    result := info.FileName;

    if Length(info.Data) = 0 then
    begin
      Image.Picture.Graphic := nil;
    end
    else
    begin
      mem := TMemoryStream.Create;
      try
        mem.Write(info.Data[0], Length(info.Data));
        mem.Position := 0; // Wichtig: Setze die Position zum Lesen auf den Anfang

        try
          Image.Picture.LoadFromStream(mem);
        except
          on E: Exception do
          begin
          end;
        end;
      finally
        mem.Free;
      end;
    end;
  except

  end;
  client.Free;
end;

procedure TLogoForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  info : TImageInfo;
  client : TWahlModClient;
  mem    : TMemoryStream;
begin
  Screen.Cursor := crHourGlass;
  try
    info := TImageInfo.Create;
    info.FileName := m_filename;

    mem := TMemoryStream.Create;
    image1.Picture.SaveToStream(mem);
    mem.Position := 0;

    SetLength(info.Data, mem.Size);
    if mem.Size > 0 then
      mem.Read(info.Data[0], mem.Size);
    mem.Free;

    client := TWahlModClient.Create(GM.SQLConnection1.DBXConnection);

    client.uploadImage(info);
  finally
    client.Free;
  end;
  Screen.Cursor := crDefault;
end;

procedure TLogoForm.BitBtn1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    m_filename := OpenPictureDialog1.FileName;
  end;
end;

class function TLogoForm.execute : boolean;
begin
  Application.CreateForm(TLogoForm, LogoForm);
  Result := LogoForm.ShowModal = mrOk;
  LogoForm.Free;
end;

procedure TLogoForm.FormCreate(Sender: TObject);
begin
  loadLogo;
end;

procedure TLogoForm.loadLogo;
begin
  m_filename := DSloadLogo( Image1 );
end;

end.
