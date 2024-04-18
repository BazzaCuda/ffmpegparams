{   Minimalist Media Player
    Copyright (C) 2021 Baz Cuda
    https://github.com/BazzaCuda/ffmpegparams

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307, USA
}
unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Memo2: TMemo;
    Label2: TLabel;
    Panel1: TPanel;
    btnClear: TButton;
    Label6: TLabel;
    edtLogLevel: TEdit;
    Label5: TLabel;
    edtFileExt: TEdit;
    chbOverwrite: TCheckBox;
    btnGo: TButton;
    chbRunBat: TCheckBox;
    Label3: TLabel;
    edtInputSwitches: TEdit;
    Label4: TLabel;
    cbOutputSwitches: TComboBox;
    lblCmdLineExe: TLabel;
    cbCmdLineExe: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnGoClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure cbCmdLineExeChange(Sender: TObject);
  private
    cmdLineExe: string;
    function  beginBatFile: boolean;
    function  closeBatFile: boolean;
    function  findINIFiles(FP: string): string;
    function  getBatFN(aPath: string): string;
    function  getOutputFN(inputFN: string; ext: string): string;
    function  loadINIFile(FP: string; exeName: string): string;
    function  longestLine: integer;
    function  noAmps(FN: string): string;
    function  processInputFN(inputFN: string; fileNum: integer; maxFiles: integer): boolean;
    function  removeInvalidFNs: boolean;
    function  runBatFile(FN: string; run: boolean): boolean;
    function  saveBatFile(aFilePath: string): string;
    function  setCaption(cmdLineExe: string): boolean;
    function  setLogLevel(cmdLineExe: string): boolean;
    procedure WMDropFiles(var msg: TWMDropFiles); message WM_DROPFILES;
  public
  end;

var
  Form1: TForm1;

implementation

uses winAPI.shellAPI, system.strUtils;

const
  FFMPEG = 'ffmpeg';

function formatFileSize(const aSize: int64): string;
begin
 case aSize >= 1052266987 of  TRUE: try result := format('%.3f GB', [aSize / 1024 / 1024 / 1024]); except end;  // >= 0.98 of 1GB
                             FALSE: case aSize < 1024 * 1024 of  TRUE: try result := format('%d KB', [trunc(aSize / 1024)]); except end;
                                                                FALSE: try result := format('%.2f MB', [aSize / 1024 / 1024]); except end;end;end;
end;

function getFileSize(const aFilename: String): int64;
var
  info: TWin32FileAttributeData;
begin
  result := 0;

  case GetFileAttributesEx(PWideChar(aFileName), getFileExInfoStandard, @info) of FALSE: EXIT; end;

  int64Rec(result).hi := info.nFileSizeHigh;
  int64Rec(result).lo := info.nFileSizeLow;
end;

function shiftKeyDown: boolean;
var vShiftState: TShiftState;
begin
  vShiftState   := KeyboardStateToShiftState;
  result := ssSHIFT in vShiftState;
end;

{$R *.dfm}

function TForm1.beginBatFile: boolean;
begin
  memo2.lines.beginUpdate;
  memo2.clear;
  memo2.lines.loadFromFile(changeFileExt(paramStr(0), '.bat'));
end;

procedure TForm1.btnClearClick(Sender: TObject);
begin
  memo1.clear;
end;

procedure TForm1.btnGoClick(Sender: TObject);
var
  FN: string;
begin
  beginBatFile;

  case removeInvalidFNs of FALSE: EXIT; end;

  for var i := memo1.lines.count - 1 downto 0 do processInputFN(memo1.lines[i], i + 1, memo1.lines.count);

  var FP := extractFilePath(memo1.lines[0]);

  FN := getBatFN(FP);

  closeBatFile;

  saveBatFile(FN);

  runBatFile(FN, chbRunBat.checked);
end;

procedure TForm1.cbCmdLineExeChange(Sender: TObject);
begin
  cmdLineExe := loadINIFile(extractFilePath(paramStr(0)), cbCmdLineExe.items[cbCmdLineExe.itemIndex]);
  setCaption(cmdLineExe);
  setLogLevel(cmdLineExe);
end;

function TForm1.closeBatFile: boolean;
begin
  memo2.lines.add('(goto) 2>nul & del "%~f0"');
  memo2.lines.endUpdate;
end;

function TForm1.findINIFiles(FP: string): string;
var
  SR: TSearchRec;
  RC: integer;
