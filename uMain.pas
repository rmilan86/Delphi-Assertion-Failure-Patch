(************************************************************)
(* Delphi Assertion Failure Patch                           *)
(* by Robert Milan (03/22/13)                               *)
(************************************************************)
(* This code is provided "as is" without express or         *)
(* implied warranty of any kind. Use it at your own risk.   *)
(************************************************************)

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{
   This is a file patcher to edit a specific byte in a file to correct a error
      that occurs often in CodeGear 2007.

      Original hex value example:
         01 00 48 [74] 47 80 3D (Byte in brackets needs changed)

      Starts at address:
         00 00 00 00 - 00 03 66 B0

      Address to access:
         00 00 00 00 - 00 03 66 B8

      New hex values:
         01 00 48 [EB] 47 80 3D


      [74] needs to be replaced with [EB]
}

procedure TForm1.Button1Click(Sender: TObject);
const
   FSize    : Cardinal = $75800;     // Size of the dll in hex

   dwOffset : DWORD = $366B8;       // Address to locate
   nByte    : Byte = $EB;           // Byte to write (Short Jump)
var
   OD       : TOpenDialog;          // Open File Dialog Box

   F        : File of Byte;         // File Handle
   FName    : AnsiString;           // File Name
begin

   { Create open dialog object }
   OD := TOpenDialog.Create(nil);

   { Only search for ".dll" files }
   OD.Filter := 'bordbk105N.dll|*.dll';

   { Show the dialog box }
   OD.Execute(0);

   { Get the path and name of the file selected }
   FName := OD.FileName;

   { Destroy the object }
   OD.Destroy;

   { Check if the file exists }
   if (FileExists(FName) = true) then
   begin
      { Open file }
      AssignFile(F, FName);

      { Open the file for read and write }
      FileMode := 2;
      Reset(F);

      { Check if the file size is correct to make sure we have the right version }
      if (FileSize(F) <> FSize) then
      begin
         MessageBox(0, PAnsiChar('Wrong version of file!'), PAnsiChar(Self.Caption), MB_ICONWARNING);
         CloseFile(F);
         exit;
      end;

      { Create a backup of the file }
      CopyFile(PAnsiChar(FName), PAnsiChar(FName + '.bak'), True);

      { Find address }
      Seek(F, dwOffset);

      { Patch old byte "74" with new byte "EB" }


      {
         What you are doing is replacing a
            JUMP IF ZERO "JZ" to a SHORT JMP to the next relative instruction
      }
      Write(F, nByte);

      { Close file }
      CloseFile(F);

      MessageBox(0, PAnsiChar('Backup of dll created and file was patched!'), PAnsiChar(Self.Caption), 64);
   end else
   begin
      MessageBox(0, PAnsiChar('Unable to patch the file!'), PAnsiChar(Self.Caption), MB_ICONWARNING);
   end;
end;

end.
