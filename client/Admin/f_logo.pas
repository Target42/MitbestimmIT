unit f_logo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, fr_base,
  Vcl.ExtDlgs, Vcl.Buttons;

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

implementation

{$R *.dfm}

uses u_stub, u_imageinfo, m_glob;

procedure TLogoForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  info : TImageInfo;
  client : TWahlModClient;
begin
  info := TImageInfo.Create;
  info.FileName := m_filename;

  info.Data := TMemoryStream.Create;
  image1.Picture.SaveToStream(info.Data);
  info.Data.Position := 0;

  client := TWahlModClient.Create(GM.SQLConnection1.DBXConnection);

  client.uploadImage(info);

  client.Free;
  info.Data.Free;
  info.Free;
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
var
  client: TWahlModClient;
  info  : TImageInfo;
begin
  client:= TWahlModClient.Create(GM.SQLConnection1.DBXConnection);

  info := client.getLogo;

  m_filename := info.FileName;
  if not Assigned(info.Data) then
  begin
    Image1.Picture.Graphic := nil;
  end
  else
  begin
    try
      image1.Picture.LoadFromStream(info.Data);
    except
     on e : exception do
     begin
     end;
    end;
    info.Data.Free;
  end;
  client.Free;
end;

end.
