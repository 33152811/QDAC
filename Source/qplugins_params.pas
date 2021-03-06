unit qplugins_params;

interface

uses classes, sysutils, qstring, qvalue, variants{$IFDEF UNICODE},
  Generics.collections, Rtti{$ENDIF};
{$HPPEMIT '#pragma link "qplugins_params"'}

{
  Todo:加入只读接口的支持
}
type
  // 基础接口，用于获取对象的最原始地址（而不是当前接口实例的地址）
  IQBaseInterface = interface
    ['{0DCE065A-65D2-43C8-902A-B6E6214982B8}']
    function GetOriginPointer: Pointer; stdcall;
  end;

  // 流
  IQStream = interface
    ['{BCFD2F69-CCB8-4E0B-9FE9-A7D58797D1B8}']
    function Read(pv: Pointer; cb: Cardinal): Cardinal; stdcall;
    function Write(pv: Pointer; cb: Cardinal): Cardinal; stdcall;
    function Seek(AOffset: Int64; AFrom: BYTE): Int64; stdcall;
    procedure SetSize(ANewSize: UInt64); stdcall;
    function CopyFrom(AStream: IQStream; ACount: Int64): Int64; stdcall;
  end;

  // 参数规格化，用于使用不同语言之间交互
  TQParamType = (ptUnknown,
    // Integer Types
    ptInt8, ptUInt8, ptInt16, ptUInt16, ptInt32, ptUInt32, ptInt64, ptUInt64,
    ptFloat4, ptFloat8, // Float types
    ptDateTime, ptInterval, // DateTime types
    ptAnsiString, ptUtf8String, ptUnicodeString, // String types
    ptBoolean, // Boolean
    ptGuid, // Guid
    ptBytes, // Binary
    ptStream, // 流
    ptArray // Array
    );
  IQParams = interface;

  IQString = interface
    ['{B2FB1524-A06D-47F6-AA85-87C2251F2FCF}']
    procedure SetValue(const S: PWideChar); stdcall;
    function GetValue: PWideChar; stdcall;
    function GetLength: Integer; stdcall;
    procedure SetLength(ALen: Integer); stdcall;
    property Value: PWideChar read GetValue write SetValue;
    property Length: Integer read GetLength write SetLength;
  end;

  // 单个参数
  IQParam = interface
    ['{8641FD44-1BC3-4F04-B730-B5406CDA17E3}']
    function GetName: PWideChar; stdcall;
    function GetAsInteger: Integer; stdcall;
    procedure SetAsInteger(const AValue: Integer); stdcall;
    function GetAsInt64: Int64; stdcall;
    procedure SetAsInt64(const AValue: Int64); stdcall;
    function GetAsBoolean: Boolean; stdcall;
    procedure SetAsBoolean(const AValue: Boolean); stdcall;
    function GetAsSingle: Single; stdcall;
    procedure SetAsSingle(const AValue: Single); stdcall;
    function GetAsFloat: Double; stdcall;
    procedure SetAsFloat(const AValue: Double); stdcall;
    function GetAsString: IQString; stdcall;
    procedure SetAsString(const AValue: IQString); stdcall;
    function GetAsGuid: TGuid; stdcall;
    procedure SetAsGuid(const Value: TGuid); stdcall;
    function GetAsBytes(ABuf: PByte; ABufLen: Cardinal): Cardinal; stdcall;
    procedure SetAsBytes(ABuf: PByte; ABufLen: Cardinal); stdcall;
    function GetIsNull: Boolean; stdcall;
    procedure SetNull; stdcall;
    function GetAsArray: IQParams; stdcall;
    function GetAsStream: IQStream; stdcall;
    procedure SetAsStream(AStream: IQStream); stdcall;
    function GetParent: IQParams; stdcall;
    function GetType: TQParamType; stdcall;
    procedure SetType(const AType: TQParamType); stdcall;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsSingle: Single read GetAsSingle write SetAsSingle;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsGuid: TGuid read GetAsGuid write SetAsGuid;
    property IsNull: Boolean read GetIsNull;
    property Name: PWideChar read GetName;
    property AsArray: IQParams read GetAsArray;
    property AsStream: IQStream read GetAsStream write SetAsStream;
    property AsString: IQString read GetAsString write SetAsString;
    property Parent: IQParams read GetParent;
    property ParamType: TQParamType read GetType;
  end;

  // 参数列表
  IQParams = interface
    ['{B5746B65-7586-4DED-AE20-D4FF9B6ECD9E}']
    function GetItems(AIndex: Integer): IQParam; stdcall;
    function GetCount: Integer; stdcall;
    function ByName(const AName: PWideChar): IQParam; stdcall;
    function ByPath(APath: PWideChar): IQParam; stdcall;
    function Add(const AName: PWideChar; AParamType: TQParamType): IQParam;
      overload; stdcall;
    function Add(const AName: PWideChar; AChildren: IQParams): IQParam;
      overload; stdcall;
    function GetAsString: IQString; stdcall;
    procedure Delete(AIndex: Integer); stdcall;
    procedure Clear; stdcall;
    procedure SaveToStream(AStream: IQStream); stdcall;
    procedure LoadFromStream(AStream: IQStream); stdcall;
    procedure SaveToFile(const AFileName: PWideChar); stdcall;
    procedure LoadFromFile(const AFileName: PWideChar); stdcall;
    property Items[AIndex: Integer]: IQParam read GetItems; default;
    property Count: Integer read GetCount;
    property AsString: IQString read GetAsString;
  end;

  IQStringService = interface
    ['{9B9384C6-8E8C-4E32-B07B-3F60A7D0A595}']
    function NewString(S: PWideChar): IQString; stdcall;
  end;

  // 下面的封装是仅面向Delphi的，以便简化编码
  IQParamHelper = interface(IQParam)
    ['{7E6EF90D-5D88-4734-92C6-CB055F2C0222}']
    function GetUName: QStringW;
    function GetAsUString: QStringW;
    function GetAsDBytes: TBytes;
    function GetAsDVariant: Variant;
    procedure SetAsDBytes(const AValue: TBytes);
    procedure SetAsUString(const S: QStringW);
    procedure SetAsDVariant(const V: Variant);
    property AsString: QStringW read GetAsUString write SetAsUString;
    property AsBytes: TBytes read GetAsDBytes write SetAsDBytes;
    property AsVariant: Variant read GetAsDVariant write SetAsDVariant;
  end;

  IQParamsHelper = interface(IQParams)
    ['{8F199BB7-665B-476E-B5BB-72A813539AF0}']
    function ByName(const AName: QStringW): IQParam;
    function ByPath(APath: QStringW): IQParam;
    function Add(const AName: QStringW; AValue: Int64): Integer; overload;
    function Add(const AName: QStringW; AValue: Double): Integer; overload;
    function Add(const AName: QStringW; AValue: Boolean): Integer; overload;
    function Add(const AName, AValue: QStringW): Integer; overload;
    function Add(const AName: QStringW; AValue: Variant): Integer; overload;
    function Add(const AName: QStringW; AValue: TStream): Integer; overload;
    function Add(const AName: QStringW; const AValue: TBytes): Integer;
      overload;
    function Add(const AName: QStringW; const AValue: PByte; ALen: Integer)
      : Integer; overload;
    function Add(const AName: QStringW; const AValue: TGuid): Integer; overload;
    procedure LoadFromFile(const AFileName: QStringW);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(const AFileName: QStringW);
    procedure SaveToStream(AStream: TStream);
  end;

  // 重新实现 TInterfacedObject，以便子类能够重载 QueryInterface 方法
  TQInterfacedObject = class(TObject, IInterface, IQBaseInterface)
  protected
    FRefCount: Integer;
    FDisableRefCount: Integer;
  public
    constructor Create; overload; virtual;
    function _AddRef: Integer; virtual; stdcall;
    function _Release: Integer; virtual; stdcall;
    function GetOriginPointer: Pointer; stdcall;
    function QueryInterface(const IID: TGuid; out Obj): HRESULT;
      virtual; stdcall;
    procedure DisableRefCount;
    procedure EnableRefCount;
  end;

  TQUnicodeString = class(TQInterfacedObject, IQString)
  protected
    FValue: QStringW;
    function GetLength: Integer; stdcall;
    procedure SetLength(ALen: Integer); stdcall;
  public
    constructor Create; override;
    constructor Create(const S: QStringW); overload;
    procedure SetValue(const S: PWideChar); stdcall;
    function GetValue: PWideChar; stdcall;
  end;

  // Delphi 的流接口与 IQStream 之间的相互转换

  TQStream = class(TStream)
  protected
    FStream: IQStream;
    procedure SetSize(const NewSize: Int64); override;
  public
    constructor Create(AStream: IQStream); overload;
    destructor Destroy; override;
    procedure LoadFromStream(AStream: TStream); overload;
    procedure LoadFromStream(AStream: IQStream); overload;
    procedure LoadFromFile(const AFileName: QStringW);
    procedure SaveToStream(AStream: TStream); overload;
    procedure SaveToStream(AStream: IQStream); overload;
    procedure SaveToFile(const AFileName: QStringW);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
  end;

  TQStreamHelper = class(TQInterfacedObject, IQStream)
  protected
    FStream: TStream;
    FOwnStream: Boolean;
    function Read(pv: Pointer; cb: Cardinal): Cardinal; stdcall;
    function Write(pv: Pointer; cb: Cardinal): Cardinal; stdcall;
    function Seek(AOffset: Int64; AFrom: BYTE): Int64; stdcall;
    procedure SetSize(ANewSize: UInt64); stdcall;
    function CopyFrom(AStream: IQStream; ACount: Int64): Int64; stdcall;
  public
    constructor Create(AStream: TStream; AOwnStream: Boolean);
    destructor Destroy; override;
  end;

  // 参数接口的实现
  TQParams = class;

  TQParam = class(TQInterfacedObject, IQParam, IQParamHelper)
  protected
    FName: QStringW;
    FType: TQParamType;
    FValue: TQValue;
    FOwner: TQParams;
    function GetName: PWideChar; overload; stdcall;
    function GetUName: QStringW; overload;
    function GetAsInteger: Integer; stdcall;
    procedure SetAsInteger(const AValue: Integer); stdcall;
    function GetAsInt64: Int64; stdcall;
    procedure SetAsInt64(const AValue: Int64); stdcall;
    function GetAsBoolean: Boolean; stdcall;
    procedure SetAsBoolean(const AValue: Boolean); stdcall;
    function GetAsSingle: Single; stdcall;
    procedure SetAsSingle(const AValue: Single); stdcall;
    function GetAsFloat: Double; stdcall;
    procedure SetAsFloat(const AValue: Double); stdcall;
    function GetAsString: IQString; stdcall;
    procedure SetAsString(const AValue: IQString); stdcall;
    function GetAsGuid: TGuid; stdcall;
    procedure SetAsGuid(const Value: TGuid); stdcall;
    function GetAsBytes(ABuf: PByte; ABufLen: Cardinal): Cardinal; stdcall;
    procedure SetAsBytes(ABuf: PByte; ABufLen: Cardinal); stdcall;
    function GetIsNull: Boolean; stdcall;
    procedure SetNull; stdcall;
    function GetAsArray: IQParams; stdcall;
    function GetAsStream: IQStream; stdcall;
    function GetParent: IQParams; stdcall;
    function GetType: TQParamType; stdcall;
    procedure SetType(const AType: TQParamType); stdcall;
    function GetAsUString: QStringW;
    procedure SetAsUString(const Value: QStringW);
    function GetAsDBytes: TBytes;
    procedure SetAsDBytes(const Value: TBytes);
    procedure SetAsStream(AStream: IQStream); stdcall;
    function GetAsDVariant: Variant;
    procedure SetAsDVariant(const V: Variant);
  public
    constructor Create(AOwner: TQParams); overload;
    destructor Destroy; override;
    procedure Assign(ASource: IQParam);
    property Name: QStringW read FName write FName;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsSingle: Single read GetAsSingle write SetAsSingle;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsString: QStringW read GetAsUString write SetAsUString;
    property AsGuid: TGuid read GetAsGuid write SetAsGuid;
    property AsBytes: TBytes read GetAsDBytes write SetAsDBytes;
    property IsNull: Boolean read GetIsNull;
    property AsArray: IQParams read GetAsArray;
    property AsStream: IQStream read GetAsStream;
    property Parent: IQParams read GetParent;
    property DataType: TQParamType read FType write SetType;
  end;

  TQParamString = class(TQInterfacedObject, IQString)
  protected
    FValue: PQValue;
    FText: QStringW;
    procedure SetValue(const S: PWideChar); stdcall;
    function GetValue: PWideChar; stdcall;
    function GetLength: Integer; stdcall;
    procedure SetLength(ALen: Integer); stdcall;
  public
    constructor Create(AValue: PQValue); overload;
    destructor Destroy; override;
  end;

