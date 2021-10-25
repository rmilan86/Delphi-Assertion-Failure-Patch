object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Delphi - Assertion Failure Patch'
  ClientHeight = 153
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 409
    Height = 25
    AutoSize = False
    Caption = 
      'This patch was created to fix the error that occurs in CodeGear ' +
      'Delphi 2007. It may work on other versions but has only been tes' +
      'ted on CodeGear Delphi 2007.               '
    WordWrap = True
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 409
    Height = 51
    AutoSize = False
    Caption = 
      'To use this patch just hit the button below and search and find ' +
      'the file to patch. It is normally located in "C:\Program Files (' +
      'x86)\CodeGear\RAD Studio\5.0\bin and named "bordbk105N.dll". The' +
      ' name may differ based on your version of CodeGear.'
    WordWrap = True
  end
  object Button1: TButton
    Left = 8
    Top = 105
    Width = 409
    Height = 41
    Caption = 'Patch'
    TabOrder = 0
    OnClick = Button1Click
  end
end
