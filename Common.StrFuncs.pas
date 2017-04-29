unit Common.StrFuncs;

interface

uses
  System.DateUtils, System.Variants, System.SysUtils, System.Classes,
  Vcl.Dialogs, Vcl.Consts;

const
  mes: array[0..11] of string=
('Январь ','Февраль ','Март ','Апрель ','Май ',
 'Июнь ','Июль ','Август ','Сентябрь ','Октябрь ','Ноябрь ','Декабрь ');

function EncodeBase64(Value: string): string;

function DecodeBase64(Value: string): string;

// период строкой
function GetPeriodStr(aDataStart, aDataEnd: Variant): string;
procedure SetItemsPeriod(aList: TStrings);
function DateOfPeriod(Index: integer): double;

function ShowError ( const aMsg : String ) : Word;
function ShowErrorFmt ( aMsg : String; Args : array of const ) : Word;

function ComponentToString(Component: TComponent): string;
procedure StringToComponent(Component: TComponent; Value: string);

var
  SoundSignalization: Boolean = False;
  SoundStr: array[TMsgDlgType] of string = (
   {mtWarning} '-:2000,1000:80,-:50,1000:80,-:50,1000:80,-:50,-:500,@',
   {mtError} '-:2000,500-700,700-500/20:50,@:10',
   {mtInformation} '-:2000,1000:80,-:50,1000:80,-:50,1000:80,-:50,-:500,@',
   {mtConfirmation} '-:2000,1000:80,-:50,1000:80,-:50,1000:80,-:50,-:500,@',
   {mtCustom} '-:2000,1000:80,-:50,1000:80,-:50,1000:80,-:50,-:500,@'
  );

implementation

uses
  Winapi.Windows, Vcl.Forms;

// кодирование строки алгоритмом Base64
function EncodeBase64(Value: string): string;
const
  b64alphabet: PChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  pad: PChar = '====';

  function EncodeChunk(const Chunk: string): string;
  var
    W: LongWord;
    i, n: Byte;
  begin
    n := Length(Chunk);
    W := 0;
    for i := 0 to n - 1 do
      W := W + Ord(Chunk[i + 1]) shl ((2 - i) * 8);
    Result := b64alphabet[(W shr 18) and $3f] + b64alphabet[(W shr 12) and $3f] + b64alphabet[(W shr 06) and $3f] + b64alphabet[(W shr 00) and $3f];
    if n <> 3 then
      Result := Copy(Result, 0, n + 1) + Copy(pad, 0, 3 - n);   //add padding when out len isn't 24 bits
  end;

begin
  Result := '';
  while Length(Value) > 0 do
  begin
    Result := Result + EncodeChunk(Copy(Value, 0, 3));
    Delete(Value, 1, 3);
  end;
end;

// декодирование строки алгоритмом Base64
function DecodeBase64(Value: string): string;
const
  b64alphabet: PChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

  function DecodeChunk(const Chunk: string): string;
  var
    W: LongWord;
    i: Byte;
  begin
    W := 0;
    Result := '';
    for i := 1 to 4 do
      if Pos(Chunk[i], b64alphabet) <> 0 then
        W := W + Word((Pos(Chunk[i], b64alphabet) - 1)) shl ((4 - i) * 6);
    for i := 1 to 3 do
      Result := Result + Chr(W shr ((3 - i) * 8) and $ff);
  end;

begin
  Result := '';
  if Length(Value) mod 4 <> 0 then
    Exit;
  while Length(Value) > 0 do
  begin
    Result := Result + DecodeChunk(Copy(Value, 0, 4));
    Delete(Value, 1, 4);
  end;
end;

// период строкой
function GetPeriodStr(aDataStart, aDataEnd: Variant): string;
begin
  if VarIsNull(aDataEnd) then
    Result := FormatDateTime('mmmm yyyy "г."', VarToDateTime(aDataStart))
  else
    Result := Format('с %s по %s', [FormatDateTime('mmmm yyyy "г." ', VarToDateTime(aDataStart)), FormatDateTime('mmmm yyyy "г."', VarToDateTime(aDataEnd))]);
end;

procedure SetItemsPeriod(aList: TStrings);
var
  i, j: Integer;
begin
  for j := 2004 to YearOf(Date()) do
  begin
    for i := 0 to 11 do
      with aList do
        Add(mes[i] + IntToStr(j));
  end;
end;

function DateOfPeriod(Index: integer): double;
var
  mes, god, tmp: integer;
begin
  tmp := (Index div 12);
  god := tmp + 2004;
  mes := (Index + 1) - tmp * 12;
  if mes < 10 then
  begin
    Result := StrToDate(Format('01%0:s0%1:d%0:s%2:d', [ FormatSettings.DateSeparator, mes, god ]));
  end
  else
    Result := StrToDate(Format('01%0:s%1:d%0:s%2:d', [ FormatSettings.DateSeparator, mes, god ]));
end;

//-----------------------------------------------------------------------------
function ShowMsg ( const aMsg : String ) : Word;
begin
  Result := MessageDlg ( aMsg, mtInformation, [mbOK], 0 );
end;

//-----------------------------------------------------------------------------
function ShowWarning ( const aMsg : String ) : Word;
begin
  Result := MessageDlg ( aMsg, mtWarning, [mbOK], 0 );
end;

//-----------------------------------------------------------------------------
function ShowError ( const aMsg : String ) : Word;
begin
  Result := Application.MessageBox( PChar( AMsg ), 'Ошибка', MB_OK + MB_ICONSTOP);
end;

//-----------------------------------------------------------------------------
function ShowErrorFmt ( aMsg : String; Args : array of const ) : Word;
begin
  Result := Application.MessageBox(PChar(Format(AMsg, Args)), 'Ошибка', MB_OK + MB_ICONSTOP);
end;

//-----------------------------------------------------------------------------
function ShowErrorDlg ( const aMsg : String; aDlgButtons : TMsgDlgButtons ) : Word;
begin
  Result := MessageDlg ( aMsg, mtError, aDlgButtons, 0 );
end;

//-----------------------------------------------------------------------------
function GetConfirmation(const aMsg: string): Boolean;
begin
  Result := MessageBox(0, PChar(aMsg), PChar(SMsgDlgConfirm), MB_YESNO or
      MB_ICONQUESTION or MB_TASKMODAL) = IDYES;
end;

//-----------------------------------------------------------------------------
function ConfirmWarn(const aMsg: string): Boolean;
begin
  Result := MessageBox(0, PChar(aMsg), PChar(SMsgDlgWarning), MB_YESNO or
      MB_ICONWARNING or MB_DEFBUTTON2 or MB_TASKMODAL) = IDYES;
end;

function ComponentToString(Component: TComponent): string;
var
  ms: TMemoryStream;
  ss: TStringStream;
begin
  ss := TStringStream.Create(' ');
  ms := TMemoryStream.Create;
  try
    ms.WriteComponent(Component);
    ms.position := 0;
    ObjectBinaryToText(ms, ss);
    ss.position := 0;
    Result := ss.DataString;
  finally
    ms.Free;
    ss.free;
  end;
end;

procedure StringToComponent(Component: TComponent; Value: string);
var
  StrStream:TStringStream;
  ms: TMemoryStream;
begin
  StrStream := TStringStream.Create(Value);
  try
    ms := TMemoryStream.Create;
    try
      ObjectTextToBinary(StrStream, ms);
      ms.position := 0;
      ms.ReadComponent(Component);
    finally
      ms.Free;
    end;
  finally
    StrStream.Free;
  end;
end;

end.