{$IF RTLVersion>=21}

  TQParamList = TList<TQParam>;
{$ELSE}
  TQParamList = TList;
{$IFEND}

  TQParams = class(TQInterfacedObject, IQParams, IQParamsHelper)
  private
    function GetDItems(AIndex: Integer): TQParam;
    procedure SetDItems(AIndex: Integer; const Value: TQParam);
  protected
    FItems: TQParamList;
    function GetItems(AIndex: Integer): IQParam; stdcall;
    function GetCount: Integer; stdcall;
    function GetAsString: IQString; stdcall;
    function Add(const AName: PWideChar; AParamType: TQParamType): IQParam;
      overload; stdcall;
    function InternalAdd(const AName: QStringW; AParamType: TQParamType;
      var AResult: TQParam): Integer; overload;
  public
    constructor Create; override;
    destructor Destroy; override;
    function ByName(const AName: PWideChar): IQParam; overload; stdcall;
    function ByPath(APath: PWideChar): IQParam; overload; stdcall;
    function Add(const AName: QStringW; AParamType: TQParamType)
      : TQParam; overload;
    procedure AddRange(AParams: IQParams; AStartIndex, ACount: Integer);
    function Add(AParam: TQParam): Integer; overload;
    function Add(AParam: IQParam): Integer; overload;
    function Add(const AName: PWideChar; AChildren: IQParams): IQParam;
      overload; stdcall;
    procedure Delete(AIndex: Integer); stdcall;
    procedure Clear; stdcall;
    procedure SaveToStream(AStream: TStream); overload;
    procedure SaveToStream(AStream: IQStream); overload; stdcall;
    procedure LoadFromStream(AStream: TStream); overload;
    procedure LoadFromStream(AStream: IQStream); overload; stdcall;
    procedure SaveToFile(const AFileName: PWideChar); overload; stdcall;
    procedure LoadFromFile(const AFileName: PWideChar); overload; stdcall;
    procedure LoadFromFile(const AFileName: QStringW); overload;
    procedure SaveToFile(const AFileName: QStringW); overload;
    function ByName(const AName: QStringW): IQParam; overload;
    function ByPath(APath: QStringW): IQParam; overload;
    function Add(const AName: QStringW; AValue: Int64): Integer; overload;
    function Add(const AName: QStringW; AValue: Double): Integer; overload;
    function Add(const AName: QStringW; AValue: Boolean): Integer; overload;
    function Add(const AName, AValue: QStringW): Integer; overload;
    function Add(const AName: QStringW; AValue: Variant): Integer; overload;
    function Add(const AName: QStringW; AValue: TStream): Integer; overload;
    function Add(const AName: QStringW; const AValue: TBytes): Integer;
      overload;
    function Add(const AName: QStringW; const AValue: PByte; ALen: Integer)
      : Integer; overload;
    function Add(const AName: QStringW; const AValue: TGuid): Integer; overload;
    property Items[AIndex: Integer]: TQParam read GetDItems
      write SetDItems; default;
    property Count: Integer read GetCount;
  end;

  // 参数类型名称
const
  ParamTypeNames: array [TQParamType] of QStringW = ('Unknown',
    // Integer Types
    'Shortint', 'Byte', 'Smallint', 'Word', 'Integer', 'DWord', 'Int64',
    'UInt64', 'Single', 'Double', // Float types
    'DateTime', 'Interval', // DateTime types
    'AnsiString', 'Utf8String', 'UnicodeString', // String types
    'Bool', // Boolean
    'Guid', // Guid
    'Binary', // Binary
    'Stream', // 流
    'Array' // Array
    );
  // IQStream <-> TStream 的简单转换接口
function NewStream(AStream: TStream; AStreamOwner: Boolean): IQStream; overload;
function NewStream(AStream: IQStream): TQStream; overload;

function QStream(AStream: TStream; AStreamOwner: Boolean): IQStream; overload;
  deprecated 'Use NewStream instead';
function QStream(AStream: IQStream): TQStream; overload;
  deprecated 'Use NewStream instead';
// IQParams 的简单实现
function NewParams(const AValues: array of const): IQParams;
function NewString(const S: QStringW): IQString;
function ParamAsString(AParam: IQParam): QStringW;
function ParamAsBytes(AParam: IQParam): TBytes;
function ParamHelper(AParam: IQParam): IQParamHelper;
function ParamsHelper(AParams: IQParams): IQParamsHelper;

var
  StringService: IQStringService = nil;

implementation

const
  NullChar: QCharW = #0;
  PathDelimiter: PQCharW = '/'; //

resourcestring
  // SInvalidName = '无效的结点名称，名称中不能包含 "/"。';
  SCantConvert = '无法转换类型 %s 的值到 %s 。';
  SUnsupportParamArrayItem = '第 %d 个参数类型不受支持。';
  SUnsupportNow = '%s 目前不受支持。';

  // SMismatchServicePath = '请求的服务路径 %s 不存在或类型不匹配。';
