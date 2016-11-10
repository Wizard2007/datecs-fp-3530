unit uDatecsFP3530CommonTypes;

interface
uses SysUtils, Classes;
type
  {��������� ����������� ��������� ����������� ������������.
        ���������� � ��� ���� ��������� ����������� ����������� ������������.
    AddToLogConnectParams: Boolean;
      0 -  �� ����������� � ��� ������ RetData �������, 1 - ���������� �
      ����������� �� AddToLogRetDataInGetStatus
    AddToLogRetDataInAllActions: Boolean;
      0 - �� ���������� � ���� ������ RetData ��� ���������� ��������� GetState
    AddToLogRetDataInGetStatus: Boolean; }

  TDatecsFP3530LogOption = (loAddToLogConnectParams, loAddToLogRetDataInAllActions,
    loAddToLogRetDataInGetStatus);

  TDatecsFP3530LogOptions = set of TDatecsFP3530LogOption;
  { �������� ���������� � ������� �� �������
    DisplayWhileSaleItem: Boolean;
      �� ������� ������������ �������� ��������
    DisplayWhileSubTotal: Boolean;
      ���������� �� ������� ������ � - ������
    DisplayWhileReportX: Boolean;
      �������� �� ���� �������� ��������
    PrintWhileSubTotal: Boolean;}

  TDatecsFP3530DisplayOption = (doDisplayWhileSaleItem, doDisplayWhileSubTotal,
    doDisplayWhileReportX, doPrintWhileSubTotal);
    
  TDatecsFP3530DisplayOptions = set of TDatecsFP3530DisplayOption;

 {���� true , �� ������������ ���������� � �� ������ ���������� ���� (�����,
      ������� �������� ������ �� ���������� ����)
    isReturnInfoSAboutPayLastReceipt: Boolean;}
  TDatecsFP3530ReturnOption = (roIsReturnInfoSAboutPayLastReceipt);
  TDatecsFP3530ReturnOptions = set of TDatecsFP3530ReturnOption;

  TExceptionGenerateOption = (egoNotGenerate, egoOpen, egoConnect,
    egoNonfiscalReceiptClose, egoNonfiscalReceiptOpen, egoPrintEmptyReceipt,
    egoPrintFiscalTextOnVisit, egoPrintNonfiscalTextOnVisit, egoReport_X,
    egoReport_Z, egoAddToLogRetData, egoClose, egoDisConnect,
    egoSetRegistratorDateTime, egoGetRegistratorSums, egoServiceInOut,
    egoGetLastReceiptNo, egoSetHeadeFooters, egoReceiptReset,
    egoProgrammedCurrentOperatorName, egoProgrammedOperatorNameByNamber,
    egoProgrammingVisitItems, egoSaleItem, egoSaleArticles, egoPrintReceipt,
    egoFiscalReceiptOpen, egoFiscalReceiptClose, egoFiscalReceiptSubTotal,
    egoFiscalReceiptTotal, egoDeleteArticleByItemNo, egoDeleteAllArticle,
    egoGetRegistratorStatus);
  TExceptionGenerateOptions = set of TExceptionGenerateOption;

  {��� ������ � fp.bpl}
  TRetData = packed record
    Count: integer;
    CmdCode: integer;
    UserData: integer;
    Status: integer;
    CmdName: PChar;
    SendStr: PChar;
    Whole: PChar;
    RetItem: array [1..20] of PChar ;
    OrigStat: array [1..6] of   byte	;
  end;
  {��� ������ � fp.bpl - ������� ���������� ��� ��������� ���������� ������
   ������������}
  TPrinterResults = procedure(const rt:TRetData); stdcall;
  TStateBits = packed record
    Bit_0: Boolean;
    Bit_1: Boolean;
    Bit_2: Boolean;
    Bit_3: Boolean;
    Bit_4: Boolean;
    Bit_5: Boolean;
    Bit_6: Boolean;
    Bit_7: Boolean;
  end;
  TAdditioanStates = packed record
    SYNTAX_ERROR: Boolean;
    INVALID_CMD: Boolean;
    INVALID_TIME: Boolean;
    PRINT_ERROR: Boolean;
    SUM_OVERFLOW: Boolean;
    CMD_NOT_ALLOWED: Boolean;
    RAM_CLEARED: Boolean;
    PRINT_RESTART: Boolean;
    RAM_DESTROYED: Boolean;
    PAPER_OUT: Boolean;
    FISCAL_OPEN: Boolean;
    NONFISCAL_OPEN: Boolean;
    SERVICE_OPEN: Boolean;
    F_ABSENT: Boolean;
    F_MODULE_NUM: Boolean;
    F_WRITE_ERROR: Boolean;
    F_FULL: Boolean;
    F_READ_ONLY: Boolean;
    F_CLOSE_ERROR: Boolean;
    F_LESS_30: Boolean;
    F_FORMATTED: Boolean;
    F_FISCALIZED: Boolean;
    F_SER_NUM: Boolean;
    PROTOCOL_ERROR: Boolean;
    NACK_RECEIVED: Boolean;
    TIMEOUT_ERROR: Boolean;
    COMMON_ERROR: Boolean;
    F_COMMON_ERROR: Boolean;
    ADD_PAPER: Boolean;
    ANY_ERROR: Boolean;
  end;

  {����� ����� ��������� ������������.}
  TCommonStates = packed record
    {�� ����� ������ ����������� ������������ ��������� ������, ������� �������
     ����������� � ������������ ���������.}
    //FatalError: Boolean;
    {���� �������� ����� � ������������.}
    ExistsOpenReceipt: Boolean;
    {����� ������������ ����}
    CanCanselReceipt:  Boolean;
    {����� ������� ���}
    CanCloseReceipt: Boolean;
    {������ ���������� ����}
    CanRePayReceipt: Boolean;
  end;
  
  {����� ����� ��������� ������������.}
  TRegistratorStates = packed record
    {������������� ��������� ������������.}
    AdditioanStates: TAdditioanStates;
    BitStates_0: TStateBits;
    BitStates_1: TStateBits;
    BitStates_2: TStateBits;
    BitStates_3: TStateBits;
    BitStates_4: TStateBits;
    BitStates_5: TStateBits;
  end;

     {��������}
  TArticle = class
  public
        {����� �������������������� ��������.}
    FCode: Integer;
      {���� ������� ������.}
    FPrice: Double;
      {�������� ��������, ���������� �� ����.}
    FName: string;
      {��������� �� ������������� ������ (��� �������������).}
    FData: Pointer;
      {������� ���� �� ������� ��� ������ ����� ���������� Z - ������}
    FisSaled: Boolean; 
    constructor Create();
    destructor Destroy(); override;
  end;
  
    {������ �����}
  TItem = class
  public
      {��� ������}
    FInventoryGroup: Char;
      {������.}
    FGroup: Integer;
      {����� �������������������� ��������.}
    FCode: Integer;
      {���� ������� ������.}
    FPrice: Double;
    //����� ������ "-" ������, "+" �������� .
    FDiscountSum: Double;
    //����� ������ "-" ������, "+" ��������   -99.00 .. +99.00 .
    FDiscountPercent: Double;
      {�������� ��������, ���������� �� ����.}
    FName: string;
      {����������� ����������.}
    FQuantity: Double;
      {��������� �� ������������� ������ (��� �������������).}
    FData: Pointer;
    constructor Create;
    destructor Destroy(); override;
  end;

    {����������� �� ��� ��������, ������� ���������� ����� ������ ����������
    ���������� ��������.}
  TOnBeforeRegistratorEvent = procedure(ASender: TObject; AFatalError: Boolean;
    ARetData: TRetData) of object;
    {����������� �� ��� ��������, ������� ���������� ����� ���������� ����������
    ��������.}
  TOnAfterRegistratorEvent = procedure(ASender: TObject; AFatalError: Boolean;
    ARetData: TRetData) of object;
    {����������� �� ��� ��������, ������� ���������� � ������ ����������
    ���������� ��������.}
  TOnStartRegistratorEvent = procedure(ASender: TObject; AFatalError: Boolean;
    ARetData: TRetData; Resalt: Boolean) of object;
    {����������� �� ��� ��������, ������� ���������� ��� ���������� ����������
    ��������.}
  TOnFinishRegistratorEvent = procedure(ASender: TObject; AFatalError: Boolean; ARetData: TRetData; Resalt: Boolean) of object;

    {����������� �� ��� ��������, ������� ���������� � ������ ����������
     ���������� ��������, ��������� �������� ����� �����.}
  TOnStartRegistratorEventExtended = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Integer) of object;
    {����������� �� ��� ��������, ������� ���������� ��� ���������� ����������
    ��������, ��������� �������� ����� �����.}
  TOnFinishRegistratorEventExtended = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Integer) of object;
    {����������� �� ��� ��������, ������� ���������� ����� ������� ����������
    ���������� ��������, ��������� �������� ����� �����.}
  TOnBeforeRegistratorEventExtended = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Integer) of object;
    {����������� �� ��� ��������, ������� ���������� ����� ���������� ����������
    ���������� ��������, ��������� �������� ����� �����.}
  TOnAfterRegistratorEventExtended = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Integer) of object;

    {����������� �� ��� ��������, ������� ���������� ����� ������� ���������
    ���������� �������� ��� ��������� �����.}
  TOnBeforeRegistratorEventItem = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Boolean;
    AItemIndex: Integer; AItem: TItem) of object;
    {����������� �� ��� ��������, ������� ���������� ����� ���������� ���������
    ���������� �������� ��� ��������� �����.}
  TOnAfterRegistratorEventItem = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Boolean;
    AItemIndex: Integer; AItem: TItem) of object;

    {����}
  TVisit = class
  private
    FTotal: Double;
    FSubTotalSum: Double;
    FSubTotalPercent: Double;
    FPaymentType: Char;
    FComment: String;
    procedure SetTotal(const Value: Double);
    procedure SetSubTotalSum(const Value: Double);
    procedure SetSubTotalPercent(const Value: Double);
    procedure SetPaymentType(const Value: Char);
    procedure SetComment(const Value: String);
  public
      {������ �����.}
    FData: Pointer;  
    FVisitItems: TList;
    constructor Create();
    destructor Destory();
      {������� ���������� �����}
    function Clear: Boolean;
    function GetTotal: Double;
      {����� �����.}
    property Total: Double read FTotal write SetTotal;
      {������� �����.}
    property SubTotalSum: Double read FSubTotalSum write SetSubTotalSum;
      {������� ���� %.}
    property SubTotalPercent: Double read FSubTotalPercent write SetSubTotalPercent;
      {��� ������.}
    property PaymentType: Char read FPaymentType write SetPaymentType;
      {�����������.}
    property Comment: String read FComment write SetComment;
  end;

