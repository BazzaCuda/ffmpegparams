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
    Label3: TLabel;
    edtInputSwitches: TEdit;
    Label4: TLabel;
    cbOutputSwitches: TComboBox;
    Label5: TLabel;
    edtFileExt: TEdit;
    chbOverwrite: TCheckBox;
    btnClearOutput: TButton;
    btnGo: TButton;
    procedure btnGoClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnClearOutputClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
  private
    function saveToFile(aPath: string): boolean;
    function formatFileSize(const aSize: int64): string;
    function getFileSize(const aFilePath: string): int64;
    function longestLine: integer;
    procedure WMDropFiles(var msg: TWMDropFiles); message WM_DROPFILES;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses winAPI.shellAPI;

{$R *.dfm}

procedure TForm1.btnClearClick(Sender: TObject);
begin
  memo1.clear;
  memo2.clear;
end;

procedure TForm1.btnClearOutputClick(Sender: TObject);
begin
  memo2.clear;
end;

function TForm1.saveToFile(aPath: string): boolean;
const
  convert = 'zzz_convert';
begin
  case chbOverwrite.checked of TRUE: memo2.lines.saveToFile(aPath + convert + '.bat'); end;
  case chbOverwrite.checked of TRUE: EXIT; end;

  var i: integer := 0;
  var FN: string;
  FN := convert + '.bat';
  while fileExists(aPath + FN) do begin
    inc(i);
    FN := convert + intToStr(i) + '.bat';
  end;
  memo2.lines.saveToFile(aPath + FN);
end;

function TForm1.formatFileSize(const aSize: int64): string;
begin
 case aSize >= 1052266987 of  TRUE: try result := format('%.3f GB', [aSize / 1024 / 1024 / 1024]); except end;  // >= 0.98 of 1GB
                             FALSE: case aSize < 1024 * 1024 of  TRUE: try result := format('%d KB', [trunc(aSize / 1024)]); except end;
                                                                FALSE: try result := format('%.2f MB', [aSize / 1024 / 1024]); except end;end;end;
end;

function TForm1.getFileSize(const aFilePath: string): int64;
var
  vHandle:  THandle;
  vRec:     TWin32FindData;
begin
  vHandle := findFirstFile(PChar(aFilePath), vRec);
  case vHandle <> INVALID_HANDLE_VALUE of TRUE: begin
                                                  winAPI.windows.findClose(vHandle);
                                                  case (vRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 of TRUE:
                                                    result := (int64(vRec.nFileSizeHigh) shl 32) + vRec.nFileSizeLow; end;end;end;
end;

function TForm1.longestLine: integer;
begin
  result := 90;
  for var i := 0 to memo2.lines.count - 1 do
    case (pos(':::', memo2.lines[i]) > 0) AND (length(memo2.lines[i]) > result) of TRUE: result := length(memo2.lines[i]); end;
end;

procedure TForm1.btnGoClick(Sender: TObject);
var
  FN: string;
begin
  memo2.clear;
  memo2.lines.loadFromFile(changeFileExt(paramStr(0), '.bat'));
  for var i := memo1.lines.count - 1 downto 0 do begin
    FN := changeFileExt(memo1.lines[i], '');
    FN := FN + ' [c]' + edtFileExt.text;
    var ff := format('@ffmpeg %s %s "%s" %s "%s"', [edtLogLevel.text, edtInputSwitches.text, memo1.lines[i], cbOutputSwitches.text, FN]);
    memo2.lines.insert(6, '@echo.');
    memo2.lines.insert(6, '@echo ::: ' + extractFileName(memo1.lines[i]) + ': ' + formatFileSize(getFileSize(memo1.lines[i])));
    memo2.lines.insert(7, ff);
  end;
  memo2.lines.insert(3, 'mode con cols=' + intToStr(longestLine + 6));

  var FP := extractFilePath(memo1.lines[0]);
  saveToFile(FP);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DragAcceptFiles(handle, True);
  case fileExists(changeFileExt(paramStr(0), '.ini')) of TRUE: cbOutputSwitches.Items.loadFromFile(changeFileExt(paramStr(0), '.ini')); end;
  cbOutputSwitches.itemIndex := cbOutputSwitches.items.count - 1;
end;

procedure TForm1.FormDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := TRUE;
end;

procedure TForm1.WMDropFiles(var msg: TWMDropFiles);
// Allow a media file to be dropped onto the window.
// The playlist will be entirely refreshed using the contents of this media file's folder.
var vFilePath: string;
begin
  inherited;
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
  msg.result := 0;
end;


end.