type
  TQParamHelper = class(TQInterfacedObject, IQParamHelper)
  protected
    FInterface: IQParam;
    function GetUName: QStringW;
    function GetAsUString: QStringW;
    procedure SetAsUString(const S: QStringW);
    function GetName: PWideChar; stdcall;
    function GetAsInteger: Integer; stdcall;
    procedure SetAsInteger(const AValue: Integer); stdcall;
    function GetAsInt64: Int64; stdcall;
    procedure SetAsInt64(const AValue: Int64); stdcall;
    function GetAsBoolean: Boolean; stdcall;
    procedure SetAsBoolean(const AValue: Boolean); stdcall;
    function GetAsSingle: Single; stdcall;
    procedure SetAsSingle(const AValue: Single); stdcall;
    function GetAsFloat: Double; stdcall;
    procedure SetAsFloat(const AValue: Double); stdcall;
    function GetAsString: IQString; stdcall;
    procedure SetAsString(const AValue: IQString); stdcall;
    function GetAsGuid: TGuid; stdcall;
    procedure SetAsGuid(const Value: TGuid); stdcall;
    function GetAsBytes(ABuf: PByte; ABufLen: Cardinal): Cardinal; stdcall;
    procedure SetAsBytes(ABuf: PByte; ABufLen: Cardinal); stdcall;
    function GetIsNull: Boolean; stdcall;
    procedure SetNull; stdcall;
    function GetAsArray: IQParams; stdcall;
    function GetAsStream: IQStream; stdcall;
    procedure SetAsStream(AStream: IQStream); stdcall;
    function GetParent: IQParams; stdcall;
    function GetType: TQParamType; stdcall;
    procedure SetType(const AType: TQParamType); stdcall;
    function GetAsDBytes: TBytes;
    procedure SetAsDBytes(const AValue: TBytes);
    function GetAsDVariant: Variant;
    procedure SetAsDVariant(const V: Variant);
  public
    constructor Create(AIntf: IQParam);
  end;

  TQParamsHelper = class(TQInterfacedObject, IQParamsHelper)
  protected
    FInterface: IQParams;
    function GetItems(AIndex: Integer): IQParam; stdcall;
    function GetCount: Integer; stdcall;
    function ByName(const AName: PWideChar): IQParam; overload; stdcall;
    function ByPath(APath: PWideChar): IQParam; overload; stdcall;
    function Add(const AName: PWideChar; AParamType: TQParamType): IQParam;
      overload; stdcall;
    function GetAsString: IQString; stdcall;
    procedure Delete(AIndex: Integer); stdcall;
    procedure Clear; stdcall;
    procedure SaveToStream(AStream: IQStream); overload; stdcall;
    procedure LoadFromStream(AStream: IQStream); overload; stdcall;
    procedure SaveToFile(const AFileName: PWideChar); overload; stdcall;
    procedure LoadFromFile(const AFileName: PWideChar); overload; stdcall;
    procedure LoadFromFile(const AFileName: QStringW); overload;
    procedure LoadFromStream(AStream: TStream); overload;
    procedure SaveToFile(const AFileName: QStringW); overload;
    procedure SaveToStream(AStream: TStream); overload;
    function ByName(const AName: QStringW): IQParam; overload;
    function ByPath(APath: QStringW): IQParam; overload;
    function Add(const AName: QStringW; AValue: Int64): Integer; overload;
    function Add(const AName: QStringW; AValue: Double): Integer; overload;
    function Add(const AName: QStringW; AValue: Boolean): Integer; overload;
    function Add(const AName, AValue: QStringW): Integer; overload;
    function Add(const AName: QStringW; AValue: Variant): Integer; overload;
    function Add(const AName: QStringW; AValue: TStream): Integer; overload;
    function Add(const AName: QStringW; const AValue: TBytes): Integer;
      overload;
    function Add(const AName: QStringW; const AValue: TGuid): Integer; overload;
    function Add(const AName: QStringW; const AValue: PByte; ALen: Integer)
      : Integer; overload;
    function Add(const AName: PWideChar; AChildren: IQParams): IQParam;
      overload; stdcall;
  public
    constructor Create(AIntf: IQParams);
  end;

function ParamHelper(AParam: IQParam): IQParamHelper;
begin
  if not Supports(AParam, IQParamHelper, Result) then
    Result := TQParamHelper.Create(AParam);
end;

function ParamsHelper(AParams: IQParams): IQParamsHelper;
begin
  if not Supports(AParams, IQParamsHelper, Result) then
    Result := TQParamsHelper.Create(AParams);
end;
{ TQInterfacedObject }

constructor TQInterfacedObject.Create;
begin
  inherited;
end;

procedure TQInterfacedObject.DisableRefCount;
begin
  AtomicIncrement(FDisableRefCount);
end;

procedure TQInterfacedObject.EnableRefCount;
begin
  AtomicDecrement(FDisableRefCount);
end;

function TQInterfacedObject.GetOriginPointer: Pointer;
begin
  Result := Self;
end;

function TQInterfacedObject.QueryInterface(const IID: TGuid; out Obj): HRESULT;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TQInterfacedObject._AddRef: Integer;
begin
  if FDisableRefCount = 0 then
    Result := AtomicIncrement(FRefCount)
  else
    Result := -1;
end;

function TQInterfacedObject._Release: Integer;
begin
  if FDisableRefCount = 0 then
  begin
    Result := AtomicDecrement(FRefCount);
    if Result = 0 then
      FreeObject(Self);
  end
  else
    Result := -1;
end;

{ TQStream }

constructor TQStream.Create(AStream: IQStream);
begin
  inherited Create;
  FStream := AStream;
end;

destructor TQStream.Destroy;
begin
  FStream := nil;
  inherited;
end;

procedure TQStream.LoadFromFile(

  const AFileName: QStringW);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    LoadFromStream(AStream);
  finally
    FreeAndNil(AStream);
  end;
end;

procedure TQStream.LoadFromStream(AStream: IQStream);
begin
  FStream.CopyFrom(AStream, AStream.Seek(0, soFromEnd) - AStream.Seek(0,
    soFromCurrent));
end;

procedure TQStream.LoadFromStream(AStream: TStream);
begin
  CopyFrom(AStream, AStream.size - AStream.Position);
end;

function TQStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := FStream.Read(@Buffer, Count);
end;

procedure TQStream.SaveToFile(const AFileName: QStringW);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    FreeAndNil(AStream);
  end;
end;

procedure TQStream.SaveToStream(AStream: IQStream);
begin
  AStream.CopyFrom(FStream, size - Position);
end;

procedure TQStream.SaveToStream(AStream: TStream);
begin
  AStream.CopyFrom(Self, size - Position);
end;

function TQStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := FStream.Seek(Offset, BYTE(Origin));
end;

procedure TQStream.SetSize(const NewSize: Int64);
begin
  FStream.SetSize(NewSize);
end;

function TQStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := FStream.Write(@Buffer, Count);
end;

{ TQStreamHelper }

function TQStreamHelper.CopyFrom(AStream: IQStream; ACount: Int64): Int64;
const
  MaxBufSize = $F000;
var
  BufSize, N, W: Integer;
  Buffer: TBytes;
begin
  if ACount <= 0 then
  begin
    ACount := AStream.Seek(0, soFromEnd);
    AStream.Seek(0, soFromBeginning);
  end;
  Result := ACount;
  if ACount > MaxBufSize then
    BufSize := MaxBufSize
  else
    BufSize := ACount;
  SetLength(Buffer, BufSize);
  try
    while ACount <> 0 do
    begin
      if ACount > BufSize then
        N := BufSize
      else
        N := ACount;
      N := AStream.Read(@Buffer[0], N);
      W := 0;
      while N > W do
        Inc(W, Write(@Buffer[W], N - W));
      Dec(ACount, N);
    end;
  finally
    SetLength(Buffer, 0);
  end;
end;

constructor TQStreamHelper.Create(AStream: TStream; AOwnStream: Boolean);
begin
  inherited Create;
  FStream := AStream;
  FOwnStream := AOwnStream;
end;

destructor TQStreamHelper.Destroy;
begin
  if FOwnStream then
    FreeAndNil(FStream);
  inherited;
end;

function TQStreamHelper.Read(pv: Pointer; cb: Cardinal): Cardinal;
begin
  Result := FStream.Read(pv^, cb);
end;

function TQStreamHelper.Seek(AOffset: Int64; AFrom: BYTE): Int64;
begin
  Result := FStream.Seek(AOffset, TSeekOrigin(AFrom));
end;

procedure TQStreamHelper.SetSize(ANewSize: UInt64);
begin
  FStream.size := ANewSize;
end;

function TQStreamHelper.Write(pv: Pointer; cb: Cardinal): Cardinal;
begin
  Result := FStream.Write(pv^, cb);
end;

function NewStream(AStream: TStream; AStreamOwner: Boolean): IQStream;
begin
  Result := TQStreamHelper.Create(AStream, AStreamOwner);
end;

function NewStream(AStream: IQStream): TQStream;
begin
  Result := TQStream.Create(AStream);
end;

function QStream(AStream: TStream; AStreamOwner: Boolean): IQStream;
begin
  Result := TQStreamHelper.Create(AStream, AStreamOwner);
end;

function QStream(AStream: IQStream): TQStream;
begin
  Result := TQStream.Create(AStream);
end;

function NewString(const S: QStringW): IQString;
begin
  if Assigned(StringService) then
    Result := StringService.NewString(PWideChar(S))
  else
    Result := TQUnicodeString.Create(S);