begin
  cbCmdLineExe.items.clear;

  RC := findFirst(FP + '*.ini', faAnyFile - faDirectory - faSysFile - faHidden, SR);

  while RC = 0 do begin
    cbCmdLineExe.items.add(copy(SR.name, 1, length(SR.name) - 4));
    RC := findNext(SR);
  end;

  lblCmdLineExe.visible  := cbCmdLineExe.items.count > 1;
  cbCmdLineExe.visible   := cbCmdLineExe.items.count > 1;
  cbCmdLineExe.itemIndex := cbCmdLineExe.items.indexOf(FFMPEG);

  result := loadINIFile(FP, FFMPEG);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DragAcceptFiles(handle, True);
  case fileExists(changeFileExt(paramStr(0), '.ini')) of TRUE: renameFile(changeFileExt(paramStr(0), '.ini'), extractFilePath(paramStr(0)) + 'ffmpeg.ini'); end; // rename legacy ini
  cmdLineExe := findINIFiles(extractFilePath(paramStr(0)));
  setCaption(cmdLineExe);
end;

procedure TForm1.FormDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := TRUE;
end;

function TForm1.getBatFN(aPath: string): string;
const
  convert = 'zzz_convert';
begin
  result := aPath + convert + '.bat';
  case chbOverwrite.checked of TRUE: memo2.lines.saveToFile(aPath + convert + '.bat'); end;
  case chbOverwrite.checked of TRUE: EXIT; end;

  var i: integer := 0;
  var FN: string;
  FN := convert + '.bat';
  while fileExists(aPath + FN) do begin
    inc(i);
    FN := convert + intToStr(i) + '.bat';
  end;
  result := aPath + FN;
end;

function TForm1.getOutputFN(inputFN: string; ext: string): string;
begin
  result := changeFileExt(inputFN, '');
  result := result + ' [c]' + ext;
end;

function TForm1.loadINIFile(FP: string; exeName: string): string;
begin
  cbOutputSwitches.clear;
  case fileExists(FP + exeName + '.ini') of TRUE: cbOutputSwitches.items.loadFromFile(FP + exeName + '.ini'); end;
  cbOutputSwitches.itemIndex := cbOutputSwitches.items.count - 1;
  result := exeName;
end;

function TForm1.longestLine: integer;
begin
  result := 90;
  for var i := 0 to memo2.lines.count - 1 do
    case (pos(':::', memo2.lines[i]) > 0) AND (length(memo2.lines[i]) > result) of TRUE: result := length(memo2.lines[i]); end;
end;

function TForm1.noAmps(FN: string): string;
begin
  result := replaceStr(FN, ' & ', ' and ');
  result := replaceStr(FN, '&', 'and');
end;

function TForm1.processInputFN(inputFN: string; fileNum: integer; maxFiles: integer): boolean;
begin
  var FN := getOutputFN(inputFN, edtFileExt.text);

  var ff := format('@%s %s %s "%s" %s "%s"', [cmdLineExe, edtLogLevel.text, edtInputSwitches.text, inputFN, cbOutputSwitches.text, FN]);

  memo2.lines.insert(6, '@echo.');
  var numStr := format('[%.2d/%.2d] ', [fileNum, maxFiles]);
  memo2.lines.insert(6, '@echo ::: ' + numStr + extractFileName(noAmps(inputFN)) + ': ' + formatFileSize(getFileSize(inputFN)));
  memo2.lines.insert(7, ff);
end;

function TForm1.removeInvalidFNs: boolean;
var noAmps: string;
begin
  for var i := memo1.lines.count - 1 downto 0 do
    case (trim(memo1.lines[i]) = '') OR (NOT fileExists(memo1.lines[i])) of TRUE: memo1.lines.delete(i); end;

  result := memo1.lines.count > 0;
end;

function TForm1.runBatFile(FN: string; run: boolean): boolean;
begin
  case run of TRUE: shellExecute(0, 'open', PWideChar('"'  + FN + '"'), '', '', SW_SHOW); end;
end;

function TForm1.saveBatFile(aFilePath: string): string;
begin
  memo2.lines.saveToFile(aFilePath);
end;

function TForm1.setCaption(cmdLineExe: string): boolean;
begin
  caption := cmdLineExe + ' params';
end;

function TForm1.setLogLevel(cmdLineExe: string): boolean;
begin
  case cmdLineExe = FFMPEG of  TRUE: edtLogLevel.text := '-loglevel error';
                              FALSE: edtLogLevel.text := ''; end;
end;

procedure TForm1.WMDropFiles(var msg: TWMDropFiles);
var vFilePath: string;
begin
  inherited;

  case shiftKeyDown of TRUE: memo1.lines.clear; end;

  memo1.lines.beginUpdate;
  var hDrop := msg.Drop;
  try
    var droppedFileCount := dragQueryFile(hDrop, $FFFFFFFF, nil, 0);
    for var i := 0 to pred(droppedFileCount) do begin
      var fileNameLength := dragQueryFile(hDrop, i, nil, 0);
      setLength(vFilePath, fileNameLength);
      dragQueryFile(hDrop, i, PChar(vFilePath), fileNameLength + 1);

      memo1.lines.add(vFilePath);
    end;
  finally
    dragFinish(hDrop);
  end;
  memo1.lines.endUpdate;
  msg.result := 0;
end;

end.
