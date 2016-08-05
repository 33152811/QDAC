object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'JSON Viewer'
  ClientHeight = 667
  ClientWidth = 1231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1231
    Height = 29
    ButtonHeight = 23
    ButtonWidth = 24
    Caption = 'ToolBar1'
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object TBOpen: TToolButton
      Left = 0
      Top = 0
      Hint = 'Open file'
      Caption = 'TBOpen'
      ImageIndex = 0
      OnClick = TBOpenClick
    end
    object TBPaste: TToolButton
      Left = 24
      Top = 0
      Hint = 'Paste|Inserts Clipboard contents'
      Caption = '&Paste'
      ImageIndex = 1
      OnClick = EditPaste1Execute
    end
    object TBCopy: TToolButton
      Left = 48
      Top = 0
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      Caption = '&Copy'
      ImageIndex = 4
      OnClick = EditCopy1Execute
    end
    object TBClear: TToolButton
      Left = 72
      Top = 0
      Hint = 'Delete|Erases the selection'
      Caption = '&Delete'
      ImageIndex = 5
      OnClick = EditDelete1Execute
    end
    object ToolButton1: TToolButton
      Left = 96
      Top = 0
      Width = 48
      Caption = 'ToolButton1'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object ESearch: TEdit
      Left = 144
      Top = 0
      Width = 232
      Height = 23
      TabOrder = 0
    end
    object BtnFindNode: TToolButton
      Left = 376
      Top = 0
      Caption = 'BtnFindNode'
      ImageIndex = 6
      OnClick = BtnFindNodeClick
    end
    object ToolButton3: TToolButton
      Left = 400
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object TBGeneration: TToolButton
      Left = 408
      Top = 0
      Hint = #1058#1077#1089#1090#1086#1074#1072#1103' '#1075#1077#1085#1077#1088#1072#1094#1080#1103
      Caption = 'TBGeneration'
      ImageIndex = 7
      OnClick = TBGenerationClick
    end
  end
  object JSONTreeViewer: TTreeView
    Left = 0
    Top = 29
    Width = 1231
    Height = 619
    Align = alClient
    Indent = 19
    TabOrder = 1
    OnClick = JSONTreeViewerClick
    OnEdited = JSONTreeViewerEdited
    OnExpanding = JSONTreeViewerExpanding
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 648
    Width = 1231
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object OpenDialog1: TOpenDialog
    Filter = 'json|*.json|txt|*.txt|All|*.*'
    InitialDir = 'C:\'
    Left = 504
    Top = 104
  end
  object ImageList1: TImageList
    Height = 17
    Width = 17
    Left = 424
    Top = 104
    Bitmap = {
      494C010108005400540011001100FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000440000003300000001002000000000003036
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D4000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D40080ACC5964D92BAFF80ACC596C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400000000000000000000000000000000000000000000000000000000008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D40084AEC68C4D92BAFF8DB7E0FF4D92
      BAFFC8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D4000000000000000000000000000000
      000000000000000000000000000080000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D40084AE
      C68C5294BBF58DB7E0FF4D92BAFF80ACC596C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400000000000000000000000000000000000000000000000000000000008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8D0D400C8D0D400C8D0D400C8D0D400DDCABAFFC2A2
      88FFC2A288FFC2A288FFB5A89D465294BBF58DB7E0FF5294BBF584AEC68CC8D0
      D400C8D0D400C8D0D400C8D0D4005BA9EB8B098CFDF45BA9EB8B52A6ED960089
      FFFF52A6ED96058BFEF91D93F9DA2C99F6C759A9EC8D078CFDF651A6EE9852A6
      ED960089FFFF52A6ED96C8D0D400C8D0D4000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8D0D400C8D0
      D400C8D0D400DDCABAFFC2A288FFC6BDB180C6BCB180E1D3C5FFC09E83FF959C
      9CFF5294BBF584AEC68CC8D0D400C8D0D400C8D0D400C8D0D400C8D0D400098C
      FDF4F4FAFFFF098CFDF476C0FFFFFFFFFFFF76C0FFFFF9FCFFFFDAEEFFFFC7E5
      FFFF078CFDF6F6FBFFFF97D0FFFF6EBCFFFFFFFFFFFF0089FFFFC8D0D400C8D0
      D4000000000000000000FFFFFF00000000000000000000000000000000008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8D0D400C8D0D400DDCABAFFC2A288FFCAC0B680CBC1
      B780CAC0B680C9BEB480C9BFB480C09E83FFB5A89D46C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400098CFDF4F4FAFFFF098CFDF4EEF7FFFFF4FA
      FFFF76C0FFFFE8F4FFFF128FFBE82C99F6C7038AFFFFF9FCFFFFB6DEFFFFA9D8
      FFFFFBFDFFFF269BFFFF88B9E251C8D0D4000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF000000000000000000FFFF
      FF00800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8D0D400C8D0
      D400C2A288FFCDC4BB80CFC6BE80CFC8BF80CFC6BE80CDC4BB80CAC0B680E2D5
      C7FFC2A288FFC8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400098C
      FDF4F4FAFFFF98D0FFFF76C0FFFFF4FAFFFF76C0FFFFF9FCFFFFDAEEFFFFC7E5
      FFFF9ED3FFFFE4F3FFFFDCEFFFFFE3F2FFFFCDE8FFFFB9DFFFFF369CF3BAC8D0
      D4000000000000000000FFFFFF00000000000000000000000000000000008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8D0D400C8D0D400C2A288FFD0C9C180D3CDC680D4CF
      C880D3CDC680D0C9C180CDC4BB80C9BEB480C2A288FFC8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400078CFDF6F6FBFFFFEEF7FFFF098CFDF4F4FA
      FFFF76C0FFFFE8F4FFFF128FFBE80C8FFFFFEDF7FFFF77C0FFFFBAE0FFFFBAE0
      FFFF55B0FFFFE3F2FFFF1691FAE3C8D0D4000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8D0D400C8D0
      D400C2A288FFD3CDC680D7D3CC80D8D5D080D7D3CC80D3CDC680CFC6BE80E5D8
      CCFFC2A288FFC8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D4000D8E
      FCEEEEF7FFFF43A8FFFF128FFBE8E8F4FFFF43A8FFFFF4FAFFFFDAEEFFFFCBE7
      FFFFAAD8FFFF0C8FFFFF65B8FFFF65B8FFFF1F94F8D7D7EDFFFF1794FFFFC8D0
      D4000000000000000000FFFFFF000000000000000000FFFFFF00000000008000
      0000800000008000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8D0D400C8D0D400DDCABAFFC2A288FFD8D5D080DBD9
      D680D8D5D080D4CFC880CFC8BF80C2A288FFB5A89D46C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D40060ABEA850D8EFCEE60ABEA8564ADE97F128F
      FBE85BA9EB8B098CFDF41D93F9DA2997F6CB42A0F1AB94BEDF4278B4E56678B4
      E56672B1E76E1F94F8D772B1E76EC8D0D4000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8D0D400C8D0
      D400C8D0D400DDCABAFFC2A288FFD8D5D080D7D3CC80D3CDC680C2A288FFB5A8
      9D46C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D4000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8D0D400C8D0D400C8D0D400C8D0D400DDCABAFFC2A2
      88FFC2A288FFC2A288FFDDCABAFFC8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D40000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004793D7D13189D8F73188D8F73189D8F73189D8F73189D8F73189D8F73189
      D8F73189D8F73189D8F73189D8F73188D8F73189D8F74793D7D1C8D0D400C8D0
      D400C8D0D4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000348ED9FBDCF0FAFF97E1F6FF94E0
      F6FF91DFF6FF8DDEF5FF88DCF5FF84DAF4FF7FD9F4FF79D7F3FF73D5F3FF6FD3
      F2FFC1EAF8FF3493DAFFC8D0D400C8D0D400C8D0D40000000000000000000000
      0000000000000000000000000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003995DAF7EFFAFEFF92E5F8FF8EE4F8FF88E3F8FF81E1F7FF79DFF7FF70DE
      F6FF66DBF5FF5AD8F4FF4CD4F3FF3FD1F2FFCAF2FBFF3493DAFFC8D0D400C8D0
      D400C8D0D4000000000000000000000000000000000000000000000000008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      000080000000800000008000000000000000399BDAF8F2FAFDFF93E6F8FF91E5
      F8FF8FE5F8FF8AE3F8FF85E2F7FF7EE1F7FF76DEF6FF6BDCF6FF5DD9F4FF4ED5
      F3FFCCF2FBFF3493DAFFC8D0D400C8D0D400C8D0D40000000000868686000080
      800086868600008080008686860080000000FFFFFF0000000000000000000000
      0000000000000000000000000000FFFFFF008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000000000
      000038A1DAF9F6FCFEFF93E5F8FF92E5F8FF92E5F8FF90E5F8FF92DBE9FF92D7
      E3FF92D2DCFF8FCED7FF8BC8CFFF85C0C5FFC9D8D6FF3493DAFFC47B50E8CA83
      59F1C8D0D4000000000000808000868686000080800086868600008080008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF00800000000000000039A6DAFAFEFFFFFFF8FDFFFFF6FD
      FFFFF5FCFFFFF3FCFEFF99E4F4FF99E6F7FF9AE6F6FF9CE5F5FF9DE5F5FF9EE5
      F4FFDAF3F8FF3493DAFFFDF4EEFFCA8156F9C8D0D40000000000868686000080
      800086868600008080008686860080000000FFFFFF0000000000000000000000
      0000FFFFFF008000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000000000
      000037ABDAFAE8F6FBFF6FBBE7FF54A9E2FF4CA4E0FF90C9EBFFFAF3EFFFFDFE
      FDFFFFFDFCFFFFFDFCFFFEFDFCFFFEFCFBFFFEFEFDFF3493DAFFEFF2E8FFCE80
      55FFC8D0D4000000000000808000868686000080800086868600008080008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0080000000000000003CABDAF2F1FAFDFF93DEF5FF92DC
      F4FF63BBE9FF3493DAFF3493DAFF3493DAFF3493DAFF3493DAFF3493DAFF3493
      DAFF3493DAFF3493DAFFFBF6EFFFCC8255FEC8D0D40000000000868686000080
      800086868600008080008686860080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000000000
      00003DB0DAF0F7FCFEFF8DE4F8FF90DEF5FF9EE0F5FFABE1F6FFCA8351FFFFF7
      F1FFFFE9D9FFFFEADBFFFFE9D9FFFFE7D7FFFFE5D2FFFFE2CBFFFFF7F1FFCB84
      55FEC8D0D4000000000000808000868686000080800086868600008080008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000FFFFFF000000000000000000FFFFFF008000
      00008000000080000000800000000000000039B3DAF8FDFEFEFFFEFFFFFFFEFE
      FFFFFDFEFFFFFEFFFFFFE4B990FFFFF7F0FFFFE7D5FFFDE7D6FFFDE6D4FFFCE4
      D0FFFBE3CBFFFADCC1FFFEF3E8FFCC8555FEC8D0D40000000000868686000080
      8000868686000080800086868600008080008686860000808000868686000080
      8000868686000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF0080000000000000000000
      00004EB8D8D05FC1E1FA61C2E2FA61C2E2FA61C2E2FA60C2E2FAE4BA90FFFFF7
      F2FFFEE7D5FFFEE7D5FFFDE5D1FFFAE0CAFFF9DEC3FFF7D9BBFFFDF2E7FFCC86
      56FEC8D0D4000000000000808000868686000000000000000000000000000000
      0000000000000000000000000000000000008686860086868600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008000
      000080000000000000000000000000000000C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400E4BA91FFFEF7F1FFFCE5D2FFFCE4D1FFFBE2CCFFF9DD
      C3FFF6D7BAFFF3D1AEFFFAEFE4FFCC8657FEC8D0D40000000000868686008686
      8600000000000000000000000000000000000000000000000000000000000000
      0000868686000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000FFFFFF0000000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400E4BA91FFFEF6
      F0FFFCE2CDFFFCE3CDFFFADFC8FFF7D9BBFFF5E9DDFFFAF3EBFFFBF8F3FFCA82
      53FEC8D0D400000000000080800086868600008080000000000000FFFF000000
      00000000000000FFFF0000000000868686000080800086868600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400E4BA92FFFEF5EDFFFCDEC4FFFBE0C7FFF9DCC1FFF5D3
      B3FFFEF9F3FFFAE2C3FFECC092FFC5A08393C8D0D40000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400E5BD95FFFFFF
      FEFFFDF3E9FFFDF3EAFFFCF2E8FFFAEFE3FFFAF2E7FFEABA87FFCD9B7AB3C7CB
      CD0CC8D0D4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400EAC29CFFE6BE95FFE4BA91FFE4BA91FFD1A16FF5D09F
      70F6CB9E6FDAC6A58B7EC7CCCF09C8D0D400C8D0D40000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E00000028000000440000003300000001000100
      00000000640200000000000000000000000000000000000000000000FFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FFFFFFFFC000000000000000FFFFFFFFC0000000
      00000000FFFFFFFFC000000000000000FE00F7FEC000000000000000FE00E3FF
      C000000000000000FE00E1FDC0000000000000008000F1FBC000000000000000
      8000F8F3C0000000000000008000FC67C0000000000000008000FE0FC0000000
      000000008001FF1FC0000000000000008003FE0FC0000000000000008007FC67
      C000000000000000807FF0F3C00000000000000080FFE1F9C000000000000000
      81FFE3FEC000000000000000FFFFFFFFC00000000000000000007FFFFFFFFFFF
      F000000000007FFFFFFFFFFFF000000000007E007FFFFFFFF000000000004000
      7BFF7FC0100000000000000071FFFFC0100000000000000070FEFFC010000000
      0000000078FDF0001000000000000000FC79F0001000000000000001FE33F000
      1000000000000001FF07F0001000000000000001FF8FF0003000000000000001
      FF07F00070000000000007E1FE33F000F000000000000001F879F00FF0000000
      00004003F0FCF01FF000000000007C3FF1FF703FF000000000007FFFFFFFFFFF
      F000000000000000000000000000000000000000000000000000}
  end
end