end;

{ TQParam }

procedure TQParam.Assign(ASource: IQParam);
  procedure AssignArray;
  var
    ASourceParams: IQParams;
    ATargetParams: TQParams;
  begin
    FValue.TypeNeeded(vdtInt64);
    IQParams(FValue.Value.AsPointer) := nil;
    ASourceParams := ASource.AsArray;
    if Assigned(ASourceParams) then
    begin
      ATargetParams := TQParams.Create;
      ATargetParams.AddRange(ASourceParams, 0, ASourceParams.Count);
      IQParams(FValue.Value.AsPointer) := ATargetParams;
    end;
  end;

begin
  case ASource.ParamType of
    ptInt8, ptUInt8, ptInt16, ptUInt16, ptInt32:
      begin
        FValue.TypeNeeded(vdtInteger);
        FValue.AsInteger := ASource.AsInteger;
      end;
    ptUInt32, ptInt64, ptUInt64:
      begin
        FValue.TypeNeeded(vdtInt64);
        FValue.AsInt64 := ASource.AsInt64;
      end;
    ptFloat4:
      begin
        FValue.TypeNeeded(vdtSingle);
        FValue.AsSingle := ASource.AsSingle;
      end;
    ptFloat8:
      begin
        FValue.TypeNeeded(vdtFloat);
        FValue.AsFloat := ASource.AsFloat;
      end;
    ptDateTime:
      begin
        FValue.TypeNeeded(vdtDateTime);
        FValue.AsDateTime := ASource.AsFloat;
      end;
    ptInterval:
      begin
        FValue.TypeNeeded(vdtInterval);
        FValue.AsInterval.AsString := ParamAsString(ASource);
      end;
    ptAnsiString, ptUtf8String, ptUnicodeString:
      begin
        FValue.TypeNeeded(vdtString);
        FValue.AsString := ParamAsString(ASource);
      end;
    ptBoolean:
      begin
        FValue.TypeNeeded(vdtBoolean);
        FValue.AsBoolean := ASource.AsBoolean;
      end;
    ptGuid:
      begin
        FValue.TypeNeeded(vdtGuid);
        FValue.AsGuid := ASource.AsGuid;
      end;
    ptBytes:
      begin
        FValue.TypeNeeded(vdtStream);
        FValue.AsBytes := ParamAsBytes(ASource);
      end;
    ptStream:
      begin
        FValue.TypeNeeded(vdtStream);
        FValue.AsStream.CopyFrom(NewStream(ASource.AsStream), 0);
      end;
    ptArray:
      AssignArray;
  end;
end;

constructor TQParam.Create(AOwner: TQParams);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TQParam.Destroy;
begin
  SetNull;
  inherited;
end;

function TQParam.GetAsArray: IQParams;
begin
  if FType = ptArray then
    Result := IQParams(FValue.Value.AsPointer)
  else
    raise QException.CreateFmt(SCantConvert, [ParamTypeNames[FType],
      ParamTypeNames[ptArray]]);
end;

function TQParam.GetAsBoolean: Boolean;
begin
  Result := FValue.AsBoolean;
end;

function TQParam.GetAsBytes(ABuf: PByte; ABufLen: Cardinal): Cardinal;
var
  ATemp: TBytes;
  procedure StreamToBytes;
  var
    AStream: IQStream;
  begin
    AStream := AsStream;
    SetLength(ATemp, AStream.Seek(0, soFromEnd));
    AStream.Seek(0, soFromBeginning);
    AStream.Read(@ATemp[0], Length(ATemp));
  end;
  procedure ArrayToBytes;
  var
    AStream: TMemoryStream;
  begin
    AStream := TMemoryStream.Create;
    try
      AsArray.SaveToStream(NewStream(AStream, False));
      SetLength(ATemp, AStream.size);
      AStream.Position := 0;
      AStream.Read(ATemp[0], Length(ATemp));
    finally
      FreeObject(AStream);
    end;
  end;

begin
  case FType of
    ptBytes, ptStream:
      StreamToBytes;
    ptArray:
      ArrayToBytes
  else
    ATemp := FValue.AsBytes;
  end;
  if (ABuf = nil) or (ABufLen = 0) then
    Result := Length(ATemp)
  else
  begin
    if ABufLen > Cardinal(Length(ATemp)) then
      Result := Length(ATemp)
    else
      Result := ABufLen;
    if Result > 0 then
      Move(ATemp[0], ABuf, Result);
  end;
end;

function TQParam.GetAsDBytes: TBytes;
begin
  Result := FValue.AsBytes;
end;

function TQParam.GetAsDVariant: Variant;
  procedure StreamToVar;
  var
    AStream: IQStream;
    ASize: Int64;
  begin
    AStream := AsStream;
    if Assigned(AStream) then
    begin
      ASize := AStream.Seek(0, soFromEnd);
      if ASize > 0 then
      begin
        Result := VarArrayCreate([0, ASize - 1], varByte);
        AStream.Seek(0, soFromBeginning);
        AStream.Read(VarArrayLock(Result), ASize);
        VarArrayUnlock(Result);
      end
      else
        Result := Null;
    end
    else
      Result := Null;
  end;
  procedure ArrayToVar;
  var
    I: Integer;
    AItems: IQParams;
  begin
    AItems := AsArray;
    if AItems.Count > 0 then
    begin
      Result := VarArrayCreate([0, AItems.Count - 1], varVariant);
      for I := 0 to AItems.Count - 1 do
        Result[I] := ParamHelper(AItems[I]).AsVariant;
    end
    else
      Result := Null;
  end;

begin
  if FType = ptStream then
    StreamToVar
  else if FType = ptArray then
    ArrayToVar
  else
    Result := FValue.AsVariant;
end;

function TQParam.GetAsFloat: Double;
begin
  Result := FValue.AsFloat;
end;

function TQParam.GetAsGuid: TGuid;
begin
  Result := FValue.AsGuid;
end;

function TQParam.GetAsInt64: Int64;
begin
  Result := FValue.AsInt64;
end;

function TQParam.GetAsInteger: Integer;
begin
  Result := AsInt64;
end;

function TQParam.GetAsSingle: Single;
begin
  Result := AsFloat;
end;

function TQParam.GetAsStream: IQStream;
begin
  if FType = ptStream then
    Result := IQStream(FValue.Value.AsPointer)
  else
    raise QException.CreateFmt(SCantConvert, [ParamTypeNames[FType],
      ParamTypeNames[ptInt64]]);
end;

function TQParam.GetAsString: IQString;
begin
  Result := TQParamString.Create(@FValue);
end;

function TQParam.GetAsUString: QStringW;
begin
  case FType of
    ptBytes, ptStream:
      Result := BinToHex(AsBytes);
    ptArray:
      Result := AsArray.AsString.Value
      // 格式化为JSON字符串
  else
    Result := FValue.AsString;
  end;
end;

function TQParam.GetIsNull: Boolean;
begin
  Result := FValue.IsNull;
end;

function TQParam.GetUName: QStringW;
begin
  Result := FName;
end;

function TQParam.GetName: PWideChar;
begin
  Result := PQCharW(FName);
end;

function TQParam.GetParent: IQParams;
begin
  Result := FOwner;
end;

function TQParam.GetType: TQParamType;
begin
  Result := FType;
end;

procedure TQParam.SetAsBoolean(const AValue: Boolean);
begin
  FValue.AsBoolean := AValue;
end;

procedure TQParam.SetAsBytes(ABuf: PByte; ABufLen: Cardinal);
var
  ATemp: TBytes;
begin
  SetLength(ATemp, ABufLen);
  if ABufLen > 0 then
    Move(ABuf^, ATemp[0], ABufLen);
  FValue.AsBytes := ATemp;
end;

procedure TQParam.SetAsDBytes(const Value: TBytes);
begin
  FValue.AsBytes := Value;
end;

procedure TQParam.SetAsDVariant(const V: Variant);
  procedure FromVar;
  begin
    raise Exception.CreateFmt(SUnsupportNow, ['TQParam.SetAsDVaraint.FromVar']);
  end;

  procedure ToBytes;
  begin
    raise Exception.CreateFmt(SUnsupportNow, ['TQParam.SetAsDVaraint.FromVar']);
  end;
  procedure ToStream;
  begin
    raise Exception.CreateFmt(SUnsupportNow, ['TQParam.SetAsDVaraint.FromVar']);
  end;
  procedure ToArray;
  begin
    raise Exception.CreateFmt(SUnsupportNow, ['TQParam.SetAsDVaraint.FromVar']);
  end;