implementation

{ TVisit }

function TVisit.Clear: Boolean;
var
  i: Integer;
  lItem: TItem;
begin
  Result:= True;
  try
    Total:= 0;
    SubTotalSum:= 0;
    SubTotalPercent:= 0;
    PaymentType:= '-';
    Comment:= '';
    if FData <> nil then begin
      Dispose(FData);
      FData:= nil;
    end;
    for I:= 0 to FVisitItems.Count - 1 do
    begin
      lItem:= FVisitItems[i];
      if lItem.FData <> nil then begin
        Dispose(lItem.FData);
        lItem.FData:= nil;
      end;
      lItem.Free;
    end;
    FVisitItems.Clear;
  Except on e: Exception do
    begin
      Result:= False;
    end;
  end;
end;

constructor TVisit.Create;
begin
  FVisitItems:= TList.Create;
end;

destructor TVisit.Destory;
begin
  Clear;
  FVisitItems.Free;
end;

function TVisit.GetTotal: Double;
begin
  Result:= FTotal;
end;

procedure TVisit.SetComment(const Value: String);
begin
  FComment := Value;
end;

procedure TVisit.SetPaymentType(const Value: Char);
begin
  FPaymentType := Value;
end;

procedure TVisit.SetSubTotalPercent(const Value: Double);
begin
  FSubTotalPercent := Value;
end;

procedure TVisit.SetSubTotalSum(const Value: Double);
begin
  FSubTotalSum:= Value;
end;

procedure TVisit.SetTotal(const Value: Double);
begin
  FTotal := Value;
end;

{ TItem }

constructor TItem.Create;
begin
  // do something
end;

destructor TItem.Destroy;
begin
  // do something
end;

{ TArticle }
constructor TArticle.Create;
begin
  Self.FisSaled:= False;
end;

destructor TArticle.Destroy;
begin

end;

end.
