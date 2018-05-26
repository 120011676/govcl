// Ϊ�˼���Lazarus��Delphi������Դ����������ͼƬ��ȡ�Ĵ���
// ������Delphi��TPngImage��û��Size��ʶ�ģ���Lazarus��һ����
// ����ֻ�ܽ����޸ģ�ͳһ����ͼƬSize��ʶ������Delphi��ȡʱ�����жϺ�������ص�

unit uImages;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,
  Vcl.Imaging.GIFImg,
  Vcl.Imaging.GIFConsts;

type

  TPngImage = class(Vcl.Imaging.pngimage.TPngImage)
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  end;


  TGIFImage = class(Vcl.Imaging.GIFImg.TGIFImage)
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  end;

implementation



{ TPngImage }

procedure TPngImage.ReadData(Stream: TStream);
const
  PngHeader: Array[0..7] of AnsiChar = (#137, #80, #78, #71, #13, #10, #26, #10);
var
  LHeader: array[0..7] of AnsiChar;
begin
  Stream.Read(LHeader[0], 8);
  if CompareMem(@PngHeader[0], @LHeader[0], 8) then
    Stream.Position := Stream.Position - 8
  else
    Stream.Position := Stream.Position - 4;
  inherited;
end;

procedure TPngImage.WriteData(Stream: TStream);
var
  Size: Longint;
  LMem: TMemoryStream;
begin
  LMem := TMemoryStream.Create;
  try
    SaveToStream(LMem);
    Size := LMem.Size;
    Stream.Write(Size, Sizeof(Size));
    if Size > 0 then
      Stream.Write(LMem.Memory^, Size);
  finally
    LMem.Free;
  end;
end;

{ TGIFImage }

procedure TGIFImage.ReadData(Stream: TStream);
const
  GifHeader: array[0..2] of Byte = ($47, $49, $46);
var
  LHeader: array[0..2] of Byte;
begin
  Stream.Read(LHeader[0], 3);

  if CompareMem(@GifHeader[0], @LHeader[0], 3) then
    Stream.Position := Stream.Position - 3
  else
    Stream.Position := Stream.Position + 1;
  inherited;
end;

procedure TGIFImage.WriteData(Stream: TStream);
var
  Size: Longint;
  LMem: TMemoryStream;
begin
  LMem := TMemoryStream.Create;
  try
    SaveToStream(LMem);
    Size := LMem.Size;
    Stream.Write(Size, Sizeof(Size));
    if Size > 0 then
      Stream.Write(LMem.Memory^, Size);
  finally
    LMem.Free;
  end;
end;

initialization
   TPicture.UnregisterGraphicClass(Vcl.Imaging.pngimage.TPngImage);
   TPicture.UnregisterGraphicClass(Vcl.Imaging.GIFImg.TGIFImage);

   // ����ע��
   TPicture.RegisterFileFormat('PNG', 'Portable Network Graphics', TPngImage);
   TPicture.RegisterFileFormat('GIF', sGIFImageFile, TGIFImage);

finalization


end.