begin
  case FType of
    ptUnknown:
      FromVar;
    ptInt8, ptUInt8, ptInt16, ptUInt16, ptInt32:
      begin
        FValue.TypeNeeded(vdtInteger);
        FValue.AsInteger := V;
      end;
    ptUInt32, ptInt64, ptUInt64:
      begin
        FValue.TypeNeeded(vdtInt64);
        FValue.AsInt64 := V;
      end;
    ptFloat4:
      begin
        FValue.TypeNeeded(vdtSingle);
        FValue.AsSingle := V;
      end;
    ptFloat8:
      begin
        FValue.TypeNeeded(vdtFloat);
        FValue.AsFloat := V;
      end;
    ptDateTime:
      begin
        FValue.TypeNeeded(vdtDateTime);
        FValue.AsDateTime := V;
      end;
    ptInterval:
      begin
        FValue.TypeNeeded(vdtInterval);
        FValue.AsInt64 := V;
      end;
    ptAnsiString, ptUtf8String, ptUnicodeString:
      begin
        FValue.TypeNeeded(vdtString);
        FValue.AsString := V;
      end;
    ptBoolean:
      begin
        FValue.TypeNeeded(vdtBoolean);
        FValue.AsBoolean := V;
      end;
    ptGuid:
      begin
        FValue.TypeNeeded(vdtGuid);
        FValue.AsGuid := StringToGuid(V);
      end;
    ptBytes:
      ToBytes;
    ptStream:
      ToStream;
    ptArray:
      ToArray;
  end;
end;

procedure TQParam.SetAsFloat(const AValue: Double);
begin
  FValue.AsFloat := AValue;
end;

procedure TQParam.SetAsGuid(const Value: TGuid);
begin
  FValue.AsGuid := Value;
end;

procedure TQParam.SetAsInt64(const AValue: Int64);
begin
  FValue.AsInt64 := AValue;
end;

procedure TQParam.SetAsInteger(const AValue: Integer);
begin
  FValue.AsInteger := AValue;
end;

procedure TQParam.SetAsSingle(const AValue: Single);
begin
  FValue.AsSingle := AValue;
end;

procedure TQParam.SetAsStream(AStream: IQStream);
begin
  FValue.TypeNeeded(vdtInt64);
  IQStream(FValue.Value.AsPointer) := AStream;
end;

procedure TQParam.SetAsString(const AValue: IQString);
var
  S: QStringW;
begin
  SetLength(S, AValue.Length);
  Move(AValue.Value^, PWideChar(S)^, AValue.Length shl 1);
  FValue.AsString := S;
end;

procedure TQParam.SetAsUString(const Value: QStringW);
begin
  FValue.AsString := Value;
end;

procedure TQParam.SetNull;
begin
  case FType of
    ptBytes, ptStream:
      IQStream(FValue.Value.AsPointer) := nil;
    ptArray:
      IQParams(FValue.Value.AsPointer) := nil
  else
    FValue.Reset;
  end;
end;

procedure TQParam.SetType(const AType: TQParamType);
begin
  if AType <> FType then
  begin
    if FType = ptArray then
      IQParams(FValue.Value.AsPointer) := nil;
    FType := AType;
    case AType of
      ptUnknown:
        FValue.Reset;
      ptInt8, ptUInt8, ptInt16, ptUInt16, ptInt32:
        FValue.TypeNeeded(vdtInteger);
      ptUInt32, ptInt64, ptUInt64:
        FValue.TypeNeeded(vdtInt64);
      ptFloat4:
        FValue.TypeNeeded(vdtSingle);
      ptFloat8:
        FValue.TypeNeeded(vdtFloat);
      ptDateTime:
        FValue.TypeNeeded(vdtDateTime);
      ptInterval:
        FValue.TypeNeeded(vdtInterval);
      ptAnsiString, ptUtf8String, ptUnicodeString:
        FValue.TypeNeeded(vdtString);
      ptBoolean:
        FValue.TypeNeeded(vdtBoolean);
      ptGuid:
        FValue.TypeNeeded(vdtGuid);
      ptBytes, ptStream:
        IQStream(FValue.Value.AsPointer) :=
          NewStream(TMemoryStream.Create, True);
      ptArray:
        begin
          FValue.Reset;
          IQParams(FValue.Value.AsPointer) := TQParams.Create;
        end;
    end;
  end;
end;

{ TQParams }

function TQParams.Add(const AName: PWideChar; AParamType: TQParamType): IQParam;
begin
  Result := Add(QStringW(AName), AParamType);
end;

function TQParams.Add(AParam: TQParam): Integer;
begin
  AParam._AddRef;
  Result := FItems.Add(AParam);
end;

function TQParams.Add(AParam: IQParam): Integer;
var
  AItem: TQParam;
begin
  AItem := TQParam.Create(Self);
  AItem.Assign(AParam);
  Result := Add(AItem);
end;

function TQParams.Add(const AName: QStringW; AValue: Boolean): Integer;
var
  AParam: TQParam;
begin
  Result := InternalAdd(AName, ptBoolean, AParam);
  AParam.AsBoolean := AValue;
end;

function TQParams.Add(const AName, AValue: QStringW): Integer;
var
  AParam: TQParam;
begin
  Result := InternalAdd(AName, ptUnicodeString, AParam);
  AParam.SetAsString(NewString(AValue));
end;

function TQParams.Add(const AName: QStringW; AValue: Int64): Integer;
var
  AParam: TQParam;
begin
  Result := InternalAdd(AName, ptInt64, AParam);
  AParam.AsInt64 := AValue;
end;

function TQParams.Add(const AName: QStringW; AValue: Double): Integer;
var
  AParam: TQParam;
begin
  Result := InternalAdd(AName, ptFloat8, AParam);
  AParam.AsFloat := AValue;
end;

function TQParams.Add(const AName: QStringW; AValue: Variant): Integer;
var
  AParam: TQParam;
begin
  case VarType(AValue) of
    varSmallInt:
      begin
        Result := InternalAdd(AName, ptInt16, AParam);
        AParam.AsInteger := AValue;
      end;
    varInteger, varError:
      begin
        Result := InternalAdd(AName, ptInt32, AParam);
        AParam.AsInteger := AValue;
      end;
    varSingle:
      begin
        Result := InternalAdd(AName, ptFloat4, AParam);
        AParam.AsSingle := AValue;
      end;
    varDouble, varCurrency:
      begin
        Result := InternalAdd(AName, ptFloat8, AParam);
        AParam.AsFloat := AValue;
      end;
    varDate:
      begin
        Result := InternalAdd(AName, ptDateTime, AParam);
        AParam.AsFloat := AValue;
      end;
    varOleStr:
      begin
        Result := InternalAdd(AName, ptUnicodeString, AParam);
        AParam.AsString := AValue;
      end;
    varBoolean:
      begin
        Result := InternalAdd(AName, ptBoolean, AParam);
        AParam.AsBoolean := AValue;
      end;
    varShortInt:
      begin
        Result := InternalAdd(AName, ptInt8, AParam);
        AParam.AsInteger := AValue;
      end;
    varByte:
      begin
        Result := InternalAdd(AName, ptUInt8, AParam);
        AParam.AsInteger := AValue;
      end;
    varWord:
      begin
        Result := InternalAdd(AName, ptUInt16, AParam);
        AParam.AsInteger := AValue;
      end;
    varLongWord:
      begin
        Result := InternalAdd(AName, ptUInt32, AParam);
        AParam.AsInt64 := AValue;
      end;
    varInt64:
      begin
        Result := InternalAdd(AName, ptInt64, AParam);
        AParam.AsInt64 := AValue;
      end;
    varUInt64:
      begin
        Result := InternalAdd(AName, ptUInt64, AParam);
        AParam.AsInt64 := AValue;
      end;
    varString{$IFDEF UNICODE}, varUString{$ENDIF}:
      begin
        Result := InternalAdd(AName, ptUnicodeString, AParam);
        AParam.AsString := AValue;
      end
  else
    raise QException.CreateFmt(SUnsupportNow,
      ['VarType ' + IntToStr(VarType(AValue))]);
  end;
end;

function TQParams.Add(const AName: QStringW; const AValue: PByte;
  ALen: Integer): Integer;
var
  AParam: TQParam;
begin
  Result := InternalAdd(AName, ptBytes, AParam);
  AParam.SetAsBytes(AValue, ALen);
end;

function TQParams.Add(const AName: QStringW; const AValue: TGuid): Integer;
var
  AParam: TQParam;
begin
  Result := InternalAdd(AName, ptGuid, AParam);
  AParam.AsGuid := AValue;
end;

function TQParams.Add(const AName: PWideChar; AChildren: IQParams): IQParam;
var
  I: Integer;
  ATemp: IQParams;
  AParam: IQParam;
  ABytes: TBytes;
