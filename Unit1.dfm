object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ffmpeg params'
  ClientHeight = 427
  ClientWidth = 1117
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDragOver = FormDragOver
  DesignSize = (
    1117
    427)
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 8
    Width = 50
    Height = 13
    Caption = 'Input Files'
  end
  object Label2: TLabel
    Left = 15
    Top = 213
    Width = 34
    Height = 13
    Caption = 'Output'
  end
  object Memo1: TMemo
    Left = 8
    Top = 27
    Width = 845
    Height = 174
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Memo2: TMemo
    Left = 8
    Top = 229
    Width = 849
    Height = 190
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 863
    Top = 0
    Width = 254
    Height = 427
    Align = alRight
    TabOrder = 2
    object Label6: TLabel
      Left = 23
      Top = 48
      Width = 45
      Height = 13
      Caption = 'Log Level'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 22
      Top = 99
      Width = 70
      Height = 13
      Caption = 'Input switches'
    end
    object Label4: TLabel
      Left = 21
      Top = 155
      Width = 79
      Height = 13
      Caption = 'Output Switches'
    end
    object Label5: TLabel
      Left = 21
      Top = 213
      Width = 103
      Height = 13
      Caption = 'Output File Extension'
    end
    object btnClear: TButton
      Left = 16
      Top = 12
      Width = 97
      Height = 25
      Caption = 'Clear Both'
      TabOrder = 0
      OnClick = btnClearClick
    end
    object edtLogLevel: TEdit
      Left = 16
      Top = 62
      Width = 225
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '-loglevel error'
    end
    object edtInputSwitches: TEdit
      Left = 16
      Top = 112
      Width = 225
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '-i'
    end
    object cbOutputSwitches: TComboBox
      Left = 16
      Top = 170
      Width = 225
      Height = 24
      DropDownCount = 99
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '-c copy'
    end
    object edtFileExt: TEdit
      Left = 16
      Top = 228
      Width = 57
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '.mp4'
    end
    object chbOverwrite: TCheckBox
      Left = 12
      Top = 267
      Width = 141
      Height = 17
      Caption = 'Overwrite batch file'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object btnGo: TButton
      Left = 6
      Top = 345
      Width = 241
      Height = 70
      Caption = 'Go'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = btnGoClick
    end
    object chbRunBat: TCheckBox
      Left = 12
      Top = 298
      Width = 141
      Height = 17
      Caption = 'Run batch file'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
  end
end
