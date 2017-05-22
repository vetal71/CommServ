unit KVComp_uPickDict;

//==============================================================================
interface//=====================================================================
//==============================================================================

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, rxToolEdit, KVComp_uPickCommon, DB, Uni, KVComp_FDlgDBDict;

const
  WM_CHANGEDICTMSG = WM_USER + 300;  //Изменилось наименование
  WM_FREEDICTMSG = WM_USER + 310;    //Удаляется компонента для выбора из справочника

type

  //////////////////////////////////////////////////////////////////////////////
  //Компонент для выбора из справочника
  //////////////////////////////////////////////////////////////////////////////
  TIDChangeEvent = procedure(Sender: TObject; ID: Integer) of object;           //Изменился внутренний код элемента

  TComboEditDict = class(TComboEditBase)
  private
    FTmpID: Integer;
    FDirectInput: Boolean;
  protected
    FConnection: TUniConnection;                                                //Соединение
    FSQL: TStrings;
    FDictID: Integer;                                                           //Код элемента
    FDictName: AnsiString;                                                      //Наименование элемента
    FOnIDChange: TIDChangeEvent;
  protected
    function GetDictName(const ADictID: Integer; var ADictName: AnsiString): Boolean;
    procedure SetDictID(const Value: Integer);                                      //Установить ИД элемента
    procedure ComboEditDictButtonClick;
    procedure SetDictName;
    procedure ClearParams;
    procedure SetSQL(Value: TStrings);
  public
    property DictID: Integer read FDictID write SetDictID;                      //Код
    property DictName: AnsiString read FDictName;             //Наименование
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ButtonClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure DoEnter; override;
    procedure DoExit; override;
  published
    property Connection: TUniConnection read FConnection write FConnection;
    property SQLs: TStrings read FSQL write SetSQL;
    property OnIDChange: TIDChangeEvent read FOnIDChange write FOnIDChange;
  end;

  //////////////////////////////////////////////////////////////////////////////
  //Компонент для показа(ввода) наименования элемента справочника
  //////////////////////////////////////////////////////////////////////////////
  TEditDict = class(TEditBase)
  protected
    FDictSource: TComboEditDict;
  protected
    procedure SetDictSource(const Value: TComboEditDict);
    function GetDictName: AnsiString;
    function IsLinked: Boolean;
    procedure SetDictName(const Value: AnsiString);
  public
    property DictName: AnsiString read GetDictName write SetDictName;
    property Linked: Boolean read IsLinked;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SubClassWndProc(var Message: TMessage);
    procedure Change; override;
  published
    property DictSource: TComboEditDict read FDictSource write SetDictSource;
    property ReadOnly;
  end;

procedure Register;

const
  UndefinedSprName = '';

////////////////////////////////////////////////////////////////////////////////
implementation//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//Компонент для выбора клиента
////////////////////////////////////////////////////////////////////////////////

//------------------------------------------------------------------------------
constructor TComboEditDict.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 300;
  ClearParams;
  Hint := 'Наименование элемента';
  ShowHint := true;
  FOnIDChange := nil;
  ReadOnly := false;
  FSQL := TStringList.Create;
  FTmpID := 0;
  DirectInput := false;
end;

//------------------------------------------------------------------------------
destructor TComboEditDict.Destroy;
var
  i: Integer;
begin
  //Событие - чтобы все потомки не ссылались больше на этот ID
  for i := 0 to ControlCount - 1 do begin
    if Assigned(FControlList[i]) then begin
      FControlList[i].Perform(WM_FREEDICTMSG, 0, 0);
    end;
  end;
  FSQL.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------
procedure TComboEditDict.ClearParams;
begin
  FDictName := '';
end;

//------------------------------------------------------------------------------
procedure TComboEditDict.ButtonClick;
begin
  if not (csDesigning in ComponentState) then begin
    ComboEditDictButtonClick;
  end;
  inherited;
end;

//------------------------------------------------------------------------------
procedure TComboEditDict.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if not (csDesigning in ComponentState) then begin
    if not ReadOnly then begin
      case Key of
        VK_ESCAPE:
          begin
            FTmpID := 0;
            FDirectInput := false;
//            SetDictName;
          end;
        VK_DELETE:
          DictID := 0;
        VK_RETURN:
          if FDirectInput then begin
            //Подставить ID
            if FTmpID <> 0 then begin
              DictID := FTmpID;
              FDirectInput := false;
              SendMessage(Handle, EM_SETSEL, 0, 0);
            end;
          end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TComboEditDict.GetDictName(const ADictID: Integer; var ADictName: AnsiString): Boolean;
var
  qry: TUniQuery;
  eSQLText: string;
begin
  Result := false;
  if (ADictID > 0) then begin
    qry := TUniQuery.Create(Owner);
    with qry do
    try
      Connection := FConnection;
      try
        eSQLText := Format('select a.* from (%s) a where a.Code=%d', [FSQL.Text, ADictID]);
        qry.SQL.Text := eSQLText;
        Active:=True;
        if not(IsEmpty) then begin
          Result := true;
          ADictName := Fields[1].AsString;
        end;
      except
      end;
    finally
      qry.Free;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TComboEditDict.KeyPress(var Key: Char);
var
  Found: boolean;
  SelSt: Integer;
  TmpStr, TmpShortName: string;