begin
  Result := Add(AName, ptArray);
  ATemp := Result.AsArray;
  for I := 0 to AChildren.Count - 1 do
  begin
    AParam := AChildren[I];
    case AParam.ParamType of
      ptInt8, ptUInt8, ptInt16, ptUInt16, ptInt32, ptUInt32:
        ATemp.Add(AParam.Name, AParam.ParamType).AsInteger := AParam.AsInteger;
      ptInt64, ptUInt64:
        ATemp.Add(AParam.Name, AParam.ParamType).AsInt64 := AParam.AsInt64;
      ptFloat4:
        ATemp.Add(AParam.Name, AParam.ParamType).AsSingle := AParam.AsSingle;
      ptFloat8:
        ATemp.Add(AParam.Name, AParam.ParamType).AsFloat := AParam.AsFloat;
      ptDateTime:
        ATemp.Add(AParam.Name, AParam.ParamType).AsFloat := AParam.AsFloat;
      ptInterval:
        ATemp.Add(AParam.Name, AParam.ParamType).AsInt64 := AParam.AsInt64;
      ptAnsiString, ptUtf8String, ptUnicodeString:
        ATemp.Add(AParam.Name, AParam.ParamType).AsString := AParam.AsString;
      ptBoolean:
        ATemp.Add(AParam.Name, AParam.ParamType).AsBoolean := AParam.AsBoolean;
      ptGuid:
        ATemp.Add(AParam.Name, AParam.ParamType).AsGuid := AParam.AsGuid;
      ptBytes:
        begin
          SetLength(ABytes, AParam.GetAsBytes(nil, 0));
          if Length(ABytes) > 0 then
            AParam.GetAsBytes(@ABytes[0], Length(ABytes));
          ATemp.Add(AParam.Name, AParam.ParamType).SetAsBytes(@ABytes[0],
            Length(ABytes));
        end;
      ptStream:
        ATemp.Add(AParam.Name, AParam.ParamType).AsStream := AParam.AsStream;
      ptArray:
        ATemp.Add(AParam.Name, AParam.AsArray);
    end;
  end;
end;

function TQParams.Add(const AName: QStringW; AValue: TStream): Integer;
var
  AParam: TQParam;
begin
  Result := InternalAdd(AName, ptStream, AParam);
  AParam.SetAsStream(NewStream(AValue, True));
end;

function TQParams.Add(const AName: QStringW; const AValue: TBytes): Integer;
var
  AParam: TQParam;
begin
  Result := InternalAdd(AName, ptBytes, AParam);
  if Length(AValue) > 0 then
    AParam.SetAsBytes(@AValue[0], Length(AValue));
end;

procedure TQParams.AddRange(AParams: IQParams; AStartIndex, ACount: Integer);
begin
  while ACount > 0 do
  begin
    Add(AParams[AStartIndex]);
    Inc(AStartIndex);
  end;
end;

function TQParams.Add(const AName: QStringW; AParamType: TQParamType): TQParam;
var
  AParam: TQParam;
begin
  AParam := TQParam.Create(Self);
  AParam.FName := AName;
  AParam.DataType := AParamType;
  Add(AParam);
  Result := AParam;
end;

function TQParams.ByName(const AName: PWideChar): IQParam;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FItems.Count - 1 do
  begin
    if Items[I].Name = AName then
    begin
      Result := Items[I];
      Break;
    end;
  end;
end;

function TQParams.ByPath(APath: PWideChar): IQParam;
var
  AParent: TQParams;
  AName: QStringW;
begin
  AParent := Self;
  Result := nil;
  if Assigned(APath) then
  begin
    if APath^ = PathDelimiter^ then
      Inc(APath);
    while APath^ <> #0 do
    begin
      AName := DecodeTokenW(APath, PathDelimiter, NullChar, False);
      if Length(AName) > 0 then
      begin
        Result := AParent.ByName(PQCharW(AName));
        if Result.ParamType = ptArray then
          AParent := (Result as IQBaseInterface).GetOriginPointer
          // TQParams
        else
          Break;
      end;
    end;
    if APath^ <> NullChar then
      Result := nil;
  end;
end;

procedure TQParams.Clear;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    TQParam(FItems.Items[I])._Release;
  FItems.Clear;
end;

constructor TQParams.Create;
begin
  inherited;
  FItems := TQParamList.Create;
end;

procedure TQParams.Delete(AIndex: Integer);
begin
  TQParams(FItems[AIndex])._Release;
  FItems.Delete(AIndex);
end;

destructor TQParams.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

function TQParams.GetAsString: IQString;
var
  I: Integer;
  AParam: IQParam;
  AHelper: TQStringCatHelperW;
  AHasName: Boolean;
const
  SArrayStart: PWideChar = '[';
  SArrayEnd: PWideChar = ']';
  SObjectStart: PWideChar = '{';
  SObjectEnd: PWideChar = '}';
  SQuoter: WideChar = '"';
  SNameValue: WideChar = ':';
  SDelimiter: WideChar = ',';
