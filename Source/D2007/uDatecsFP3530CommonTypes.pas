unit uDatecsFP3530CommonTypes;

interface
uses SysUtils, Classes;
type
  {Параметры логирования состояний фискального регистратора.
        записывать в лог файл параметры подключения фискального регистратора.
    AddToLogConnectParams: Boolean;
      0 -  не записвывать в лог данные RetData никогда, 1 - записывать в
      зависмотсти от AddToLogRetDataInGetStatus
    AddToLogRetDataInAllActions: Boolean;
      0 - не записывать в логи данные RetData при выполнении процедуры GetState
    AddToLogRetDataInGetStatus: Boolean; }

  TDatecsFP3530LogOption = (loAddToLogConnectParams, loAddToLogRetDataInAllActions,
    loAddToLogRetDataInGetStatus);

  TDatecsFP3530LogOptions = set of TDatecsFP3530LogOption;
  { Выводить информацию о продаже на дисплей
    DisplayWhileSaleItem: Boolean;
      На дисплее отображается величина подсуммы
    DisplayWhileSubTotal: Boolean;
      Отображать на дисплее печать Х - отчета
    DisplayWhileReportX: Boolean;
      Печатать на чеке величину подсуммы
    PrintWhileSubTotal: Boolean;}

  TDatecsFP3530DisplayOption = (doDisplayWhileSaleItem, doDisplayWhileSubTotal,
    doDisplayWhileReportX, doPrintWhileSubTotal);
    
  TDatecsFP3530DisplayOptions = set of TDatecsFP3530DisplayOption;

 {если true , то возвращается информация о об оплате последнего чека (сумма,
      которую заплатил клиент по последнему чеку)
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

  {Для работы с fp.bpl}
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
  {Для работы с fp.bpl - которая вызывается для получения результата работы
   регистратора}
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

  {Общие флаги состояния регистратора.}
  TCommonStates = packed record
    {Во время работы фискального регистратора произошла ошибка, которая привела
     регистратор в некорректное состояние.}
    //FatalError: Boolean;
    {Есть открытые счета в регистраторе.}
    ExistsOpenReceipt: Boolean;
    {Можно аннулироваьт счет}
    CanCanselReceipt:  Boolean;
    {Можно закрыть чек}
    CanCloseReceipt: Boolean;
    {Можноо дооплатить счет}
    CanRePayReceipt: Boolean;
  end;
  
  {Общие флаги состояния регистратора.}
  TRegistratorStates = packed record
    {Дополнителные состояния регистратора.}
    AdditioanStates: TAdditioanStates;
    BitStates_0: TStateBits;
    BitStates_1: TStateBits;
    BitStates_2: TStateBits;
    BitStates_3: TStateBits;
    BitStates_4: TStateBits;
    BitStates_5: TStateBits;
  end;

     {Артикулы}
  TArticle = class
  public
        {Номер запрограммированного артикула.}
    FCode: Integer;
      {Цена единицф товара.}
    FPrice: Double;
      {Название артикула, печатается на чеке.}
    FName: string;
      {Указатель на дополнителные данные (для разработчиков).}
    FData: Pointer;
      {Прищнак того то артикул был продан после последнего Z - отчета}
    FisSaled: Boolean; 
    constructor Create();
    destructor Destroy(); override;
  end;
  
    {Строки счета}
  TItem = class
  public
      {Тип оплаты}
    FInventoryGroup: Char;
      {Группа.}
    FGroup: Integer;
      {Номер запрограммированного артикула.}
    FCode: Integer;
      {Цена единицф товара.}
    FPrice: Double;
    //Сумма скидки "-" скидка, "+" надбавка .
    FDiscountSum: Double;
    //Сумма скидки "-" скидка, "+" надбавка   -99.00 .. +99.00 .
    FDiscountPercent: Double;
      {Название артикула, печатается на чеке.}
    FName: string;
      {Продаваемое количество.}
    FQuantity: Double;
      {Указатель на дополнителные данные (для разработчиков).}
    FData: Pointer;
    constructor Create;
    destructor Destroy(); override;
  end;

    {Процедурный ти для свойства, которое вызывается перед начало выполнения
    некоторого действия.}
  TOnBeforeRegistratorEvent = procedure(ASender: TObject; AFatalError: Boolean;
    ARetData: TRetData) of object;
    {Процедурный ти для свойства, которое вызывается после завершения некоторого
    действия.}
  TOnAfterRegistratorEvent = procedure(ASender: TObject; AFatalError: Boolean;
    ARetData: TRetData) of object;
    {Процедурный ти для свойства, которое вызывается в начале выполнения
    некоторого действия.}
  TOnStartRegistratorEvent = procedure(ASender: TObject; AFatalError: Boolean;
    ARetData: TRetData; Resalt: Boolean) of object;
    {Процедурный ти для свойства, которое вызывается при завершении некоторого
    действия.}
  TOnFinishRegistratorEvent = procedure(ASender: TObject; AFatalError: Boolean; ARetData: TRetData; Resalt: Boolean) of object;

    {Процедурный ти для свойства, которое вызывается в начале выполнения
     некоторого действия, результат которого целое число.}
  TOnStartRegistratorEventExtended = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Integer) of object;
    {Процедурный ти для свойства, которое вызывается при завершении некоторого
    действия, результат которого целое число.}
  TOnFinishRegistratorEventExtended = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Integer) of object;
    {Процедурный ти для свойства, которое вызывается перед началом выполнения
    некоторого действия, результат которого целое число.}
  TOnBeforeRegistratorEventExtended = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Integer) of object;
    {Процедурный ти для свойства, которое вызывается после завершения выполнения
    некоторого действия, результат которого целое число.}
  TOnAfterRegistratorEventExtended = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Integer) of object;

    {Процедурный ти для свойства, которое вызывается перед началом выпонения
    некоторого действия над элементом счета.}
  TOnBeforeRegistratorEventItem = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Boolean;
    AItemIndex: Integer; AItem: TItem) of object;
    {Процедурный ти для свойства, которое вызывается после завершения выпонения
    некоторого действия над элементом счета.}
  TOnAfterRegistratorEventItem = procedure(ASender: TObject;
    AFatalError: Boolean; ARetData: TRetData; Resalt: Boolean;
    AItemIndex: Integer; AItem: TItem) of object;

    {Счет}
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
      {Строки счета.}
    FData: Pointer;  
    FVisitItems: TList;
    constructor Create();
    destructor Destory();
      {Очитить содержимое счета}
    function Clear: Boolean;
    function GetTotal: Double;
      {Сумма счета.}
    property Total: Double read FTotal write SetTotal;
      {Подитог счета.}
    property SubTotalSum: Double read FSubTotalSum write SetSubTotalSum;
      {Подитог сета %.}
    property SubTotalPercent: Double read FSubTotalPercent write SetSubTotalPercent;
      {Тип оплаты.}
    property PaymentType: Char read FPaymentType write SetPaymentType;
      {Комментарий.}
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