begin
  inherited KeyPress(Key);
  if not (csDesigning in ComponentState) then begin
    if not ReadOnly then begin
      if Key in [#0, #27] then exit;
      if not FDirectInput then begin
        Text := '';
      end;
      FDirectInput := true;
      if Key in ['a'..'z'] then Dec(Key, 32);
      SelSt := SelStart;
      if (Key = Chr(VK_BACK)) and (SelLength <> 0) then begin
       TmpStr := Copy(Text, 1, SelStart) + Copy(Text, SelLength + SelStart + 1, 255)
      end else begin
        if Key = Chr(VK_BACK) then begin
          TmpStr := Copy(Text, 1, SelStart - 1) + Copy(Text, SelStart + 1, 255)
        end else begin
          TmpStr := Copy(Text, 1, SelStart) + Key + Copy(Text, SelLength + SelStart + 1, 255);
        end;
      end;
      if TmpStr = '' then Exit;
      if (Key = Chr(VK_BACK)) and (SelSt > 0) then begin
        Dec(SelSt)
      end else begin
        if Key <> Chr(VK_BACK) then Inc(SelSt);
      end;
      Key := #0;
      if SelSt = 0 then begin
        FDictName := '';
        Exit;
      end;
      Found := GetDictName(FTmpID, FDictName);
      if Found then begin
        SelStart := SelSt;
        SelLength := Length(Text) - SelSt;
      end else begin
        Beep;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TComboEditDict.DoEnter;
begin
  if not (csDesigning in ComponentState) then begin
    //Выделить текст
    SendMessage(Handle, EM_SETSEL, 0, -1);
  end;
  inherited;
end;

//------------------------------------------------------------------------------
procedure TComboEditDict.DoExit;
begin
  if not (csDesigning in ComponentState) then begin
    if FDirectInput then begin
      //Подставить CliID
      if FTmpID <> 0 then begin
        DictID := FTmpID;
        FDirectInput := false;
      end;
    end;
  end;
  inherited;
end;

//------------------------------------------------------------------------------
procedure TComboEditDict.SetDictID(const Value: Integer);
var
  i: Integer;
begin
  FDictID := Value;
  Text := Integer.ToString(FDictID);
  FTmpID := FDictID;
  SetDictName;
  FDirectInput := false;
  //Событие - изменился код
  if Assigned(FOnIDChange) then FOnIDChange(Self, FDictID);
  for i := 0 to ControlCount - 1 do begin
    if Assigned(FControlList[i]) then begin
      FControlList[i].Perform(WM_CHANGEDICTMSG, 0, 0);
    end;
  end;
end;

procedure TComboEditDict.SetDictName;
begin
  GetDictName(FDictID, FDictName);
end;

procedure TComboEditDict.SetSQL(Value: TStrings);
begin
  SQLs.Assign(Value);
end;

procedure TComboEditDict.ComboEditDictButtonClick;
begin
  if not ReadOnly then begin
    if CreateDlgDBPick(FConnection, FSQL, FormCaption, FDictID) then
      DictID := FDictID;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//Компонент для показа(ввода) наименования элемента справочника
////////////////////////////////////////////////////////////////////////////////

constructor TEditDict.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 300;
  MaxLength := 2000;
  Hint := 'Наименование';
  ShowHint := true;
  ReadOnly := true;
  FDictSource := nil;
  WindowProc := SubClassWndProc;
end;

//------------------------------------------------------------------------------
destructor TEditDict.Destroy;
begin
  if Assigned(FDictSource) then begin
    FDictSource.DeleteControl(Self);
  end;
  inherited Destroy;
end;

//------------------------------------------------------------------------------
function TEditDict.IsLinked;
begin
  Result := Assigned(FDictSource);
end;

//------------------------------------------------------------------------------
procedure TEditDict.SubClassWndProc(var Message: TMessage);
begin
  case Message.Msg of
  WM_CHANGEDICTMSG:
    if Linked then begin
      Text := FDictSource.DictName;
    end;
  WM_FREEDICTMSG:
    begin
      FDictSource := nil;
    end
  else
    begin
      WndProc(Message);
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TEditDict.SetDictSource(const Value: TComboEditDict);
begin
  if FDictSource <> Value then begin
    if Assigned(FDictSource) then begin
      FDictSource.DeleteControl(Self);
    end;
    if Assigned(Value) then begin
      FDictSource := Value;
      FDictSource.AddControl(Self);
      if not (csDesigning in ComponentState) then begin
        Text := FDictSource.DictName;
      end;
    end else begin
      FDictSource := nil;
      if not (csDesigning in ComponentState) then begin
        Text := UndefinedSprName;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TEditDict.GetDictName: AnsiString;
begin
  Result := Text;
end;

//------------------------------------------------------------------------------
procedure TEditDict.SetDictName(const Value: AnsiString);
begin
  Text := Value;
//  Change;
end;

//------------------------------------------------------------------------------
procedure TEditDict.Change;
begin
//  if not (csDesigning in ComponentState) then begin
//    if Linked then begin
//      if FDictSource.DictName <> DictNAme then begin
//        FDictSource.DictName := DictName;
//      end;
//    end;
//  end;
//  inherited;
end;

//==============================================================================
procedure Register;
begin
  RegisterComponents('KVComponents', [TComboEditDict, TEditDict]);
end;

end.