begin
  AHelper := TQStringCatHelperW.Create;
  try
    AHasName := False;
    for I := 0 to Count - 1 do
    begin
      AParam := Items[I];
      if (AParam.Name <> nil) and (AParam.Name^ <> #0) then
      begin
        AHasName := True;
        Break;
      end;
    end;
    if AHasName then
      AHelper.Cat(SObjectStart, -1)
    else
      AHelper.Cat(SArrayStart, -1);
    for I := 0 to Count - 1 do
    begin
      AParam := Items[I];
      if AHasName then
        AHelper.Cat(QuotedStrW(AParam.Name, SQuoter)).Cat(SNameValue);
      if AParam.ParamType in [ptDateTime, ptInterval, ptAnsiString,
        ptUtf8String, ptUnicodeString, ptGuid, ptBytes, ptStream] then
        AHelper.Cat(QuotedStrW(AParam.AsString.Value, SQuoter))
      else
        AHelper.Cat(AParam.AsString.Value);
      AHelper.Cat(SDelimiter);
    end;
    if Count > 0 then
      AHelper.Back(1);
    if AHasName then
      AHelper.Cat(SObjectEnd, -1)
    else
      AHelper.Cat(SArrayEnd, -1);
    Result := NewString(AHelper.Value);
  finally
    FreeObject(AHelper);
  end;
end;

function TQParams.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TQParams.GetDItems(AIndex: Integer): TQParam;
begin
  Result := TQParam(FItems[AIndex]);
end;

function TQParams.GetItems(AIndex: Integer): IQParam;
begin
  Result := TQParam(FItems[AIndex]);
end;

function TQParams.InternalAdd(const AName: QStringW; AParamType: TQParamType;
  var AResult: TQParam): Integer;
begin
  AResult := TQParam.Create(Self);
  AResult.FName := AName;
  AResult.DataType := AParamType;
  Result := Add(AResult);
end;

procedure TQParams.LoadFromFile(const AFileName: PWideChar);
var
  AStream: TMemoryStream;
begin
  AStream := TMemoryStream.Create;
  try
    AStream.LoadFromFile(AFileName);
    LoadFromStream(AStream);
  finally
    FreeAndNil(AStream);
  end;
end;

procedure TQParams.LoadFromStream(AStream: TStream);
var
  I, ACount: Integer;
  C, AName: TQValue;
  AParam: TQParam;
begin
  Clear;
  C.LoadFromStream(AStream);
  try
    ACount := C.AsInteger;
    for I := 0 to ACount - 1 do
    begin
      AParam := TQParam.Create(Self);
      AName.LoadFromStream(AStream);
      AParam.FName := AName.Value.AsString^;
      AStream.ReadBuffer(AParam.FType, SizeOf(TQParamType));
      AParam.FValue.LoadFromStream(AStream);
      Add(AParam);
    end;
  finally
    AName.Reset;
  end;
end;

procedure TQParams.LoadFromFile(const AFileName: QStringW);
begin
  LoadFromFile(PQCharW(AFileName));
end;

procedure TQParams.LoadFromStream(AStream: IQStream);
var
  ATemp: TQStream;
begin
  ATemp := NewStream(AStream);
  try
    LoadFromStream(ATemp);
  finally
    FreeAndNil(ATemp);
  end;
end;

procedure TQParams.SaveToFile(const AFileName: PWideChar);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    FreeAndNil(AStream);
  end;
end;

procedure TQParams.SaveToStream(AStream: TStream);
var
  I: Integer;
  AParam: TQParam;
begin
  TQValue.WriteInt(AStream, Count);
  for I := 0 to FItems.Count - 1 do
  begin
    AParam := Items[I];
    TQValue.WriteString(AStream, AParam.Name);
    TQValue.WriteInt(AStream, Integer(AParam.FType));
    TQValue.WriteValue(AStream, AParam.FValue);
  end;
end;

procedure TQParams.SaveToFile(const AFileName: QStringW);
begin
  SaveToFile(PQCharW(AFileName));
end;

procedure TQParams.SaveToStream(AStream: IQStream);
var
  ATemp: TQStream;
begin
  ATemp := NewStream(AStream);
  try
    SaveToStream(ATemp);
  finally
    FreeAndNil(ATemp);
  end;
end;

procedure TQParams.SetDItems(AIndex: Integer; const Value: TQParam);
begin
  if Value <> Items[AIndex] then
  begin
{$IFDEF UNICODE}
    FItems[AIndex] := Value;
{$ELSE}
    IQParam(FItems[AIndex])._Release;
    FItems[AIndex] := Value;
{$ENDIF}
  end;
end;

function NewParams(const AValues: array of const): IQParams;
var
  I: Integer;
  procedure AddParam(AType: BYTE; const AValue: TVarRec);
  begin
    case AValues[I].VType of
      vtInteger:
        Result.Add(nil, ptInt32).AsInteger := AValues[I].VInteger;
      vtBoolean:
        Result.Add(nil, ptBoolean).AsBoolean := AValues[I].VBoolean;
{$IFNDEF NEXTGEN}
      vtChar:
        Result.Add(nil, ptUnicodeString).AsString :=
          NewString(PWideChar(AnsiDecode(@AValues[I].VChar, 1)));
{$ENDIF !NEXTGEN}
      vtExtended:
        Result.Add(nil, ptFloat8).AsFloat := AValues[I].VExtended^;
{$IFNDEF NEXTGEN}
      vtPChar:
        Result.Add(nil, ptAnsiString).AsString :=
          NewString(PWideChar(AnsiDecode(@AValues[I].VPChar, -1)));
      vtString:
        Result.Add(nil, ptUnicodeString).AsString :=
          NewString(PWideChar(AnsiDecode(PQCharA(AValues[I].VString), -1)));
      vtAnsiString:
        Result.Add(nil, ptAnsiString).AsString :=
          NewString(PWideChar(AnsiDecode(
{$IFDEF UNICODE}
          PAnsiString(AValues[I].VAnsiString)^
{$ELSE}
          PQCharA(AValues[I].VPChar), -1
{$ENDIF UNICODE}
          )));
      vtWideString:
        Result.Add(nil, ptUnicodeString).AsString :=
          NewString(PWideChar(AValues[I].VWideString^));
{$ENDIF !NEXTGEN}
      vtPointer:
        Result.Add(nil, ptInt64).AsInt64 := IntPtr(AValues[I].VPointer);
      vtWideChar:
        Result.Add(nil, ptUnicodeString).AsString :=
          NewString(PWideChar(StrDupX(@AValues[I].VWideChar, 1)));
      vtPWideChar:
        Result.Add(nil, ptUnicodeString).AsString :=
          NewString(AValues[I].VPWideChar);
      vtCurrency:
        Result.Add(nil, ptFloat8).AsFloat := AValues[I].VCurrency^;
      vtInt64:
        Result.Add(nil, ptInt64).AsInt64 := AValues[I].VInt64^;
{$IFDEF UNICODE}       // variants
      vtUnicodeString:
        Result.Add(nil, ptUnicodeString).AsString :=
          NewString(AValues[I].VPWideChar);
{$ENDIF UNICODE}
      vtVariant:
        // AddParam(AValues[I].VVariant^.VType, AValues[I].VVariant^)
      else
        raise QException.CreateFmt(SUnsupportParamArrayItem, [I]);
    end;
  end;

begin
  Result := TQParams.Create;
  for I := 0 to High(AValues) do
  begin
    AddParam(AValues[I].VType, AValues[I]);
  end;
end;

function TQParams.ByName(const AName: QStringW): IQParam;
begin

end;

function TQParams.ByPath(APath: QStringW): IQParam;
begin

end;

{ TQUnicodeString }

constructor TQUnicodeString.Create(const S: QStringW);
begin
  inherited Create;
  FValue := S;
end;

function TQUnicodeString.GetValue: PWideChar;
begin
  Result := PWideChar(FValue);
end;

constructor TQUnicodeString.Create;
begin
  inherited;
end;

function TQUnicodeString.GetLength: Integer;
begin
  Result := Length(FValue);
end;

procedure TQUnicodeString.SetValue(const S: PWideChar);
begin
  FValue := S;
end;

procedure TQUnicodeString.SetLength(ALen: Integer);
begin
  system.SetLength(FValue, ALen);
end;
{ TQParamString }

constructor TQParamString.Create(AValue: PQValue);
begin
  inherited Create;
  FValue := AValue;
end;

destructor TQParamString.Destroy;
begin
  inherited;
end;

function TQParamString.GetLength: Integer;
begin
  FText := FValue.AsString;
  Result := Length(FText);
end;

function TQParamString.GetValue: PWideChar;
begin
  FText := FValue.AsString;
  Result := PWideChar(FText);
end;

procedure TQParamString.SetLength(ALen: Integer);
begin
  if FValue.ValueType = vdtString then
    system.SetLength(FValue.Value.AsString^, ALen);
end;

procedure TQParamString.SetValue(const S: PWideChar);
begin
  FValue.AsString := S;
end;

function ParamAsString(AParam: IQParam): QStringW;
var
  S: IQString;
begin
  if Assigned(AParam) then
  begin
    S := AParam.AsString;
    SetLength(Result, S.Length);
    Move(S.Value^, PQCharW(Result)^, S.Length shl 1);
  end
  else
    SetLength(Result, 0);
end;

function ParamAsBytes(AParam: IQParam): TBytes;
var
  L: Cardinal;
begin
  if Assigned(AParam) then
  begin
    L := AParam.GetAsBytes(nil, 0);
    SetLength(Result, L);
    if L > 0 then
      AParam.GetAsBytes(@Result[0], L);
  end
  else
    SetLength(Result, 0);
end;

{ TQParamHelper }

constructor TQParamHelper.Create(AIntf: IQParam);
begin
  inherited Create;
  FInterface := AIntf;
end;

function TQParamHelper.GetAsArray: IQParams;
begin
  Result := FInterface.AsArray;
end;

function TQParamHelper.GetAsBoolean: Boolean;
begin
  Result := FInterface.AsBoolean;
end;

function TQParamHelper.GetAsBytes(ABuf: PByte; ABufLen: Cardinal): Cardinal;
begin
  Result := FInterface.GetAsBytes(ABuf, ABufLen);
end;

function TQParamHelper.GetAsDBytes: TBytes;
begin
  SetLength(Result, GetAsBytes(nil, 0));
  if Length(Result) > 0 then
    GetAsBytes(@Result[0], Length(Result));
end;

function TQParamHelper.GetAsDVariant: Variant;
  procedure BytesToVar;
  var
    ASize: Cardinal;
  begin
    ASize := FInterface.GetAsBytes(nil, 0);
    if ASize = 0 then
      Result := Null
    else
    begin
      Result := VarArrayCreate([0, ASize - 1], varByte);
      FInterface.GetAsBytes(VarArrayLock(Result), ASize);
      VarArrayUnlock(Result);
    end;
  end;

  procedure StreamToVar;
  var
    ASize: Int64;
    AStream: IQStream;
  begin
    AStream := FInterface.AsStream;
    ASize := AStream.Seek(0, soFromEnd);
    if ASize = 0 then
      Result := Null
    else
    begin
      Result := VarArrayCreate([0, ASize - 1], varByte);
      AStream.Read(VarArrayLock(Result), ASize);
      VarArrayUnlock(Result);
    end;
  end;

  procedure ArrayToVar;
  var
    I: Integer;
    AItems: IQParams;
  begin
    AItems := FInterface.AsArray;
    if AItems.Count > 0 then
    begin
      Result := VarArrayCreate([0, AItems.Count - 1], varVariant);
      for I := 0 to AItems.Count - 1 do
        Result[I] := ParamHelper(AItems[I]).AsVariant;
    end
    else
      Result := Null;
  end;

begin
  if FInterface is TQParam then
    Result := (FInterface as TQParam).GetAsDVariant
  else
  begin
    case FInterface.ParamType of
      ptInt8:
        Result := ShortInt(FInterface.AsInteger);
      ptUInt8:
        Result := BYTE(FInterface.AsInteger);
      ptInt16:
        Result := SmallInt(FInterface.AsInteger);
      ptUInt16:
        Result := Word(FInterface.AsInteger);
      ptInt32:
        Result := FInterface.AsInteger;
      ptUInt32:
        Result := Cardinal(FInterface.AsInteger);
      ptInt64:
        Result := FInterface.AsInt64;
      ptUInt64:
        Result := UInt64(FInterface.AsInt64);
      ptFloat4:
        Result := FInterface.AsFloat;
      ptFloat8:
        Result := FInterface.AsFloat;
      ptDateTime:
        Result := FInterface.AsFloat;
      ptInterval:
        Result := FInterface.AsInt64;
      ptAnsiString:
{$IFNDEF NEXTGEN}
        Result := AnsiString(GetAsUString);
{$ELSE}
        Result := GetAsUString;
{$ENDIF}
      ptUtf8String:
        Result := GetAsUString;
      ptUnicodeString:
        Result := GetAsUString;
      ptBoolean:
        Result := FInterface.AsBoolean;
      ptGuid:
        Result := GuidToString(FInterface.AsGuid);
      ptBytes:
        BytesToVar;
      ptStream:
        StreamToVar;
      ptArray:
        ArrayToVar;
    end;
  end;
end;

function TQParamHelper.GetAsFloat: Double;
begin
  Result := FInterface.AsFloat;
end;

function TQParamHelper.GetAsGuid: TGuid;
begin
  Result := FInterface.AsGuid;
end;

function TQParamHelper.GetAsInt64: Int64;
begin
  Result := FInterface.AsInt64;
end;

function TQParamHelper.GetAsInteger: Integer;
begin
  Result := FInterface.AsInteger;
end;

function TQParamHelper.GetAsSingle: Single;
begin
  Result := FInterface.AsSingle;
end;

function TQParamHelper.GetAsStream: IQStream;
begin
  Result := FInterface.AsStream;
end;

function TQParamHelper.GetAsString: IQString;
begin
  Result := FInterface.AsString;
end;

function TQParamHelper.GetAsUString: QStringW;
begin
  Result := FInterface.AsString.Value;
end;

function TQParamHelper.GetIsNull: Boolean;
begin
  Result := FInterface.IsNull;
end;

function TQParamHelper.GetName: PWideChar;
begin
  Result := FInterface.Name;
end;

function TQParamHelper.GetParent: IQParams;
begin
  Result := FInterface.Parent;
end;

function TQParamHelper.GetType: TQParamType;
begin
  Result := FInterface.ParamType;
end;

function TQParamHelper.GetUName: QStringW;
begin
  Result := FInterface.Name;
end;

procedure TQParamHelper.SetAsBoolean(const AValue: Boolean);
begin
  FInterface.AsBoolean := AValue;
end;

procedure TQParamHelper.SetAsBytes(ABuf: PByte; ABufLen: Cardinal);
begin
  FInterface.SetAsBytes(ABuf, ABufLen);
end;

procedure TQParamHelper.SetAsDBytes(const AValue: TBytes);
begin
  if Length(AValue) > 0 then
    SetAsBytes(@AValue[0], Length(AValue))
  else
    SetAsBytes(nil, 0);
end;

procedure TQParamHelper.SetAsDVariant(const V: Variant);
  procedure FromVar;
  begin
    raise Exception.CreateFmt(SUnsupportNow,
      ['TQParamHelper.SetAsDVaraint.FromVar']);
  end;

  procedure ToBytes;
  begin
    raise Exception.CreateFmt(SUnsupportNow,
      ['TQParamHelper.SetAsDVaraint.FromVar']);
  end;
  procedure ToStream;
  begin
    raise Exception.CreateFmt(SUnsupportNow,
      ['TQParamHelper.SetAsDVaraint.FromVar']);
  end;
  procedure ToArray;
  begin
    raise Exception.CreateFmt(SUnsupportNow,
      ['TQParamHelper.SetAsDVaraint.FromVar']);
  end;

begin
  case FInterface.ParamType of
    ptUnknown:
      FromVar;
    ptInt8, ptUInt8, ptInt16, ptUInt16, ptInt32:
      FInterface.AsInteger := V;
    ptUInt32, ptInt64, ptUInt64:
      FInterface.AsInt64 := V;
    ptFloat4:
      FInterface.AsSingle := V;
    ptFloat8:
      FInterface.AsFloat := V;
    ptDateTime:
      FInterface.AsFloat := V;
    ptInterval:
      FInterface.AsInt64 := V;
    ptAnsiString, ptUtf8String, ptUnicodeString:
      SetAsUString(V);
    ptBoolean:
      FInterface.AsBoolean := V;
    ptGuid:
      FInterface.AsGuid := StringToGuid(V);
    ptBytes:
      ToBytes;
    ptStream:
      ToStream;
    ptArray:
      ToArray;
  end;
end;

procedure TQParamHelper.SetAsFloat(const AValue: Double);
begin
  FInterface.AsFloat := AValue;
end;

procedure TQParamHelper.SetAsGuid(const Value: TGuid);
begin
  FInterface.AsGuid := Value;
end;

procedure TQParamHelper.SetAsInt64(const AValue: Int64);
begin
  FInterface.AsInt64 := AValue;
end;

procedure TQParamHelper.SetAsInteger(const AValue: Integer);
begin
  FInterface.AsInteger := AValue;
end;

procedure TQParamHelper.SetAsSingle(const AValue: Single);
begin
  FInterface.AsSingle := AValue;
end;

procedure TQParamHelper.SetAsStream(AStream: IQStream);
begin
  FInterface.AsStream := AStream;
end;

procedure TQParamHelper.SetAsString(const AValue: IQString);
begin
  FInterface.AsString := AValue;
end;

procedure TQParamHelper.SetAsUString(const S: QStringW);
begin
  FInterface.AsString := NewString(S);
end;

procedure TQParamHelper.SetNull;
begin
  FInterface.SetNull;
end;

procedure TQParamHelper.SetType(const AType: TQParamType);
begin
  FInterface.SetType(AType);
end;

{ TQParamsHelper }

function TQParamsHelper.Add(const AName, AValue: QStringW): Integer;
begin
  Result := FInterface.Count;
  ParamHelper(FInterface.Add(PQCharW(AName), ptUnicodeString)).AsString
    := AValue;
end;

function TQParamsHelper.Add(const AName: QStringW; AValue: Variant): Integer;
begin
  Result := FInterface.Count;
  ParamHelper(FInterface.Add(PQCharW(AName), ptUnknown)).AsVariant := AValue;
end;

function TQParamsHelper.Add(const AName: QStringW; AValue: Boolean): Integer;
begin
  Result := FInterface.Count;
  FInterface.Add(PQCharW(AName), ptBoolean).AsBoolean := AValue;
end;

function TQParamsHelper.Add(const AName: QStringW; AValue: Int64): Integer;
begin
  Result := FInterface.Count;
  FInterface.Add(PQCharW(AName), ptInt64).AsInt64 := AValue;
end;

function TQParamsHelper.Add(const AName: QStringW; AValue: Double): Integer;
begin
  Result := FInterface.Count;
  FInterface.Add(PQCharW(AName), ptFloat8).AsFloat := AValue;
end;

function TQParamsHelper.Add(const AName: QStringW; const AValue: PByte;
  ALen: Integer): Integer;
begin
  Result := FInterface.Count;
  FInterface.Add(PQCharW(AName), ptBytes).SetAsBytes(AValue, ALen);
end;

function TQParamsHelper.Add(const AName: QStringW; const AValue: TGuid)
  : Integer;
begin
  Result := FInterface.Count;
  FInterface.Add(PQCharW(AName), ptGuid).AsGuid := AValue;
end;

function TQParamsHelper.Add(const AName: PWideChar;
  AParamType: TQParamType): IQParam;
begin
  Result := FInterface.Add(AName, AParamType);
end;

function TQParamsHelper.Add(const AName: QStringW; AValue: TStream): Integer;
begin
  Result := FInterface.Count;
  FInterface.Add(PQCharW(AName), ptStream).AsStream := NewStream(AValue, True);
end;

function TQParamsHelper.Add(const AName: QStringW;
  const AValue: TBytes): Integer;
begin
  Result := FInterface.Count;
  if Length(AValue) > 0 then
    FInterface.Add(PQCharW(AName), ptBytes).SetAsBytes(@AValue[0],
      Length(AValue))
  else
    FInterface.Add(PQCharW(AName), ptBytes);
end;

function TQParamsHelper.ByName(const AName: QStringW): IQParam;
begin
  Result := FInterface.ByName(PQCharW(AName));
end;

function TQParamsHelper.ByName(const AName: PWideChar): IQParam;
begin
  Result := FInterface.ByName(AName);
end;

function TQParamsHelper.ByPath(APath: PWideChar): IQParam;
begin
  Result := FInterface.ByPath(APath);
end;

function TQParamsHelper.ByPath(APath: QStringW): IQParam;
begin
  Result := FInterface.ByPath(PQCharW(APath));
end;

procedure TQParamsHelper.Clear;
begin
  FInterface.Clear;
end;

constructor TQParamsHelper.Create(AIntf: IQParams);
begin
  inherited Create;
  FInterface := AIntf;
end;

procedure TQParamsHelper.Delete(AIndex: Integer);
begin
  FInterface.Delete(AIndex);
end;

function TQParamsHelper.GetAsString: IQString;
begin
  Result := FInterface.AsString;
end;

function TQParamsHelper.GetCount: Integer;
begin
  Result := FInterface.Count;
end;

function TQParamsHelper.GetItems(AIndex: Integer): IQParam;
begin
  Result := FInterface[AIndex];
end;

procedure TQParamsHelper.LoadFromFile(const AFileName: PWideChar);
begin
  FInterface.LoadFromFile(AFileName);
end;

procedure TQParamsHelper.LoadFromStream(AStream: IQStream);
begin
  FInterface.LoadFromStream(AStream);
end;

procedure TQParamsHelper.SaveToFile(const AFileName: PWideChar);
begin
  FInterface.SaveToFile(AFileName);
end;

procedure TQParamsHelper.SaveToStream(AStream: IQStream);
begin
  FInterface.SaveToStream(AStream);
end;

procedure TQParamsHelper.LoadFromFile(const AFileName: QStringW);
begin
  FInterface.SaveToFile(PQCharW(AFileName));
end;

procedure TQParamsHelper.LoadFromStream(AStream: TStream);
begin
  FInterface.LoadFromStream(NewStream(AStream, False));
end;

procedure TQParamsHelper.SaveToFile(const AFileName: QStringW);
begin
  FInterface.SaveToFile(PQCharW(AFileName));
end;

procedure TQParamsHelper.SaveToStream(AStream: TStream);
begin
  FInterface.SaveToStream(NewStream(AStream, False));
end;

function TQParamsHelper.Add(const AName: PWideChar;
  AChildren: IQParams): IQParam;
begin
  Result := FInterface.Add(AName, AChildren);
end;

end.
