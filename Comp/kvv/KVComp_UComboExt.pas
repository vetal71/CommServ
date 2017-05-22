unit KVComp_UComboExt;

interface

uses
  Windows,
  Messages, SysUtils, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, DB, Uni;

type
  TOnComplete = procedure (Sender: TObject;
                           Key : Word;
                           ItemIndex : Integer;
                           var CompleteWith : String;
                           var DoComplete : Boolean) of object;
type
  TExtComboBox = class(TComboBox)
  private
    FComplete    : Boolean;
    FDefaultCode : LongInt;
    FKey         : Word;
    FMinLength   : Integer;
    FOnComplete  : TOnComplete;
    function GetCode : LongInt;
    procedure SetCode(const Value: LongInt);
    procedure SetComplete(Value : Boolean);
    procedure SetMinLength(Value : Integer);
   protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Change; override;
  public
    constructor Create(aOwner : TComponent); override;
    function GetItemCode (Index : Integer) : LongInt;
    procedure AddCodedItem (aCode : LongInt; const aText : String);
    property Code: LongInt read GetCode write SetCode default 0;
  published
    property Complete : Boolean read FComplete write SetComplete;
    property DefaultCode: LongInt read FDefaultCode write FDefaultCode default 0;
    property MinLengthComplete : Integer read FMinLength write SetMinLength;
    property OnComplete : TOnComplete read FOnComplete write FOnComplete;
  end;

type
  TQueryComboBox = class(TExtComboBox)
  private
    FConnection: TUniConnection;
    FDelimChar: Char;
    FDropDownWidth: Integer;
    FSQL: TStrings;
    FQuery : TUniQuery;
    iSavedWidth : Integer;
    procedure SetQuery(Value: TStrings);
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Load;
  published
    property Connection: TUniConnection read FConnection write FConnection;
    property DelimChar: Char read FDelimChar write FDelimChar default ',';
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property SQL: TStrings read FSQL write SetQuery;
  end;

procedure Register;

implementation

{$R KVComp_UComboExt.RES}

procedure Register;
begin
  RegisterComponents('KVComponents', [TExtComboBox, TQueryComboBox]);
end;

{----------------------------------------------------------------------------------}
{ TExtComboBox                                                                     }
{----------------------------------------------------------------------------------}

constructor TExtComboBox.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);
  FComplete  := True;
  FKey       := 0;
  FMinLength := 0;
end;

procedure TExtComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key,Shift);
  FKey := Key;
end;

procedure TExtComboBox.Change;
var
  sTmp   : String;
  i,iLen : Integer;
  bDoIt  : Boolean;
begin
  inherited Change;

  bDoIt := (FComplete) and ((Style = csDropDown) or (Style = csSimple));
  if (not bDoIt) then exit;

  bDoIt := (FKey <> 8) and (FKey <> 46) and (Length(Text) >= FMinLength) and (Items.Count > 0);
  if (not bDoIt) then exit;

  sTmp := AnsiUpperCase(Text);
  for i:=0 to Items.Count-1 do begin
    if (sTmp = AnsiUpperCase(Copy(Items.Strings[i],1,Length(sTmp)))) then begin
      iLen  := Length(sTmp);
      sTmp  := Copy(Items.Strings[i],Length(sTmp)+1,Length(Items.Strings[i])-Length(sTmp));
      bDoIt := True;
      if (Assigned(FOnComplete)) then
        FOnComplete(Self,FKey,i,sTmp,bDoIt);
      if (bDoIt) then begin
        Text := Text+sTmp;
        SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(iLen,Length(Text)));
      end;
      break;
    end;
  end;
end;

procedure TExtComboBox.SetComplete(Value : Boolean);
begin
  FComplete := Value;
end;

procedure TExtComboBox.SetMinLength(Value : Integer);
begin
  FMinLength := Value;
end;

function TExtComboBox.GetCode : LongInt;
begin
  Result := GetItemCode(ItemIndex);
end;

procedure TExtComboBox.SetCode(const Value: LongInt);
var
 i : Integer;
begin
  for i:=0 to Items.Count-1 do
   if (Longint(Pointer(Items.Objects[i])) = Value) then begin
     ItemIndex := i;
     exit;
   end;
end;

procedure TExtComboBox.AddCodedItem (aCode : LongInt; const aText : String);
begin
  Items.AddObject(aText, Pointer(aCode));
end;

function TExtComboBox.GetItemCode (Index : Integer) : LongInt;
begin
  Result := FDefaultCode;
  if (Index >= 0) and (Index < Items.Count) then
   Result := Longint(Pointer(Items.Objects[Index]));
end;

{----------------------------------------------------------------------------------}
{ TQueryComboBox                                                                   }
{----------------------------------------------------------------------------------}
constructor TQueryComboBox.Create(aOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csDropDownList;
  FConnection := nil;
  FDelimChar    := ',';
  FSQL          := TStringList.Create;
  FQuery        := TUniQuery.Create(Nil);
  iSavedWidth   := 0;
end;

destructor TQueryComboBox.Destroy;
begin
  FSQL.Free;
  FQuery.Free;
  inherited Destroy;
end;

procedure TQueryComboBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  case Message.NotifyCode of
    CBN_DROPDOWN :
      begin
        iSavedWidth := Width;
        if (FDropDownWidth > 0) then Width := FDropDownWidth;
      end;
    CBN_SELCHANGE:
      Width := iSavedWidth;
  end
end;

procedure TQueryComboBox.WMSize(var Message: TWMSize);
begin
  inherited;
  if (iSavedWidth = 0) then
    iSavedWidth := Width;
end;

procedure TQueryComboBox.SetQuery(Value: TStrings);
begin
  SQL.Assign(Value);
end;

procedure TQueryComboBox.Load;
var
  S : String;
  i : Integer;
begin
  FQuery.Close;
  if not Assigned(FConnection) then
    raise EAbort.Create('');
  FQuery.Connection := FConnection;
  FQuery.SQL.Assign(FSQL);
  Items.Clear;
  try
    FQuery.Open;
    while (not FQuery.EOF) do begin
      S := '';
      for i:=1 to FQuery.FieldCount-1 do begin
        if (S <> '') then S := S+DelimChar+' ';
        S := S+FQuery.Fields[i].AsString;
      end;
      Items.AddObject (S, Pointer(FQuery.Fields[0].AsInteger));
      FQuery.Next;
    end;
  finally
    if (Items.Count > 0) then ItemIndex := 0;
    FQuery.Close;
  end;
end;

end.

