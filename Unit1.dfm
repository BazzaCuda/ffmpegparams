object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ffmpeg params'
  ClientHeight = 506
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
    506)
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 50
    Height = 13
    Caption = 'Input Files'
  end
  object Label2: TLabel
    Left = 16
    Top = 299
    Width = 83
    Height = 13
    Caption = 'Output Batch File'
  end
  object Label3: TLabel
    Left = 16
    Top = 203
    Width = 70
    Height = 13
    Caption = 'Input switches'
  end
  object Label4: TLabel
    Left = 16
    Top = 250
    Width = 79
    Height = 13
    Caption = 'Output Switches'
  end
  object Memo1: TMemo
    Left = 8
    Top = 27
    Width = 956
    Height = 174
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Memo2: TMemo
    Left = 8
    Top = 318
    Width = 956
    Height = 180
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 970
    Top = 0
    Width = 147
    Height = 506
    Align = alRight
    TabOrder = 2
    ExplicitTop = -8
    ExplicitHeight = 510
    object Label6: TLabel
      Left = 19
      Top = 278
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
    object Label5: TLabel
      Left = 19
      Top = 322
      Width = 103
      Height = 13
      Caption = 'Output File Extension'
    end
    object btnClear: TButton
      Left = 7
      Top = 25
      Width = 133
      Height = 25
      Caption = 'Clear Both Boxes'
      TabOrder = 0
      OnClick = btnClearClick
    end
    object edtLogLevel: TEdit
      Left = 12
      Top = 292
      Width = 124
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
    object edtFileExt: TEdit
      Left = 12
      Top = 338
      Width = 57
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '.mp4'
    end
    object chbOverwrite: TCheckBox
      Left = 12
      Top = 369
      Width = 141
      Height = 17
      Caption = 'Overwrite batch file'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object btnGo: TButton
      Left = 7
      Top = 425
      Width = 133
      Height = 70
      Caption = 'Go'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnGoClick
    end
    object chbRunBat: TCheckBox
      Left = 12
      Top = 400
      Width = 141
      Height = 17
      Caption = 'Run batch file'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
  end
  object edtInputSwitches: TEdit
    Left = 8
    Top = 220
    Width = 956
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '-i'
  end
  object cbOutputSwitches: TComboBox
    Left = 8
    Top = 267
    Width = 956
    Height = 24
    DropDownCount = 99
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = '-c copy'
  end
end
