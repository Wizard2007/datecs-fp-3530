unit uDatecsFP3530;

interface

uses
  SysUtils, Classes, Windows, Dialogs, uLogFile, uDatecsFP3530CommonTypes,
  uDatecsFP3530Consts, uDatecsFP3530_UtilCommonFunction, DateUtils;
type
  TtDatecsFP3530 = class(TComponent)
  private
    FFatalError: Boolean;
    FBaudRate: Integer;
    FSerialPortNumber: Integer;
    FEnabled: Boolean;
    FKeepOpened: Boolean;
    FWriteToLog: Boolean;
    FLogFile: TtLogFile;
    FPassWord: String;
    FCashSum: Double;
    FServiceOut: Double;
    FServiceIn: Double;
    FReceiptNo: Integer;
    FHeaderLines: TStrings;
    FVisit: TVisit;
    FItemNameLineLength: Integer;
    FCurrentCashDeskNumber: Cardinal;
    FCurrentOperatorNumber: Cardinal;
    FCurrentOperatorPassword: String;
    FOnAfterOpen: TOnAfterRegistratorEvent;
    FOnBeforeOpen: TOnBeforeRegistratorEvent;
    FOnAfterPrintReceipt: TOnAfterRegistratorEventExtended;
    FOnBeforePrintReceipt: TOnBeforeRegistratorEventExtended;
    FOnFinishPrintReceipt: TOnFinishRegistratorEventExtended;
    FOnStartPrintReceipt: TOnStartRegistratorEventExtended;
    FOnFinishProgrammingVisitItems: TOnFinishRegistratorEvent;
    FOnStartProgrammingVisitItems: TOnStartRegistratorEvent;
    FOnAfterDeleteArticleByItemNo: TOnAfterRegistratorEventItem;
    FOnBeforeDeleteAllArticle: TOnBeforeRegistratorEvent;
    FOnBeforeDeleteArticleByItemNo: TOnBeforeRegistratorEventItem;
    FOnAfterDeleteAllArticle: TOnAfterRegistratorEvent;
    FOnAfterSaleArticles: TOnAfterRegistratorEvent;
    FOnBeforeSaleArticles: TOnBeforeRegistratorEvent;
    FOnAfterSaleItem: TOnAfterRegistratorEventItem;
    FOnBeforeSaleItem: TOnBeforeRegistratorEventItem;
    FOnBeforeProgrammingVisitItems: TOnBeforeRegistratorEventItem;
    FOnAfterProgrammingVisitItems: TOnAfterRegistratorEventItem;
    FOnBeforeReceiptReset: TOnBeforeRegistratorEvent;
    FOnAfterReceiptReset: TOnAfterRegistratorEvent;
    FOnAfterSetHeadeFooters: TOnAfterRegistratorEvent;
    FOnBeforeSetHeadeFooters: TOnBeforeRegistratorEvent;
    FOnBeforeGetLastReceiptNo: TOnBeforeRegistratorEventExtended;
    FOnAfterGetLastReceiptNo: TOnAfterRegistratorEventExtended;
    FOnBeforeFiscalReceiptOpen: TOnBeforeRegistratorEvent;
    FOnAfterFiscalReceiptOpen: TOnAfterRegistratorEvent;
    FOnAfterFiscalReceiptClose: TOnAfterRegistratorEvent;
    FOnBeforeFiscalReceiptClose: TOnBeforeRegistratorEvent;
    FOnBeforeFiscalReceiptSubTotal: TOnBeforeRegistratorEvent;
    FOnAfterFiscalReceiptSubTotal: TOnAfterRegistratorEvent;
    FOnBeforeFiscalReceiptTotal: TOnBeforeRegistratorEvent;
    FOnAfterFiscalReceiptTotal: TOnAfterRegistratorEvent;
    FOnBeforeConnect: TOnBeforeRegistratorEvent;
    FOnAfterConnect: TOnAfterRegistratorEvent;
    FOnAfterDisConnect: TOnAfterRegistratorEvent;
    FOnBeforeDisConnect: TOnBeforeRegistratorEvent;
    FOnBeforeClose: TOnBeforeRegistratorEvent;
    FOnAfterClose: TOnBeforeRegistratorEvent;
    FOnBeforeClrScr: TOnBeforeRegistratorEvent;
    FOnAfterClrScr: TOnAfterRegistratorEvent;
    FOnBeforeReport_X: TOnBeforeRegistratorEvent;
    FOnAfterReport_X: TOnAfterRegistratorEvent;
    FOnBeforeReport_Z: TOnBeforeRegistratorEvent;
    FOnAfterReport_Z: TOnAfterRegistratorEvent;
    FOnAfterGetRegistratorSums: TOnAfterRegistratorEvent;
    FOnBeforeGetRegistratorSums: TOnBeforeRegistratorEvent;
    FOnBeforeServiceInOut: TOnBeforeRegistratorEvent;
    FOnAfterServiceInOut: TOnAfterRegistratorEvent;
    FOnAfterPrintNonfiscalTextOnVisit: TOnAfterRegistratorEvent;
    FOnBeforePrintNonfiscalTextOnVisit: TOnBeforeRegistratorEvent;
    FOnAfterPrintFiscalTextOnVisit: TOnAfterRegistratorEvent;
    FOnBeforePrintFiscalTextOnVisit: TOnBeforeRegistratorEvent;
    FCurrentOperatorName: String;
    FNumOfCharInReceiptLine: Integer;
    FLogOptions: TDatecsFP3530LogOptions;
    FDisplayOptions: TDatecsFP3530DisplayOptions;
    FReturnOptions: TDatecsFP3530ReturnOptions;
    FExceptionGenerateOptions: TExceptionGenerateOptions;
    FReceiptStateText: String;
    FPayByReceipt: Double;
    FStoredByReceipt: Double;
    FConnected: Boolean;
    FisAddedStateMessagesInMesasge: Boolean;
    FCallStackDeep: Integer;
    FErrorMessage: String;

    procedure SetBaudRate(const Value: Integer);
    procedure SetSerialPortNumber(const Value: Integer);
    procedure SetEnabled(const Value: Boolean);
    procedure SetKeepOpened(const Value: Boolean);
    procedure SetWriteToLog(const Value: Boolean);
    procedure SetLogFile(const Value: TtLogFile);
    procedure AnalyseState;
    procedure AddToLogRetData;
    procedure SetPassWord(const Value: String);
    procedure SetCashSum(const Value: Double);
    procedure SetReceiptNo(const Value: Integer);
    procedure SetHeaderLines(const Value: TStrings);
    procedure SetServiceIn(const Value: Double);
    procedure SetServiceOut(const Value: Double);
    procedure SetVisit(const Value: TVisit);
    procedure SetFatalError(const Value: Boolean);
    procedure SetItemNameLineLength(const Value: Integer);
    procedure SetCurrentCashDeskNumber(const Value: Cardinal);
    procedure SetCurrentOperatorNumber(const Value: Cardinal);
    procedure SetCurrentOperatorPassword(const Value: String);
    procedure LogException(AlogLevel: TLogLevel; AMsg: string; AE: Exception; AGenerateException: Boolean);
    procedure SetOnAfterOpen(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeOpen(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterPrintReceipt(
      const Value: TOnAfterRegistratorEventExtended);
    procedure SetOnBeforePrintReceipt(
      const Value: TOnBeforeRegistratorEventExtended);
    procedure SetOnFinishPrintReceipt(
      const Value: TOnFinishRegistratorEventExtended);
    procedure SetOnStartPrintReceipt(
      const Value: TOnStartRegistratorEventExtended);
    procedure SetOnFinishProgrammingVisitItems(
      const Value: TOnFinishRegistratorEvent);
    procedure SetOnStartProgrammingVisitItems(
      const Value: TOnStartRegistratorEvent);
    procedure SetOnAfterDeleteArticleByItemNo(
      const Value: TOnAfterRegistratorEventItem);
    procedure SetOnBeforeDeleteAllArticle(
      const Value: TOnBeforeRegistratorEvent);
    procedure SetOnBeforeDeleteArticleByItemNo(
      const Value: TOnBeforeRegistratorEventItem);
    procedure SetOnAfterSaleArticles(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeSaleArticles(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterSaleItem(const Value: TOnAfterRegistratorEventItem);
    procedure SetOnBeforeSaleItem(const Value: TOnBeforeRegistratorEventItem);
    procedure SetOnAfterProgrammingVisitItems(
      const Value: TOnAfterRegistratorEventItem);
    procedure SetOnBeforeProgrammingVisitItems(
      const Value: TOnBeforeRegistratorEventItem);
    procedure SetOnAfterDeleteAllArticle(const Value: TOnAfterRegistratorEvent);
    procedure SetOnAfterReceiptReset(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeReceiptReset(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterSetHeadeFooters(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeSetHeadeFooters(
      const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterGetLastReceiptNo(
      const Value: TOnAfterRegistratorEventExtended);
    procedure SetOnBeforeGetLastReceiptNo(
      const Value: TOnBeforeRegistratorEventExtended);
    procedure SetOnAfterFiscalReceiptOpen(
      const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeFiscalReceiptOpen(
      const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterFiscalReceiptClose(
      const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeFiscalReceiptClose(
      const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterFiscalReceiptSubTotal(
      const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeFiscalReceiptSubTotal(
      const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterFiscalReceiptTotal(
      const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeFiscalReceiptTotal(
      const Value: TOnBeforeRegistratorEvent);
    procedure SetOnBeforeConnect(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterConnect(const Value: TOnAfterRegistratorEvent);
    procedure SetOnAfterDisConnect(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeDisConnect(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterClose(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnBeforeClose(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterClrScr(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeClrScr(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterReport_X(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeReport_X(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterReport_Z(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeReport_Z(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterGetRegistratorSums(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeGetRegistratorSums(
      const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterServiceInOut(const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforeServiceInOut(const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterPrintNonfiscalTextOnVisit(
      const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforePrintNonfiscalTextOnVisit(
      const Value: TOnBeforeRegistratorEvent);
    procedure SetOnAfterPrintFiscalTextOnVisit(
      const Value: TOnAfterRegistratorEvent);
    procedure SetOnBeforePrintFiscalTextOnVisit(
      const Value: TOnBeforeRegistratorEvent);
    procedure SetCurrentOperatorName(const Value: String);
    procedure SetNumOfCharInReceiptLine(const Value: Integer);
    procedure SetLogOptions(const Value: TDatecsFP3530LogOptions);
    procedure SetDisplayOptions(const Value: TDatecsFP3530DisplayOptions);
    procedure SetReturnOptions(const Value: TDatecsFP3530ReturnOptions);
    procedure SetExceptionGenerateOptions(
      const Value: TExceptionGenerateOptions);
    procedure SetReceiptStateText(const Value: String);
    procedure SetPayByReceipt(const Value: Double);
    procedure SetStoredByReceipt(const Value: Double);
    procedure SetisAddedStateMessagesInMesasge(const Value: Boolean);
    procedure SetCallstackDeep(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    FRetData: TRetData;
    {HWND hwnd – в вызове функции вместо этого параметра ставится NULL или 0
     (данный параметр используется только для совместимости с предыдущими
     версиями библиотеки).}
    FHWND: hwnd;
     {LPARAM UI - в вызове функции вместо этого параметра ставится 0L (данный
     параметр используется только для совместимости с предыдущими версиями
     библиотеки).}
    FPar: LPARAM;
      {состояние битов фискального регистратора.}
    RegistratorStates: TRegistratorStates;
      {общие стостояния фискльного регистратора.}
    CommonStates: TCommonStates;
      {Текстовые описания состояний регистратора в момент снятия данных с
      регистратора.}
    StateMessages: TStringList;
      {список ошибок которые произошли во время работы регистратора.}
    ErrorList: TStringList;
    {Список запрограммированных артикулов в Базе.}
    ProgrammedItems: TList;
    {Список запрограммированных артикулов в памяти регистратора.}
    ProgrammedItemsInMemory: TList;
      {количесвто ошибок, которые будут храниться.}
    ErrorListCount: Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
      {Установка строк заголовка чека.}
    function SetHeadeFooters: Boolean;
      {Аннулировать чек.}
    function ReceiptReset: Boolean;
      {Запрограммировать артикулы в регистратор.}
    function ProgrammingVisitItems: Boolean;
      {Продать / Вернуть все артикулы счета.}
    function SaleArticles(ASign: Boolean): Boolean;
      {Продать / Вернуть артикул номер AIndex.}
    function SaleItem(AItem: TItem; AIndex: Integer; ASign: Boolean): Boolean;
      {Распчать чек продажи / возвата счета.}
    function PrintReceipt(ASign: Boolean): Integer;
      {Получить номер последенго чека, в том счет X , Z - отчетов.}
    function GetLastReceiptNo: Integer;
      {Открыть фискальный чек продажи / возврата.}
    function FiscalReceiptOpen(ASign: Boolean): Boolean;
      {Закрыть фискальный чек продажи / возврата.}
    function FiscalReceiptClose(ASign: Boolean): Boolean;
      {Подитог фискального чека продажи / возврата.}
    function FiscalReceiptSubTotal: Boolean;
      {Итог фискального чека продажи / возврата.}
    function FiscalReceiptTotal: Boolean;
      {Подключение к регистратору вне зависимости от KeepOpened.}
    function Connect: Boolean;
      {Отключение от регистратора вне зависимости от KeepOpened.}
    function DisConnect: Boolean;
      {Удалить запрограммированный артикул номер AItemNo.}
    function DeleteArticleByItemNo(AItemNo: integer): Boolean;
      {Удалить все артикулы.}
    function DeleteAllArticle: Boolean;
      {Функцтя для проверки запрограммирован или нет, товар в фискальном
      регистраторе.}
    function isItemProgrammed(AIndex: Integer): Integer;
      {Подключить фискальный регистратор.}
    function Open: Boolean;
      {Отключить фискальный регистратор.}
    function Close: Boolean;
      {Очистить дисплей.}
    procedure ClrScr;
      {X -  отчет.}
    function Report_X: Boolean;
      {Z -  отчет.}
    function Report_Z: Boolean;
      {Считываем сумм работы фискального регистратора.}
    function GetRegistratorSums(): Boolean;
      { Amount > 0 -  служебное внесение, иначе - вынесение.}
    function ServiceInOut(Amount: double): Boolean;
      {Напечатать на чеке не фискальный текст.}
    function PrintNonfiscalTextOnVisit(AString: String): Boolean;
      {Напечатать на чеке фискальный текст.}
    function PrintFiscalTextOnVisit(AString: String): Boolean;
      {Функция для задания имени текущего оператора}
    function ProgrammedCurrentOperatorName: boolean;
      {Функция для задания имени оператора по его номеру оператора}
    function ProgrammedOperatorNameByNamber(AOperatorNamuber: integer;
      AOperatorName, AOperatorPassword: String): boolean;
      {Функция, которая устанавливает дату время фискального регистратора}
    function SetRegistratorDateTime(ADateTime: TDateTime): Boolean;
      {Печать нулевого чека.}
    function PrintEmptyReceipt: Boolean;
      {Открываем не фискальный чек.}
    function NonfiscalReceiptOpen: Boolean;
      {Закрываем не фискальный чек.}
    function NonfiscalReceiptClose: Boolean;
      {Функция для определения состояния регистратора}
    function GetRegistratorStatus: Boolean;
      {Функция для определения состояния чека в регистраторе}
    function GetReceiptStatus: Boolean;
      {Функция считывает информацию о зпрограммированных артикулах.}
    function GetProgrammedItemsInMemory: Boolean;
      {Получить дату / время с регистратора}
    function GetRegistratorDateTime(var ADateTime: TDateTime): Boolean;
      {Сравнивает два артикула, если Екуг - ни совпадают, False  - не совпадают}
    function CompareArticles(const AFirstArticle,
      ASecondArticle: TArticle): Boolean;
      {ПЕчатается полный периодический отчет по дате}
    function FullPeriodicalReportByDate(ADateBeg, ADateEnd: TDateTime): Boolean;
      {Во время работы фискального регистратора произошла ошибка, которая
      привела регистратор в некорректное состояние.}
    property FatalError: Boolean read FFatalError write SetFatalError;
      {Наличность в кассе.}
    property CashSum: Double read FCashSum write SetCashSum;
      {Всего служебных вынесений.}
    property ServiceIn: Double read FServiceIn write SetServiceIn;
      {Всего служебных внесений.}
    property ServiceOut: Double read FServiceOut write SetServiceOut;
      {Номер последнего чека}
    property ReceiptNo: Integer read FReceiptNo write SetReceiptNo;
      {Сочедржимое чека}
    property Visit: TVisit read FVisit write SetVisit;
      {Тестовое описание состояния чека}
    property ReceiptStateText: String read FReceiptStateText write
      SetReceiptStateText;
      {Накоплено по чеку после вызова GetReceiptStatus}
    property StoredByReceipt: Double read FStoredByReceipt write  SetStoredByReceipt;
      {Оплачено по чеку после вызова GetReceiptStatus}
    property PayByReceipt: Double read FPayByReceipt write SetPayByReceipt;
      {0 - регистратор не подключен, 1 - регистратор подключен}
    property Connected: Boolean read FConnected;
      {0 - не добавлять сообщения состояния Регистратора в
        сообщения об ошибке и в лог файл, 1 - одбавлять,
        данное свойство устанавливается при установке в
        1 - свойства FatalError и сбрасывается в 0 при при
        выполнении процедуры LogException}
    property isAddedStateMessagesInMesasge: Boolean
      read FisAddedStateMessagesInMesasge
      write SetisAddedStateMessagesInMesasge;
    property CallStackDeep: Integer read FCallStackDeep write SetCallStackDeep;
    property ErrorMessage: String read FErrorMessage;
    function ProgrammedArticlesFromProgrammedItems: Boolean;
  published
    { Published declarations }
      {Длина строки в чеке вискального регистратора.}
    property NumOfCharInReceiptLine: Integer read FNumOfCharInReceiptLine
      write SetNumOfCharInReceiptLine;
      {Имя текущего оператора.}
    property CurrentOperatorName: String read FCurrentOperatorName write
      SetCurrentOperatorName;
      {Номер текущего оператора.}
    property CurrentOperatorNumber: Cardinal read FCurrentOperatorNumber
      write SetCurrentOperatorNumber;
      {Пароль текущего оператора}
    property CurrentOperatorPassword: String read FCurrentOperatorPassword
      write SetCurrentOperatorPassword;
      {Номер текущей кассы.}
    property CurrentCashDeskNumber: Cardinal read FCurrentCashDeskNumber
      write SetCurrentCashDeskNumber;
      {Строки заголовка чеков.}
    property HeaderLines: TStrings read FHeaderLines write SetHeaderLines;
      {Пароль для подключения к фискальному регистратору.}
    property PassWord: String read FPassWord write SetPassWord;
      {COM -  порт на котором работает фикальный регистратор.}
    property SerialPortNumber: Integer read FSerialPortNumber write SetSerialPortNumber;
      {Скорость обмена данными с COM -  порт.}
    property BaudRate: Integer read FBaudRate write SetBaudRate;
      {Держать подключение к фискальному регистратору открытым.}
    property KeepOpened: Boolean read FKeepOpened Write SetKeepOpened;
      {Деактивировать фискальный регистратор (режим работы программы без
      фискального регистратора).}
    property Enabled: Boolean read FEnabled write SetEnabled;
      {Логировать работу фискального регистратора в лог файл.}
    property WriteToLog: Boolean read FWriteToLog write SetWriteToLog;
      {Компонет для логирования.}
    property LogFile: TtLogFile read FLogFile write SetLogFile;
      {Настройки логирования работы фискального регистратора.}
    property LogOptions: TDatecsFP3530LogOptions read FLogOptions
      write SetLogOptions;
      {Параметры отображения на дисплее результатов выполнения функция на
      регистраторе.}
    property DisplayOption: TDatecsFP3530DisplayOptions read FDisplayOptions
      write SetDisplayOptions;
      {Параметры для управления возвращаемыми данными в RetData/}
    property ReturnOption: TDatecsFP3530ReturnOptions read FReturnOptions
      write SetReturnOptions;
      {Длина строки названия, товара, которая печатается на чеке.}
    property ItemNameLineLength: Integer read FItemNameLineLength write SetItemNameLineLength;
      {Настройки генерации исключительный ситуаций Delphi }
    property ExceptionGenerateOptions: TExceptionGenerateOptions
      read FExceptionGenerateOptions write SetExceptionGenerateOptions;
      {вызывается перед подключением фискального регистратора}
    property OnBeforeOpen: TOnBeforeRegistratorEvent read FOnBeforeOpen write SetOnBeforeOpen;
      {вызывается после подключения фискального регистратора}
    property OnAfterOpen: TOnAfterRegistratorEvent read FOnAfterOpen write SetOnAfterOpen;

    property OnStartPrintReceipt: TOnStartRegistratorEventExtended
      read FOnStartPrintReceipt write SetOnStartPrintReceipt;
    property OnFinishPrintReceipt: TOnFinishRegistratorEventExtended
      read FOnFinishPrintReceipt write SetOnFinishPrintReceipt;
      {вызывается перед печатью чека продажи / возвата счета.}
    property OnBeforePrintReceipt: TOnBeforeRegistratorEventExtended
      read FOnBeforePrintReceipt write SetOnBeforePrintReceipt;
      {вызывается после печати чека продажи / возвата счета.}
    property OnAfterPrintReceipt: TOnAfterRegistratorEventExtended
      read FOnAfterPrintReceipt write SetOnAfterPrintReceipt;

    property OnStartProgrammingVisitItems: TOnStartRegistratorEvent
      read FOnStartProgrammingVisitItems write SetOnStartProgrammingVisitItems;
    property OnFinishProgrammingVisitItems: TOnFinishRegistratorEvent
      read FOnFinishProgrammingVisitItems write SetOnFinishProgrammingVisitItems;
      {вызывается перед программированием артикулов в регистратор.}
    property OnBeforeProgrammingVisitItems: TOnBeforeRegistratorEventItem
      read FOnBeforeProgrammingVisitItems write SetOnBeforeProgrammingVisitItems;
      {вызывается после программирования артикулов в регистратор.}
    property OnAfterProgrammingVisitItems: TOnAfterRegistratorEventItem
      read FOnAfterProgrammingVisitItems write SetOnAfterProgrammingVisitItems;

      {вызывается перед удалением всех артикулов.}
    property OnBeforeDeleteAllArticle: TOnBeforeRegistratorEvent
      read FOnBeforeDeleteAllArticle write SetOnBeforeDeleteAllArticle;
      {вызывается после удаления всех артикулы.}
    property OnAfterDeleteAllArticle: TOnAfterRegistratorEvent
      read FOnAfterDeleteAllArticle write SetOnAfterDeleteAllArticle;

      {вызывается перед удалением запрограммированного артикула номер AItemNo.}
    property OnBeforeDeleteArticleByItemNo: TOnBeforeRegistratorEventItem
      read FOnBeforeDeleteArticleByItemNo write SetOnBeforeDeleteArticleByItemNo;
      {вызывается после удаления запрограммированного артикула номер AItemNo.}
    property OnAfterDeleteArticleByItemNo: TOnAfterRegistratorEventItem
      read FOnAfterDeleteArticleByItemNo write SetOnAfterDeleteArticleByItemNo;

      {вызывается перед продажей / возвратом всех артикулов счета.}
    property OnBeforeSaleArticles: TOnBeforeRegistratorEvent
      read FOnBeforeSaleArticles write SetOnBeforeSaleArticles;
      {вызывается после продажи / возврата всех артикулов счета.}
    property OnAfterSaleArticles: TOnAfterRegistratorEvent
      read FOnAfterSaleArticles write SetOnAfterSaleArticles;

      {вызывается перед продажей / везвратом артикула номер AIndex.}
    property OnBeforeSaleItem: TOnBeforeRegistratorEventItem
      read FOnBeforeSaleItem write SetOnBeforeSaleItem;
      {вызывается после продажи / везврата артикула номер AIndex.}
    property OnAfterSaleItem: TOnAfterRegistratorEventItem
      read FOnAfterSaleItem write SetOnAfterSaleItem;

      {вызывается пере аннулированием чека.}
    property OnBeforeReceiptReset: TOnBeforeRegistratorEvent
      read FOnBeforeReceiptReset write SetOnBeforeReceiptReset;
      {вызывается после.}
    property OnAfterReceiptReset: TOnAfterRegistratorEvent
      read FOnAfterReceiptReset write SetOnAfterReceiptReset;

    {вызывается перед устанавкой строк заголовка чека.}
    property OnBeforeSetHeadeFooters: TOnBeforeRegistratorEvent
      read FOnBeforeSetHeadeFooters write SetOnBeforeSetHeadeFooters;
      {вызывается после устанавки строк заголовка чека.}
    property OnAfterSetHeadeFooters: TOnAfterRegistratorEvent
      read FOnAfterSetHeadeFooters write SetOnAfterSetHeadeFooters;

      {вызывается перед получением номер последенго чека, в том счет X , Z -
      отчетов.}
    property OnBeforeGetLastReceiptNo: TOnBeforeRegistratorEventExtended
      read FOnBeforeGetLastReceiptNo write SetOnBeforeGetLastReceiptNo;
      {вызывается после получения номера последенго чека, в том счет X , Z -
      отчетов.}
    property OnAfterGetLastReceiptNo: TOnAfterRegistratorEventExtended
      read FOnAfterGetLastReceiptNo write SetOnAfterGetLastReceiptNo;

      {вызывается перед открытием фискального чека продажи / возврата.}
    property OnBeforeFiscalReceiptOpen: TOnBeforeRegistratorEvent
      read FOnBeforeFiscalReceiptOpen write SetOnBeforeFiscalReceiptOpen;
      {вызывается после открытия фискального чека продажи / возврата.}

    property OnAfterFiscalReceiptOpen: TOnAfterRegistratorEvent
      read FOnAfterFiscalReceiptOpen write SetOnAfterFiscalReceiptOpen;
      {вызывается перед закрытием фискального чека продажи / возврата.}
    property OnBeforeFiscalReceiptClose: TOnBeforeRegistratorEvent
      read FOnBeforeFiscalReceiptClose write SetOnBeforeFiscalReceiptClose;
      {вызывается после закрытия фискального чека продажи / возврата.}
    property OnAfterFiscalReceiptClose: TOnAfterRegistratorEvent
      read FOnAfterFiscalReceiptClose write SetOnAfterFiscalReceiptClose;

      {вызывается перед подитогом фискального чека продажи / возврата.}
    property OnBeforeFiscalReceiptSubTotal: TOnBeforeRegistratorEvent
      read FOnBeforeFiscalReceiptSubTotal write SetOnBeforeFiscalReceiptSubTotal;
      {вызывается после подитога фискального чека продажи / возврата.}
    property OnAfterFiscalReceiptSubTotal: TOnAfterRegistratorEvent
      read FOnAfterFiscalReceiptSubTotal write SetOnAfterFiscalReceiptSubTotal;

      {вызывается перед итогом фискального чека продажи / возврата.}
    property OnBeforeFiscalReceiptTotal: TOnBeforeRegistratorEvent
      read FOnBeforeFiscalReceiptTotal write SetOnBeforeFiscalReceiptTotal;
      {вызывается после итога фискального чека продажи / возврата.}
    property OnAfterFiscalReceiptTotal: TOnAfterRegistratorEvent
      read FOnAfterFiscalReceiptTotal write SetOnAfterFiscalReceiptTotal;

      {вызывается перед подключением к регистратору вне зависимости от
      KeepOpened.}
    property OnBeforeConnect: TOnBeforeRegistratorEvent read FOnBeforeConnect
      write SetOnBeforeConnect;
      {вызывается после подключения к регистратору вне зависимости от KeepOpened.}
    property OnAfterConnect: TOnAfterRegistratorEvent read FOnAfterConnect
      write SetOnAfterConnect;

      {вызывается перед отключением от регистратора вне зависимости от
      KeepOpened.}
    property OnBeforeDisConnect: TOnBeforeRegistratorEvent
      read FOnBeforeDisConnect write SetOnBeforeDisConnect;
      {вызывается после отключения от регистратора вне зависимости от KeepOpened.}
    property OnAfterDisConnect:TOnAfterRegistratorEvent read FOnAfterDisConnect
      write SetOnAfterDisConnect;

      {вызывается перед отключением регистратора.}
    property OnBeforeClose: TOnBeforeRegistratorEvent read FOnBeforeClose
      write SetOnBeforeClose;
      {вызывается после отключения регистратора.}
    property OnAfterClose: TOnBeforeRegistratorEvent read FOnAfterClose
      write SetOnAfterClose;

      {вызывается перед очисткой дисплея.}
    property OnBeforeClrScr: TOnBeforeRegistratorEvent read FOnBeforeClrScr
      write SetOnBeforeClrScr;
      {вызывается после очистки дисплея.}
    property OnAfterClrScr: TOnAfterRegistratorEvent read FOnAfterClrScr
      write SetOnAfterClrScr;

      {вызывается перед X -  отчетом.}
    property OnBeforeReport_X: TOnBeforeRegistratorEvent read FOnBeforeReport_X
      write SetOnBeforeReport_X;
      {вызывается после X -  отчета.}
    property OnAfterReport_X: TOnAfterRegistratorEvent read FOnAfterReport_X
      write SetOnAfterReport_X;

      {вызывается перед Z -  отчетом.}
    property OnBeforeReport_Z: TOnBeforeRegistratorEvent read FOnBeforeReport_Z
      write SetOnBeforeReport_Z;
      {вызывается после Z -  отчета.}
    property OnAfterReport_Z: TOnAfterRegistratorEvent read FOnAfterReport_Z
      write SetOnAfterReport_Z;

      {вызывается перед считыванием сумм работы фискального регистратора.}
    property OnBeforeGetRegistratorSums: TOnBeforeRegistratorEvent
      read FOnBeforeGetRegistratorSums write SetOnBeforeGetRegistratorSums;
      {вызывается после считывания сумм работы фискального регистратора.}
    property OnAfterGetRegistratorSums: TOnAfterRegistratorEvent
      read FOnAfterGetRegistratorSums write SetOnAfterGetRegistratorSums;

      {вызывается перед служебным внесением / вынесением.}
    property OnBeforeServiceInOut: TOnBeforeRegistratorEvent
      read FOnBeforeServiceInOut write SetOnBeforeServiceInOut;
      {вызывается после служебного внесениея / вынесения.}
    property OnAfterServiceInOut: TOnAfterRegistratorEvent
      read FOnAfterServiceInOut write SetOnAfterServiceInOut;

      {вызывается перед печататью на чеке не фискального текста.}
    property OnBeforePrintNonfiscalTextOnVisit: TOnBeforeRegistratorEvent
      read FOnBeforePrintNonfiscalTextOnVisit
      write SetOnBeforePrintNonfiscalTextOnVisit;
      {вызывается после печатати на чеке не фискального текста.}
    property OnAfterPrintNonfiscalTextOnVisit: TOnAfterRegistratorEvent
      read FOnAfterPrintNonfiscalTextOnVisit
      write SetOnAfterPrintNonfiscalTextOnVisit;

      {вызывается перед печататью на чеке фискального текста.}
    property OnBeforePrintFiscalTextOnVisit: TOnBeforeRegistratorEvent
      read FOnBeforePrintFiscalTextOnVisit
      write SetOnBeforePrintFiscalTextOnVisit;
      {вызывается после печатати на чеке фискального текста.}
    property OnAfterPrintFiscalTextOnVisit: TOnAfterRegistratorEvent
      read FOnAfterPrintFiscalTextOnVisit write SetOnAfterPrintFiscalTextOnVisit;
  end;
  const
  cAlertEnabledModeON = 'Включен режим без фискального регистртора. ';
  var
    tDatecsFP3530: TtDatecsFP3530;
    //FRetData: TRetData;

procedure PrinterResults(const rt:TRetData); stdcall;
procedure Register;

function InitFPport(int1,int2:integer):integer; stdcall; external 'fpl.dll' name 'InitFPport';
function CloseFPport():integer; stdcall; external 'fpl.dll' name 'CloseFPport';
{int CALLBACK  GetStatus(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,BOOL NoWait)
Входные данные – NoWait (false – проводится внутренняя диагностика регистратора).
Выходные данные – байты состояния регистратора (данные байты возвращаются при
  любой команде обращающейся к фискальному регистратору)
<S0><S1><S2><S3><S4><S5> - байты состояния фискального регистратора}
function GetStatus(hWin: HWND; fun: TPrinterResults; par: LPARAM; int1: BOOL): integer;stdcall;
  external 'fpl.dll' name 'GetStatus';
function ClearDisplay(hWin: HWND; fun: TPrinterResults; par: LPARAM): integer; stdcall;
  external 'fpl.dll' name 'ClearDisplay';
{int CALLBACK  DisplayTextLL(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,LPSTR Text)
Входные данные –
Text – текст для вывода на дисплей
Выходные данные – нет
Текст – Текст длиной до 20 символов выводится  в нижний ряд дисплея}
function DisplayTextLL(hWin: HWND; fun: TPrinterResults; par: LPARAM; Text: LPSTR):
  integer; stdcall; external 'fpl.dll' name 'DisplayTextLL';
{int CALLBACK  DisplayTextUL(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,LPSTR Str)
Входные данные - Текст   Text – текст для вывода на дисплей
Выходные данные – нет
Текст – Текст длиной до 20 символов выводится  в нижний ряд дисплея}
function DisplayTextUL(hWin: HWND; fun: TPrinterResults; par: LPARAM; Text: LPSTR):
  integer; stdcall; external 'fpl.dll' name 'DisplayTextUL';
function FiscalClosure(HWND: hwnd; fun: TPrinterResults; par: LPARAM; psw: LPSTR;
  TypeReport: char): integer; stdcall; external 'fpl.dll' name 'FiscalClosure';
function ServiceInputOutput(HWND: hwnd; fun: TPrinterResults; par: LPARAM;
  Amount : double): integer; stdcall; external 'fpl.dll' name 'ServiceInputOutput';
function GetLastReceipt(HWND: hwnd; fun: TPrinterResults; par: LPARAM): integer;
  stdcall; external 'fpl.dll' name 'GetLastReceipt';
{int CALLBACK  PrintFiscalText(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,LPSTR Text)
Входные данные –
Text – Текст для печати в чеке до 24 символов
Выходные данные – Нет}
function PrintNonfiscalText(hWin: HWND; fun: TPrinterResults; par: LPARAM;
  Text: LPSTR): integer; stdcall; external 'fpl.dll' name 'PrintNonfiscalText';
{int CALLBACK  PrintNonfiscalText(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,LPSTR Text)
Входные данные –
Text - строка текста длиной до 35 символов.  Выходные данные – нет
Функция предназначена для печати нефискального текста.}
function PrintFiscalText(hWin: HWND; fun: TPrinterResults; par: LPARAM;
  ext: LPSTR): integer; stdcall; external 'fpl.dll' name 'PrintFiscalText';
{int CALLBACK  SetHeaderFooter(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,int Line,LPSTR Text)
Входные данные - <значение><текст> Выходные данные - нет Заголовок чека состоит
  из 6 рядов, рекламная информация – из 2  Line - от 0 до 7 (номер строки) 0-5
  для строк заголовка чека 6-7 для строк рекламной информации в конце чека
Text - - это соответствующий текст для строки заголовка или рекламного текста
 чека (до 40  символов текста)
Line – C (латинское C)
Text - 1 или 0, разрешая или запрещая автоматическое отрезание чека.
 (После выключения и затем включения регистратора восстанавливается режим,
 установленный с помощью микропереключателей).
Line –L
Text - 0 или 1, разрешая или запрещая печать логотипа.
 (После выключения и затем включения регистратора восстанавливается режим,
  установленный с помощью микропереключателей).
Line –J
Text - 1 или 0, разрешая или запрещая уменьшенный шрифт для контрольной ленты.
  (После выключения и затем включения регистратора восстанавливается режим,
   установленный с помощью микропереключателей).
Line –I (латинское I)
Text - цифра от 0 до 7, то в результате выполнения команды возвращается текст
  запрошенной строки заголовка или рекламного текста.
  Предназначена для установки заголовка и рекламного текста чека, а также для
  определения опций принтера.}
function SetHeaderFooter(HWND: hwnd; fun: TPrinterResults; par: LPARAM;
  Line: integer; Text: LPSTR): integer; stdcall;
  external 'fpl.dll' name 'SetHeaderFooter';

function ProgrammingArticle(hWin: HWND; fun: TPrinterResults; par: LPARAM; nal: char;
  gr: integer; cod: integer; Sena: double; pass: LPSTR; name: LPSTR): integer;
  stdcall; external 'fpl.dll' name 'ProgrammingArticle';

function ResetReceipt(hWin : HWND; fun : TPrinterResults; par : LParam) : integer; stdcall;
  external 'fpl.dll' name 'ResetReceipt';

function GetCommonArticleInfo(HWND: hwnd; fun: TPrinterResults; par: LPARAM): integer;
  stdcall; external 'fpl.dll' name 'GetCommonArticleInfo';

function SaleArticleAndDisplay(hWin: HWND; fun: TPrinterResults; par: LPARAM;
  sign: bool; numart: integer; qty, perc, dc: double): integer; stdcall;
  external 'fpl.dll' name 'SaleArticleAndDisplay';
function SaleArticle(hWin: HWND; fun: TPrinterResults; par: LPARAM;
  sign: bool; numart: integer; qty, perc, dc: double): integer; stdcall;
  external 'fpl.dll' name 'SaleArticle';
function OpenRepaymentReceipt(hWin: HWND; fun: TPrinterResults; par: LPARAM;
  Operator: DWORD; Pass: LPSTR; TillNumber: DWORD; TaxCheck: BOOL) : integer;
  stdcall; external 'fpl.dll' name 'OpenRepaymentReceipt';
function SubTotal(hWin: HWND; fun: TPrinterResults; par: LPARAM; Print, Display: BOOL;
  Percent, disc: double): integer; stdcall; external 'fpl.dll' name 'SubTotal';
function Total(hWin: HWND; fun: TPrinterResults; par: LPARAM; Comment: LPSTR;
  PaidCode: char; Amount: double): integer; stdcall; external 'fpl.dll' name 'Total';
function CloseFiscalReceipt(hWin: HWND; fun: TPrinterResults; par: LPARAM): integer;
  stdcall; external 'fpl.dll' name 'CloseFiscalReceipt';
function OpenFiscalReceipt(hWin: HWND; fun: TPrinterResults; par: LPARAM;
  Operator: DWORD; Pass: LPSTR; TillNumber: DWORD; TaxCheck: BOOL) : integer;
  stdcall; external 'fpl.dll' name 'OpenFiscalReceipt';
function GetFiscalClosureStatus(hWin : HWND; fun : TPrinterResults; par : LParam;
  Current: Boolean) : integer; stdcall;
  external 'fpl.dll' name 'GetFiscalClosureStatus';
function DeleteArticle(hWin: HWND; fun: TPrinterResults; par: LPARAM;
  cod: integer; pass: LPSTR): integer; stdcall; external 'fpl.dll' name 'DeleteArticle';

function CloseNonfiscalReceipt(hWin: HWND; fun: TPrinterResults;
  par: LPARAM): integer; stdcall; external 'fpl.dll' name 'CloseNonfiscalReceipt';

function SetOperatorName(HWND: hwnd; fun: TPrinterResults; par: LPARAM;
  OperNum: integer; Pass, Name: LPSTR): integer; stdcall; external 'fpl.dll'
  name 'SetOperatorName';
function OpenNonfiscalReceipt(hWin: HWND; fun: TPrinterResults;
  par: LPARAM): integer; stdcall; external 'fpl.dll' name 'OpenNonfiscalReceipt';
function SetDateTime(hWin: HWND; fun: TPrinterResults; par: LPARAM; Date,
  Time: LPSTR): integer; stdcall; external 'fpl.dll' name 'SetDateTime';

function GetArticleInfo(HWND: hwnd; fun: TPrinterResults; par: LPARAM; numart: Integer)
  : integer; stdcall; external 'fpl.dll' name 'GetArticleInfo';

function GetDateTime(HWND: hwnd; fun: TPrinterResults; par: LPARAM): integer; stdcall;
  external 'fpl.dll' name 'GetDateTime';

function PrintFiscalMemoryByDate(HWND: HWND; fun: TPrinterResults; par: LPARAM;
  psw: LPSTR; AStart: LPSTR; AEnd: LPSTR): integer; stdcall;
  external 'fpl.dll' name 'PrintFiscalMemoryByDate';
implementation

procedure Register;
begin
  RegisterComponents('CarsComponets', [TtDatecsFP3530]);
end;

procedure PrinterResults(const rt:TRetData); stdcall;
begin
  tDatecsFP3530.FRetData:= rt;
  tDatecsFP3530.AnalyseState;
end;


{ TtDatecsFP3530 }

constructor TtDatecsFP3530.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  LogFile:= TtLogFile.Create(Self);
  FHWND:= 0;
  FPar:= 0;
  StateMessages:= TStringList.Create;
  ErrorList:= TStringList.Create;
  HeaderLines:= TStringList.Create;
  ProgrammedItems:= TList.Create;
  ProgrammedItemsInMemory:= TList.Create;
  FVisit:= TVisit.Create;
  tDatecsFP3530:= Self;
  ReturnOption:= [roIsReturnInfoSAboutPayLastReceipt];
end;

destructor TtDatecsFP3530.Destroy;
var
  i: Integer;
  lArticle: TArticle;
begin
  StateMessages.Free;
  ErrorList.Free;
  HeaderLines.Free;
  for i:= 0 to ProgrammedItems.Count - 1 do
  begin
    lArticle:= ProgrammedItems[i];
    Dispose(lArticle.FData);
    lArticle.Free;
  end;
  ProgrammedItems.Free;
  for I := 0 to ProgrammedItemsInMemory.Count - 1 do
  begin
    lArticle:= ProgrammedItemsInMemory[i];
    lArticle.Free;
  end;
  ProgrammedItemsInMemory.Free;
  FVisit.Clear;
  FVisit.Free;
  inherited;
end;

function TtDatecsFP3530.Open: Boolean;
const
  cConnectToSerialPort = 'Подключаемся к регистратору. ';
  cAlertSkipConnection = 'Подключение к регистратору пропущено. ';
  cErrorWhileConnection = 'Ошибка при подключении к регистратору. ';
var
  i: Integer;
  lRaiseError: Boolean;
begin
  lRaiseError:= (egoOpen in ExceptionGenerateOptions);
  try
    CallStackDeep:= CallStackDeep+1;
    try
      Result:= True;
      if KeepOpened then begin
        LogFile.Add(llTRACE, cAlertSkipConnection+cKeeepOpenedON);
        Exit;
      end;
      LogFile.Add(llINFO, cConnectToSerialPort);
      if not Enabled then begin
        LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipConnection);
        Exit;
      end;
      if (loAddToLogConnectParams in LogOptions)  then begin
        LogFile.Add(llTRACE, cSerialport+IntToStr(SerialPortNumber));
        LogFile.Add(llTRACE, cBaudRate+IntToStr(SerialPortNumber));
      end;

      if Assigned(FOnBeforeOpen) then
        FOnBeforeOpen(Self, FatalError, FRetData);

      i:= InitFPport(SerialPortNumber, BaudRate);

      if Assigned(FOnAfterOpen) then
        FOnAfterOpen(Self, FatalError, FRetData);
      if (i < 0) or FatalError then begin
        FatalError:= False;
        Result:= False;
        LogException(llERROR, cErrorWhileConnection, nil, lRaiseError);
      end;
      FConnected:= Result;
    Except on e: Exception do
      begin
        Result:= False;
        FConnected:= Result;
        LogException(llERROR, cErrorWhileConnection, e, lRaiseError);
      end;
    end;
  finally
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.Connect: Boolean;
const
  cConnectToSerialPortKeepOpened = 'Подключаемся к регистратору вне зависимости от KeepOpened. ';
  cAlertSkipConnectionKeepOpened = 'Подключение к регистратору вне зависимости от KeepOpened пропущено. ';
  cErrorWhileConnectionKeepOpened = 'Ошибка при подключении  вне зависимости от KeepOpened к регистратору. ';
var
  i: Integer;
  lRaiseError: Boolean;
begin
  lRaiseError:= (egoConnect in ExceptionGenerateOptions);
  try
    CallStackDeep:= CallStackDeep+1;
    try
      Result:= True;
      LogFile.Add(llINFO, cConnectToSerialPortKeepOpened);
      if not Enabled then begin
        LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipConnectionKeepOpened);
        Exit;
      end;
      if (loAddToLogConnectParams in LogOptions)  then begin
        LogFile.Add(llTRACE, cSerialport+IntToStr(SerialPortNumber));
        LogFile.Add(llTRACE, cBaudRate+IntToStr(SerialPortNumber));
      end;
      if Assigned(FOnBeforeConnect) then
        FOnBeforeConnect(Self, FatalError, FRetData);
      i:= InitFPport(SerialPortNumber, BaudRate);
      if Assigned(FOnAfterConnect) then
        FOnAfterConnect(Self, FatalError, FRetData);
      if (i < 0) or FatalError then begin
        FatalError:= False;
        Result:= False;
        LogException(llERROR, cErrorWhileConnectionKeepOpened, nil, lRaiseError);
      end;
      FConnected:= Result;
    except on e: Exception do
      begin
        Result:= False;
        FConnected:= Result;
        LogException(llERROR, cErrorWhileConnectionKeepOpened, e, lRaiseError);
      end;
    end;
  finally
    CallStackDeep:= CallStackDeep-1;
  end;
end;


function TtDatecsFP3530.isItemProgrammed(AIndex: Integer): Integer;
var
  i: Integer;
  lVisitItem: TItem;
  lProgrammedItem: TArticle;
begin
  { -1 - Артикул не найден, > 0 артикул запрограммированн под номером, равным
   возвращаемому значению}
  Result:= -1;
  lVisitItem:= FVisit.FVisitItems[AIndex];
  for i:= 0 to ProgrammedItems.Count - 1 do
  begin     
    lProgrammedItem:= ProgrammedItems.Items[I];
    if CompareItems(lVisitItem, lProgrammedItem) = 0 then begin
      Result:= lProgrammedItem.FCode;
      Exit;
    end;
  end;
end;

procedure TtDatecsFP3530.LogException(AlogLevel: TLogLevel; AMsg: string;
  AE: Exception; AGenerateException: Boolean);
var
  lMsg: string;
  I: Integer;
const
  cInfoRegistratorMessages = 'Состояния регистратора:'+#10#13;
  cInfoSysErrorMessage = 'SysErrorMessage:';
begin
  if AE <> nil then
    lMsg:= lMsg+#10#13+AMsg+#10#13+AE.ClassName+' : '+AE.Message+#10#13
  else
    lMsg:= lMsg+#10#13+AMsg+#13#13+cInfoSysErrorMessage+
      SysErrorMessage(GetLastError)+#10#13;
  LogFile.Add(AlogLevel, lMsg);
//  StateMessages.Delimiter:=#13;
  if not isAddedStateMessagesInMesasge then begin
    if  StateMessages.Count <> 0 then lMsg:= lMsg+cInfoRegistratorMessages;
    for I := 0 to StateMessages.Count - 1 do
      lMsg:= lMsg+StateMessages.Strings[i];
    LogFile.AddStrings(llERROR, StateMessages);
    FErrorMessage:= FErrorMessage+lMsg;
    isAddedStateMessagesInMesasge:= True;
  end;

  if AGenerateException then raise Exception.Create(lMsg);
end;

function TtDatecsFP3530.NonfiscalReceiptClose: Boolean;
const
  cAlertSkipNonfiscalReceiptClose = 'Закрытие не фискального чека пропущено.';
  cPrintNonfiscalReceiptClose = 'Закрытие не фискального чека.';
  cErrorWhileNonfiscalReceiptClose = 'Ошибка при закрытие не фискального чека.';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= (egoNonfiscalReceiptClose in ExceptionGenerateOptions);
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipNonfiscalReceiptClose);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try                      
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        lKeepOpened:= True;
        LogFile.Add(llINFO, cPrintNonfiscalReceiptClose);
        {int CALLBACK  CloseNonfiscalReceipt(HWND hwnd,void (CALLBACK *Fn),LPARAM UI)
         Входные данные – нет Выходные данные – Счетчик чеков Возвращается в
           структуре RetData - LPSTR RetItem[0];
         Счетчик чеков – Счетчик всех чеков (фискальных и нефискальных) от
           последней фискализации регистратора (4 байта)
         Функция предназначена для закрытия нефискального чека.}
        GetRegistratorStatus;
        i:= CloseNonfiscalReceipt(FHWND, PrinterResults, FPar);
        if (i < 0) or FatalError then begin
          Result:= False;
          LogException(llERROR, cErrorWhileNonfiscalReceiptClose, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileNonfiscalReceiptClose, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.NonfiscalReceiptOpen: Boolean;
const
  cAlertSkipNonfiscalReceiptOpen = 'Открытие не фискального чека пропущено.';
  cPrintNonfiscalReceiptOpen = 'Открытие не фискального чека.';
  cErrorWhileNonfiscalReceiptOpen = 'Ошибка при открытие не фискального чека.';
  //----------------------------------------------------------------------------
  clErrorFRMemoryNotFormated = 'Фискальная память неформатирована.';
  clErrorFRFiscalReceiptOpen = 'Открыт фискальный чек.';
  clErrorFRNonFiscalReceiptOpen = 'Нефискальный чек уже открыт.';
var
  i: Integer;
  lErrorStr: String;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoNonfiscalReceiptOpen in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipNonfiscalReceiptOpen);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try                      
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        lKeepOpened:= True;
        LogFile.Add(llINFO, cPrintNonfiscalReceiptOpen);
        {int CALLBACK  OpenNonfiscalReceipt(HWND hwnd,void (CALLBACK *Fn),LPARAM UI)
         Входные данные – нет
         Выходные данные – Код ошибки
         Возвращается в структуре RetData - LPSTR RetItem[0], LPSTR RetItem[1];
         Счетчик чеков – Счетчик всех чеков (фискальных и нефискальных) от
           последней фискализации регистратора (4 байта)
         Код ошибки – Код ошибки при неуспешном выполнении команды:
           1 - фискальная память неформатирована
           2 -  открыт фискальный чек
           3 – нефискальный чек уже открыт
         Функция открывает нефискальный чек.}
        GetRegistratorStatus;
        i:= OpenNonfiscalReceipt(FHWND, PrinterResults, FPar);
        case i of
          1:begin
            i:= -1;
            lErrorStr:= clErrorFRMemoryNotFormated;
          end;
          2:begin
            i:= -1;
            lErrorStr:= clErrorFRFiscalReceiptOpen;
          end;
          3:begin
            i:= -1;
            lErrorStr:= clErrorFRNonFiscalReceiptOpen;
          end;
        end;

        if (i < 0) or FatalError then begin
          Result:= False;
          LogException(llERROR, cErrorWhileNonfiscalReceiptOpen+lErrorStr, nil,
            lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileNonfiscalReceiptOpen+lErrorStr, e,
          lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.PrintEmptyReceipt: Boolean;
const
  cErrorWhilePtintEmptyReceipt = 'Ошибка при печти нулевого чека.';
  cPrintEmptyReceipt = 'Печать нулевого чека';
  cEmptyReceipt = 'НУЛЕВОЙ ЧЕК';
var
  lKeepOpened: Boolean;
  lRaiseError: Boolean;
begin
  lKeepOpened:= KeepOpened;
  Result:= False;
  try
    CallStackDeep:= CallStackDeep+1;
    lRaiseError:= (egoPrintEmptyReceipt in ExceptionGenerateOptions);
    try
      if Open then begin
        KeepOpened:= True;
        DisplayTextUL(FHWND, PrinterResults, FPar, cEmptyReceipt);

        Result:= NonfiscalReceiptOpen;
        if not Result then begin
          LogException(llERROR, cErrorWhilePtintEmptyReceipt, nil, false);
          Exit;
        end;

        Result:= PrintNonfiscalTextOnVisit('');
        if not Result then begin
          LogException(llERROR, cErrorWhilePtintEmptyReceipt, nil, false);
          Exit;
        end;

        Result:= PrintNonfiscalTextOnVisit(cEmptyReceipt);
        if not Result then begin
          LogException(llERROR, cErrorWhilePtintEmptyReceipt, nil, false);
          Exit;
        end;

        PrintNonfiscalTextOnVisit('');
        if not Result then begin
          LogException(llERROR, cErrorWhilePtintEmptyReceipt, nil, false);
          Exit;
        end;

        Result:= NonfiscalReceiptClose;
        if not Result then begin
          LogException(llERROR, cErrorWhilePtintEmptyReceipt, nil, false);
          Exit;
        end;
        ClrScr;
      end;
    except on e: Exception do
      begin
        LogException(llERROR, cErrorWhilePtintEmptyReceipt, e, lRaiseError);
        Result:= False;
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.PrintFiscalTextOnVisit(AString: String): Boolean;
const
  cAlertSkipPrintFiscalText = 'Печать фискального текста пропущена пропущена.';
  cPrintPrintFiscalText = 'Печать фискального текста.';
  cErrorWhileFiscalText = 'Ошибка при печати фискального текста.';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoPrintFiscalTextOnVisit in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipPrintFiscalText);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try                      
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintPrintFiscalText+AString);
        if Assigned(FOnBeforePrintFiscalTextOnVisit) then
          FOnBeforePrintFiscalTextOnVisit(Self, FatalError, FRetData);
        GetRegistratorStatus;
        i:= PrintFiscalText(FHWND, PrinterResults, FPar, PChar(AString));
        if (i < 0) or FatalError then begin
          FatalError:= False;
          Result:= False;
          LogException(llERROR, cErrorWhileFiscalText, nil, lRaiseError);
        end;
        if Assigned(FOnAfterPrintFiscalTextOnVisit) then
          FOnAfterPrintFiscalTextOnVisit(Self, FatalError, FRetData);
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileFiscalText, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.PrintNonfiscalTextOnVisit(AString: String): Boolean;
const
  cAlertSkipPrintNonFiscalText = 'Печать не фискального текста пропущена пропущена.';
  cPrintPrintNonFiscalText = 'Печать не фискального текста.';
  cErrorWhileNonFiscalText = 'Ошибка при печати не фискального текста.';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= (egoPrintNonfiscalTextOnVisit in ExceptionGenerateOptions);
  if not Enabled then begin
    LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipPrintNonFiscalText);
    Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True; 
        LogFile.Add(llINFO, cPrintPrintNonFiscalText+AString);
        if Assigned(FOnBeforePrintNonfiscalTextOnVisit) then
          FOnBeforePrintNonfiscalTextOnVisit(Self, FatalError, FRetData);
        GetRegistratorStatus;
        i:= PrintNonFiscalText(FHWND, PrinterResults, FPar, PChar(AString));
        if Assigned(FOnAfterPrintNonfiscalTextOnVisit) then
          FOnAfterPrintNonfiscalTextOnVisit(Self, FatalError, FRetData);
        if (i < 0) or FatalError then begin
          FatalError:= False;
          Result:= False;
          LogException(llERROR, cErrorWhileNonFiscalText, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileNonFiscalText, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;  
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.Report_X: Boolean;
const
  cAlertSkipXReport = 'Печать Х - отчета пропущена.';
  cPrintXReport = 'Печать Х - отчета.';
  cErrorWhileXReport = 'Ошибка при печати Х - отчета.';
var
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= (egoReport_X in ExceptionGenerateOptions);
  if not Enabled then begin
    LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipXReport);
    Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True; 
        LogFile.Add(llINFO, cPrintXReport);
        if (doDisplayWhileReportX in DisplayOption)  then
          DisplayTextUL(FHWND, PrinterResults, FPar, cPrintXReport);
        GetRegistratorStatus;
{        if FatalError then begin
          lRaiseError:= False;
          FatalError:= False;
          raise Exception.Create(cFatalErrorOccuredOnPreviousStep);
        end;}        
        {int CALLBACK  FiscalClosure(HWND hwnd,void (CALLBACK *Fn),LPARAM UI, LPSTR psw, char Option)
        Входные данные –
        psw - пароль для отчета (оператор 15).
        TypeReport -
        0 - Сделать фискальный отчет с обнулением (Z-отчет)
        2 – Сделать дневной отчет без обнуления (X-отчет)
        Выходные данные - Возвращаются в структуре RetData - LPSTR RetItem[0], RetItem[1],
        RetItem[2], RetItem[3], RetItem[4], RetItem[5];
        Номер, СуммаА, СуммаБ, СуммаВ, СуммаГ, СуммаД
        Номер – номер дневного отчета
        СуммаА - Сумма всех продаж по налоговой группе А – 12 байт со знаком
        СуммаБ - Сумма всех продаж по налоговой группе Б – 12 байт со знаком
        СуммаВ - Сумма всех продаж по налоговая группе В – 12 байт со знаком
        СуммаГ - Сумма всех продаж по налоговой группе Г – 12 байт со знаком
        СуммаД - Сумма всех продаж по налоговой группе Д – 12 байт со знаком
        Функция выполняет X- или Z- отчет в зависимости от значения параметра TypeReport}
        if Assigned(FOnBeforeReport_X) then
          FOnBeforeReport_X(Self, FatalError, FRetData);
        FiscalClosure(FHWND, PrinterResults, FPar, PChar(PassWord), RT_XReport);
        if Assigned(FOnAfterReport_X) then
          FOnAfterReport_X(Self, FatalError, FRetData);
        if FatalError then begin
          LogException(llERROR, cErrorWhileXReport, nil, lRaiseError);
          FatalError:= False;
          Result:= False;
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileXReport, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.Report_Z: Boolean;
const
  cAlertSkipZReport = 'Печать Х - отчета пропущена.';
  cPrintZReport = 'Печать Х - отчета.';
  cErrorWhileZReport = 'Ошибка при печати Х - отчета.';
var
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= (egoReport_Z in ExceptionGenerateOptions);
  if not Enabled then begin
    LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipZReport);
    Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintZReport);
        DisplayTextUL(FHWND, PrinterResults, FPar, cPrintZReport);
        GetRegistratorStatus;;
{        if FatalError then begin
          lRaiseError:= False;
          FatalError:= False;
          raise Exception.Create(cFatalErrorOccuredOnPreviousStep);
        end;}
        {int CALLBACK  FiscalClosure(HWND hwnd,void (CALLBACK *Fn),LPARAM UI, LPSTR psw, char Option)
        Входные данные –
        psw - пароль для отчета (оператор 15).
        TypeReport -
        0 - Сделать фискальный отчет с обнулением (Z-отчет)
        2 – Сделать дневной отчет без обнуления (X-отчет)
        Выходные данные - Возвращаются в структуре RetData - LPSTR RetItem[0], RetItem[1],
        RetItem[2], RetItem[3], RetItem[4], RetItem[5];
        Номер, СуммаА, СуммаБ, СуммаВ, СуммаГ, СуммаД
        Номер – номер дневного отчета
        СуммаА - Сумма всех продаж по налоговой группе А – 12 байт со знаком
        СуммаБ - Сумма всех продаж по налоговой группе Б – 12 байт со знаком
        СуммаВ - Сумма всех продаж по налоговая группе В – 12 байт со знаком
        СуммаГ - Сумма всех продаж по налоговой группе Г – 12 байт со знаком
        СуммаД - Сумма всех продаж по налоговой группе Д – 12 байт со знаком
        Функция выполняет X- или Z- отчет в зависимости от значения параметра TypeReport}
        if Assigned(FOnBeforeReport_Z) then
          FOnBeforeReport_Z(Self, FatalError, FRetData);
        FiscalClosure(FHWND, PrinterResults, FPar, PChar(PassWord), RT_ZReport);
        if Assigned(FOnAfterReport_Z) then
          FOnAfterReport_Z(Self, FatalError, FRetData);
        if FatalError then begin
          LogFile.Add(llERROR, cErrorWhileZReport);
          Result:= False;
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileZReport, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

procedure TtDatecsFP3530.AddToLogRetData;
const
  cErrorWhileAddRetDataInToLog = 'Ошибка при записи данных из RetData в лог:';
  cSkipAddToLogRetData = 'Пропускаем запись в лог RetData';
  cAddToLogRetDataInAllActionsFalse = 'Опция AddToLogRetDataInAllActions = false';
var
  lRetData: TStringList;
  i: Integer;
  lRaiseError: Boolean;
begin
  lRaiseError:= (egoAddToLogRetData in ExceptionGenerateOptions);
  if (loAddToLogRetDataInAllActions in LogOptions)
     and (loAddToLogRetDataInGetStatus in LogOptions) then begin
    lRetData:= TStringList.Create; 
    try
      try
        lRetData.Add('RetData:');
        lRetData.Add('Count = '+IntToStr(FRetData.Count));
        lRetData.Add('CmdCode = '+IntToStr(FRetData.CmdCode));
        lRetData.Add('UserData = '+IntToStr(FRetData.UserData));
        lRetData.Add('Status = '+IntToStr(FRetData.Status));
        lRetData.Add('CmdName = '+FRetData.CmdName);
        lRetData.Add('SendStr = '+FRetData.SendStr);
        lRetData.Add('Whole = '+FRetData.Whole);

        for I := Low(FRetData.RetItem) to High(FRetData.RetItem) do
          lRetData.Add('RetItem['+IntToStr(i)+'] = '+FRetData.RetItem[i]);

        for I := Low(FRetData.OrigStat) to High(FRetData.OrigStat) do
          lRetData.Add('OrigStat['+IntToStr(i)+'] = '+intToStr(FRetData.OrigStat[i]));
        LogFile.AddStrings(llTRACE, lRetData);
      except on e: Exception do
        begin
          LogException(llERROR, cErrorWhileAddRetDataInToLog, E, lRaiseError);
        end;
      end;
    finally
      lRetData.Free;
    end;
  end
  else begin
    LogFile.Add(llINFO, cAddToLogRetDataInAllActionsFalse);
    LogFile.Add(llINFO, cSkipAddToLogRetData);
  end;

end;

procedure TtDatecsFP3530.AnalyseState;
begin
  // Анализ состояний Фискального регистратора
  AddToLogRetData;
  StateMessages.Clear;
  with RegistratorStates.AdditioanStates do
  begin
    {1}SYNTAX_ERROR:= (FRetData.Status and cBit_0) = cBit_0;
    {2}INVALID_CMD:= (FRetData.Status and cBit_1) = cBit_1;
    {3}INVALID_TIME:= (FRetData.Status and cBit_2) = cBit_2;
    {4}PRINT_ERROR:= (FRetData.Status and cBit_3) = cBit_3;
    {5}SUM_OVERFLOW:= (FRetData.Status and cBit_4) = cBit_4;
    {6}CMD_NOT_ALLOWED:= (FRetData.Status and cBit_5) = cBit_5;
    {7}RAM_CLEARED:= (FRetData.Status and cBit_6) = cBit_6;
    {8}PRINT_RESTART:= (FRetData.Status and cBit_7) = cBit_7;
    {9}RAM_DESTROYED:= (FRetData.Status and cBit_8) = cBit_8;
    {10}PAPER_OUT:= (FRetData.Status and cBit_9) = cBit_9;
    // не работает :( commonstates.ExistsOpenReceipt работает
    {11}FISCAL_OPEN:= (FRetData.Status and cBit_10) = cBit_10;
    {12}NONFISCAL_OPEN:= (FRetData.Status and cBit_11) = cBit_11;
    {13--}SERVICE_OPEN:= (FRetData.Status and cBit_12) = cBit_12;
    {14}F_ABSENT:= (FRetData.Status and cBit_13) = cBit_13;
    //{13}F_ABSENT:= (FRetData.Status and cBit_12) = cBit_12;
    {15--}F_MODULE_NUM:= (FRetData.Status and cBit_14) = cBit_14;
    {16}F_WRITE_ERROR:= (FRetData.Status and cBit_15) = cBit_15;
    //{14}F_WRITE_ERROR:= (FRetData.Status and cBit_13) = cBit_13;
    {17}F_FULL:= (FRetData.Status and cBit_16) = cBit_16;
    //{15}F_FULL:= (FRetData.Status and cBit_14) = cBit_14;
    {18}F_READ_ONLY:= (FRetData.Status and cBit_17) = cBit_17;
    //{16}F_READ_ONLY:= (FRetData.Status and cBit_15) = cBit_15;
    {19}F_CLOSE_ERROR:= (FRetData.Status and cBit_18) = cBit_18;
    //{17}F_CLOSE_ERROR:= (FRetData.Status and cBit_16) = cBit_16;
    {20}F_LESS_30:= (FRetData.Status and cBit_19) = cBit_19;
    //{18}F_LESS_30:= (FRetData.Status and cBit_17) = cBit_17;
    {21--}F_FORMATTED:= (FRetData.Status and cBit_20) = cBit_20;
    {22--}F_FISCALIZED:= (FRetData.Status and cBit_21) = cBit_21;
    {23--}F_SER_NUM:= (FRetData.Status and cBit_22) = cBit_22;
    {24}PROTOCOL_ERROR:= (FRetData.Status and cBit_23) = cBit_23;
    //{19}PROTOCOL_ERROR:= (FRetData.Status and cBit_18) = cBit_18;
    {25}NACK_RECEIVED:= (FRetData.Status and cBit_24) = cBit_24;
    //{20}NACK_RECEIVED:= (FRetData.Status and cBit_19) = cBit_19;
    {26}TIMEOUT_ERROR:= (FRetData.Status and cBit_25) = cBit_25;
    //{21}TIMEOUT_ERROR:= (FRetData.Status and cBit_20) = cBit_20;
    {27}COMMON_ERROR:= (FRetData.Status and cBit_26) = cBit_26;
    //{22}COMMON_ERROR:= (FRetData.Status and cBit_21) = cBit_21;
    {28--}F_COMMON_ERROR:= (FRetData.Status and cBit_27) = cBit_27;
    {29--}ADD_PAPER:= (FRetData.Status and cBit_28) = cBit_28;
    {30--}ANY_ERROR:= (FRetData.Status and cBit_29) = cBit_29;
  end;

  with RegistratorStates.BitStates_0 do
  begin
    Bit_0:= (FRetData.OrigStat[1] and cBit_0) = cBit_0;
    Bit_1:= (FRetData.OrigStat[1] and cBit_1) = cBit_1;
    Bit_2:= (FRetData.OrigStat[1] and cBit_2) = cBit_2;
    Bit_3:= (FRetData.OrigStat[1] and cBit_3) = cBit_3;
    Bit_4:= (FRetData.OrigStat[1] and cBit_4) = cBit_4;
    Bit_5:= (FRetData.OrigStat[1] and cBit_5) = cBit_5;
    Bit_6:= (FRetData.OrigStat[1] and cBit_6) = cBit_6;
    Bit_7:= (FRetData.OrigStat[1] and cBit_7) = cBit_7;
  end;

  with RegistratorStates.BitStates_1 do
  begin
    Bit_0:= (FRetData.OrigStat[2] and cBit_0) = cBit_0;
    Bit_1:= (FRetData.OrigStat[2] and cBit_1) = cBit_1;
    Bit_2:= (FRetData.OrigStat[2] and cBit_2) = cBit_2;
    Bit_3:= (FRetData.OrigStat[2] and cBit_3) = cBit_3;
    Bit_4:= (FRetData.OrigStat[2] and cBit_4) = cBit_4;
    Bit_5:= (FRetData.OrigStat[2] and cBit_5) = cBit_5;
    Bit_6:= (FRetData.OrigStat[2] and cBit_6) = cBit_6;
    Bit_7:= (FRetData.OrigStat[2] and cBit_7) = cBit_7;
  end;

  with RegistratorStates.BitStates_2 do
  begin
    Bit_0:= (FRetData.OrigStat[3] and cBit_0) = cBit_0;
    Bit_1:= (FRetData.OrigStat[3] and cBit_1) = cBit_1;
    Bit_2:= (FRetData.OrigStat[3] and cBit_2) = cBit_2;
    Bit_3:= (FRetData.OrigStat[3] and cBit_3) = cBit_3;
    Bit_4:= (FRetData.OrigStat[3] and cBit_4) = cBit_4;
    Bit_5:= (FRetData.OrigStat[3] and cBit_5) = cBit_5;
    Bit_6:= (FRetData.OrigStat[3] and cBit_6) = cBit_6;
    Bit_7:= (FRetData.OrigStat[3] and cBit_7) = cBit_7;
  end;

  with RegistratorStates.BitStates_3 do
  begin
    Bit_0:= (FRetData.OrigStat[4] and cBit_0) = cBit_0;
    Bit_1:= (FRetData.OrigStat[4] and cBit_1) = cBit_1;
    Bit_2:= (FRetData.OrigStat[4] and cBit_2) = cBit_2;
    Bit_3:= (FRetData.OrigStat[4] and cBit_3) = cBit_3;
    Bit_4:= (FRetData.OrigStat[4] and cBit_4) = cBit_4;
    Bit_5:= (FRetData.OrigStat[4] and cBit_5) = cBit_5;
    Bit_6:= (FRetData.OrigStat[4] and cBit_6) = cBit_6;
    Bit_7:= (FRetData.OrigStat[4] and cBit_7) = cBit_7;
  end;

  with RegistratorStates.BitStates_4 do
  begin
    Bit_0:= (FRetData.OrigStat[5] and cBit_0) = cBit_0;
    Bit_1:= (FRetData.OrigStat[5] and cBit_1) = cBit_1;
    Bit_2:= (FRetData.OrigStat[5] and cBit_2) = cBit_2;
    Bit_3:= (FRetData.OrigStat[5] and cBit_3) = cBit_3;
    Bit_4:= (FRetData.OrigStat[5] and cBit_4) = cBit_4;
    Bit_5:= (FRetData.OrigStat[5] and cBit_5) = cBit_5;
    Bit_6:= (FRetData.OrigStat[5] and cBit_6) = cBit_6;
    Bit_7:= (FRetData.OrigStat[5] and cBit_7) = cBit_7;
  end;

  with RegistratorStates.BitStates_5 do
  begin
    Bit_0:= (FRetData.OrigStat[6] and cBit_0) = cBit_0;
    Bit_1:= (FRetData.OrigStat[6] and cBit_1) = cBit_1;
    Bit_2:= (FRetData.OrigStat[6] and cBit_2) = cBit_2;
    Bit_3:= (FRetData.OrigStat[6] and cBit_3) = cBit_3;
    Bit_4:= (FRetData.OrigStat[6] and cBit_4) = cBit_4;
    Bit_5:= (FRetData.OrigStat[6] and cBit_5) = cBit_5;
    Bit_6:= (FRetData.OrigStat[6] and cBit_6) = cBit_6;
    Bit_7:= (FRetData.OrigStat[6] and cBit_7) = cBit_7;
  end;

  with RegistratorStates.AdditioanStates do
  begin
    {1}if SYNTAX_ERROR then StateMessages.Add(cSYNTAX_ERROR_Msg);
    {2}if INVALID_CMD then StateMessages.Add(cINVALID_CMD_Msg);
    {3}if INVALID_TIME then StateMessages.Add(cINVALID_TIME_Msg);
    {4}if PRINT_ERROR then StateMessages.Add(cPRINT_ERROR_Msg);
    {5}if SUM_OVERFLOW then StateMessages.Add(cSUM_OVERFLOW_Msg);
    {6}if CMD_NOT_ALLOWED then StateMessages.Add(cCMD_NOT_ALLOWED_Msg);
    {7}if RAM_CLEARED then StateMessages.Add(cRAM_CLEARED_Msg);
    {8}if PRINT_RESTART then StateMessages.Add(cPRINT_RESTART_Msg);
    {9}if RAM_DESTROYED then StateMessages.Add(cRAM_DESTROYED_Msg);
    {10}if PAPER_OUT then StateMessages.Add(cPAPER_OUT_Msg);
    {11}if FISCAL_OPEN then StateMessages.Add(cFISCAL_OPEN_Msg);
    {12}if NONFISCAL_OPEN then StateMessages.Add(cNONFISCAL_OPEN_Msg);
    {13--}if SERVICE_OPEN then StateMessages.Add(cSERVICE_OPEN_Msg);
    {14}if F_ABSENT then StateMessages.Add(cF_ABSENT_Msg);
    {15--}if F_MODULE_NUM then StateMessages.Add(cF_MODULE_NUM_Msg);
    {16}if F_WRITE_ERROR then StateMessages.Add(cF_WRITE_ERROR_Msg);
    {17}if F_FULL then StateMessages.Add(cF_FULL_Bit_Msg);
    {18}if F_READ_ONLY then StateMessages.Add(cF_READ_ONLY_Msg);
    {19}if F_CLOSE_ERROR then StateMessages.Add(cF_CLOSE_ERROR_Msg);
    {20}if F_LESS_30 then StateMessages.Add(cF_LESS_30_Msg);
    {21--}if F_FORMATTED then StateMessages.Add(cF_FORMATTED_Msg);
    {22--}if F_FISCALIZED then StateMessages.Add(cF_FISCALIZED_Msg);
    {23--}if F_SER_NUM then StateMessages.Add(cF_SER_NUM_Msg);
    {24}if PROTOCOL_ERROR then StateMessages.Add(cPROTOCOL_ERROR_Msg);
    {25}if NACK_RECEIVED then StateMessages.Add(cNACK_RECEIVED_Msg);
    {26}if TIMEOUT_ERROR then StateMessages.Add(cTIMEOUT_ERROR_Msg);
    {27}if COMMON_ERROR then StateMessages.Add(cCOMMON_ERROR_Msg);
    {28--}if F_COMMON_ERROR then StateMessages.Add(cF_COMMON_ERROR_Msg);
    {29--}if ADD_PAPER then StateMessages.Add(cADD_PAPER_Msg);
    {30--}if ANY_ERROR then StateMessages.Add(cANY_ERROR_Msg);
  end;

  with RegistratorStates.BitStates_0 do
  begin
    if Bit_0 then StateMessages.Add(cMsg_S0_0_0);
    if Bit_1 then StateMessages.Add(cMsg_S0_0_1);
    if Bit_2 then StateMessages.Add(cMsg_S0_0_2);
    if Bit_3 then StateMessages.Add(cMsg_S0_0_3);
    if Bit_4 then StateMessages.Add(cMsg_S0_0_4);
    if Bit_5 then StateMessages.Add(cMsg_S0_0_5);
    if Bit_6 then StateMessages.Add(cMsg_S0_0_6);
    if Bit_7 then StateMessages.Add(cMsg_S0_0_7);
  end;

  with RegistratorStates.BitStates_1 do
  begin
    if Bit_0 then StateMessages.Add(cMsg_S1_1_0);
    if Bit_1 then StateMessages.Add(cMsg_S1_1_1);
    if Bit_2 then StateMessages.Add(cMsg_S1_1_2);
    if Bit_3 then StateMessages.Add(cMsg_S1_1_3);
    if Bit_4 then StateMessages.Add(cMsg_S1_1_4);
    if Bit_5 then StateMessages.Add(cMsg_S1_1_5);
    if Bit_6 then StateMessages.Add(cMsg_S1_1_6);
    if Bit_7 then StateMessages.Add(cMsg_S1_1_7);
  end;

  with RegistratorStates.BitStates_2 do
  begin
    if Bit_0 then StateMessages.Add(cMsg_S2_2_0);
    if Bit_1 then StateMessages.Add(cMsg_S2_2_1);
    if Bit_2 then StateMessages.Add(cMsg_S2_2_2);
    if Bit_3 then StateMessages.Add(cMsg_S2_2_3);
    if Bit_4 then StateMessages.Add(cMsg_S2_2_4);
    if Bit_5 then StateMessages.Add(cMsg_S2_2_5);
    if Bit_6 then StateMessages.Add(cMsg_S2_2_6);
    if Bit_7 then StateMessages.Add(cMsg_S2_2_7);
  end;

  with RegistratorStates.BitStates_3 do
  begin
    if Bit_0 then StateMessages.Add(cMsg_S3_3_0);
    if Bit_1 then StateMessages.Add(cMsg_S3_3_1);
    if Bit_2 then StateMessages.Add(cMsg_S3_3_2);
    if Bit_3 then StateMessages.Add(cMsg_S3_3_3);
    if Bit_4 then StateMessages.Add(cMsg_S3_3_4);
    if Bit_5 then StateMessages.Add(cMsg_S3_3_5);
    if Bit_6 then StateMessages.Add(cMsg_S3_3_6);
    if Bit_7 then StateMessages.Add(cMsg_S3_3_7);
  end;

  with RegistratorStates.BitStates_4 do
  begin
    if Bit_0 then StateMessages.Add(cMsg_S4_4_0);
    if Bit_1 then StateMessages.Add(cMsg_S4_4_1);
    if Bit_2 then StateMessages.Add(cMsg_S4_4_2);
    if Bit_3 then StateMessages.Add(cMsg_S4_4_3);
    if Bit_4 then StateMessages.Add(cMsg_S4_4_4);
    if Bit_5 then StateMessages.Add(cMsg_S4_4_5);
    if Bit_6 then StateMessages.Add(cMsg_S4_4_6);
    if Bit_7 then StateMessages.Add(cMsg_S4_4_7);
  end;

  with RegistratorStates.BitStates_5 do
  begin
    if Bit_0 then StateMessages.Add(cMsg_S5_5_0);
    if Bit_1 then StateMessages.Add(cMsg_S5_5_1);
    if Bit_2 then StateMessages.Add(cMsg_S5_5_2);
    if Bit_3 then StateMessages.Add(cMsg_S5_5_3);
    if Bit_4 then StateMessages.Add(cMsg_S5_5_4);
    if Bit_5 then StateMessages.Add(cMsg_S5_5_5);
    if Bit_6 then StateMessages.Add(cMsg_S5_5_6);
    if Bit_7 then StateMessages.Add(cMsg_S5_5_7);
  end;
  with RegistratorStates, RegistratorStates.AdditioanStates, CommonStates do
  begin
    FatalError:= (BitStates_0.Bit_1 = True)
      or (BitStates_0.Bit_5 = True)
      or (BitStates_1.Bit_0 = True)
      or (BitStates_4.Bit_2 = True)
      or (BitStates_4.Bit_5 = True)
      or (ANY_ERROR = True)
      or (COMMON_ERROR = True)
      or (TIMEOUT_ERROR = True);
    ExistsOpenReceipt:= BitStates_2.Bit_3;
  end;
  //FatalError:= CommonStates.FatalError;

end;

procedure TtDatecsFP3530.ClrScr;
begin
  if Assigned(FOnBeforeClrScr) then
    FOnBeforeClrScr(Self, FatalError, FRetData);
  ClearDisplay(FHWND, PrinterResults, FPar);
  if Assigned(FOnAfterClrScr) then
    FOnAfterClrScr(Self, FatalError, FRetData);
end;

function TtDatecsFP3530.Close: Boolean;
const
  cAlertDisConnectToSerialPort = 'Отключаемся от регистратора. ';
  cAlertSkipDisConnection = 'Отключение пропущено. ';
  cErrorWhileDisConnection = 'Ошибка при отключении от регистратора. ';
var
  i: Integer;
  lRaiseError: Boolean;
begin
  lRaiseError:= (egoClose in ExceptionGenerateOptions);
  try
    CallStackDeep:= CallStackDeep+1;
    try
      Result:= True;
      if KeepOpened then begin
        LogFile.Add(llTRACE, cAlertSkipDisConnection+cKeeepOpenedON);
        Exit;
      end;
      LogFile.Add(llINFO, cAlertDisConnectToSerialPort);
      if not Enabled then begin
        LogFile.Add(llINFO, cAlertSkipDisConnection+cAlertEnabledModeON);
        Exit;
      end;
      if (loAddToLogConnectParams in LogOptions) then begin
        LogFile.Add(llTRACE, cSerialPort+IntToStr(SerialPortNumber));
        LogFile.Add(llTRACE, cBaudRate+IntToStr(SerialPortNumber));
      end;
      if Assigned(FOnBeforeClose) then
        FOnBeforeClose(Self, FatalError, FRetData);
      i:= CloseFPport();
      if Assigned(FOnAfterClose) then
        FOnAfterClose(Self, FatalError, FRetData);
      if (i < 0) or FatalError then begin
        //GetStatus(FHWND, PrinterResults, FPar, False);
        FatalError:= False;
        Result:= False;
        LogException(llERROR, cErrorWhileDisConnection, nil, lRaiseError);
      end;
      FConnected:= Result;
    Except on e: Exception do
      begin
        Result:= False;
        FConnected:= Result;
        LogException(llERROR, cErrorWhileDisConnection, e, lRaiseError);
      end;
    end;
  finally
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.DisConnect: Boolean;
const
  cAlertDisConnectToSerialPortKeepOpened = 'Отключаемся от регистратора в не зависимости от флага KeepOpened. ';
  cAlertSkipDisConnectionKeepOpened = 'Отключение от регистратора в не зависимости от флага KeepOpened пропущено. ';
  cErrorWhileDisConnectionKeepOpened = 'Ошибка при отключении от регистратора  в не зависимости от флага KeepOpened.';
var
  i: Integer;
  lRaiseError: Boolean;
begin
  lRaiseError:= (egoDisConnect in ExceptionGenerateOptions);
  try
    CallStackDeep:= CallStackDeep+1;
    try
      Result:= True;
      if KeepOpened then begin
        LogFile.Add(llTRACE, cAlertSkipDisConnectionKeepOpened+cKeeepOpenedON);
        Exit;
      end;
      LogFile.Add(llINFO, cAlertDisConnectToSerialPortKeepOpened);
      if not Enabled then begin
        LogFile.Add(llINFO, cAlertSkipDisConnectionKeepOpened+cAlertEnabledModeON);
        Exit;
      end;
      if (loAddToLogConnectParams in LogOptions) then begin
        LogFile.Add(llTRACE, cSerialPort+IntToStr(SerialPortNumber));
        LogFile.Add(llTRACE, cBaudRate+IntToStr(SerialPortNumber));
      end;
      if Assigned(FOnBeforeDisConnect) then
        FOnBeforeDisConnect(Self, FatalError, FRetData);
      i:= CloseFPport();
      if Assigned(FOnAfterDisConnect) then
        FOnAfterDisConnect(Self, FatalError, FRetData);
      if (i < 0) or FatalError then begin
        //GetStatus(FHWND, PrinterResults, FPar, False);
        FatalError:= False;
        Result:= False;
        LogException(llERROR, cErrorWhileDisConnectionKeepOpened, nil, lRaiseError);
      end;
      FConnected:= Result;
    Except on e: Exception do
      begin
        Result:= False;
        FConnected:= Result;
        LogException(llERROR, cErrorWhileDisConnectionKeepOpened, e, lRaiseError);
      end;
    end;
  finally
    CallStackDeep:= CallStackDeep-1;
  end;
end;

procedure TtDatecsFP3530.SetBaudRate(const Value: Integer);
begin
  FBaudRate := Value;
end;

procedure TtDatecsFP3530.SetCallStackDeep(const Value: Integer);
begin
  if FCallstackDeep <> Value then begin
    FCallstackDeep:= Value;
    //FLogFile.DateTimeAndTextSeparatorLength:= FCallstackDeep;
    if FCallstackDeep = 0 then begin
      isAddedStateMessagesInMesasge:= False;
      FErrorMessage:= '';
    end;
  end;
end;

procedure TtDatecsFP3530.SetCashSum(const Value: Double);
begin
  FCashSum := Value;
end;

procedure TtDatecsFP3530.SetCurrentCashDeskNumber(const Value: Cardinal);
begin
  FCurrentCashDeskNumber := Value;
end;

procedure TtDatecsFP3530.SetCurrentOperatorName(const Value: String);
begin
  FCurrentOperatorName := Value;
end;

procedure TtDatecsFP3530.SetCurrentOperatorNumber(const Value: Cardinal);
begin
  FCurrentOperatorNumber := Value;
end;

procedure TtDatecsFP3530.SetCurrentOperatorPassword(const Value: String);
begin
  FCurrentOperatorPassword := Value;
end;

procedure TtDatecsFP3530.SetDisplayOptions(
  const Value: TDatecsFP3530DisplayOptions);
begin
  FDisplayOptions := Value;
end;

procedure TtDatecsFP3530.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TtDatecsFP3530.SetExceptionGenerateOptions(
  const Value: TExceptionGenerateOptions);
begin
  FExceptionGenerateOptions := Value;
end;

procedure TtDatecsFP3530.SetFatalError(const Value: Boolean);
begin
  if FatalError <> Value then begin
    FFatalError := Value;
  end;
end;

procedure TtDatecsFP3530.SetHeaderLines(const Value: TStrings);
begin
  FHeaderLines := Value;
end;

procedure TtDatecsFP3530.SetisAddedStateMessagesInMesasge(const Value: Boolean);
begin
  FisAddedStateMessagesInMesasge := Value;
end;

procedure TtDatecsFP3530.SetItemNameLineLength(const Value: Integer);
begin
  FItemNameLineLength := Value;
end;

procedure TtDatecsFP3530.SetKeepOpened(const Value: Boolean);
begin
  FKeepOpened := Value;
end;

procedure TtDatecsFP3530.SetLogFile(const Value: TtLogFile);
begin
  FLogFile := Value;
end;


procedure TtDatecsFP3530.SetLogOptions(const Value: TDatecsFP3530LogOptions);
begin
  FLogOptions := Value;
end;

procedure TtDatecsFP3530.SetNumOfCharInReceiptLine(const Value: Integer);
begin
  FNumOfCharInReceiptLine := Value;
end;

procedure TtDatecsFP3530.SetOnAfterClose(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnAfterClose := Value;
end;

procedure TtDatecsFP3530.SetOnAfterClrScr(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterClrScr := Value;
end;

procedure TtDatecsFP3530.SetOnAfterConnect(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterConnect := Value;
end;

procedure TtDatecsFP3530.SetOnAfterDeleteAllArticle(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterDeleteAllArticle := Value;
end;

procedure TtDatecsFP3530.SetOnAfterDeleteArticleByItemNo(
  const Value: TOnAfterRegistratorEventItem);
begin
  FOnAfterDeleteArticleByItemNo := Value;
end;

procedure TtDatecsFP3530.SetOnAfterDisConnect(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterDisConnect := Value;
end;

procedure TtDatecsFP3530.SetOnAfterFiscalReceiptClose(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterFiscalReceiptClose := Value;
end;

procedure TtDatecsFP3530.SetOnAfterFiscalReceiptOpen(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterFiscalReceiptOpen := Value;
end;

procedure TtDatecsFP3530.SetOnAfterFiscalReceiptSubTotal(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterFiscalReceiptSubTotal := Value;
end;

procedure TtDatecsFP3530.SetOnAfterFiscalReceiptTotal(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterFiscalReceiptTotal := Value;
end;

procedure TtDatecsFP3530.SetOnAfterGetLastReceiptNo(
  const Value: TOnAfterRegistratorEventExtended);
begin
  FOnAfterGetLastReceiptNo := Value;
end;

procedure TtDatecsFP3530.SetOnAfterGetRegistratorSums(const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterGetRegistratorSums := Value;
end;

procedure TtDatecsFP3530.SetOnAfterOpen(const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterOpen := Value;
end;

procedure TtDatecsFP3530.SetOnAfterPrintFiscalTextOnVisit(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterPrintFiscalTextOnVisit := Value;
end;

procedure TtDatecsFP3530.SetOnAfterPrintNonfiscalTextOnVisit(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterPrintNonfiscalTextOnVisit := Value;
end;

procedure TtDatecsFP3530.SetOnAfterPrintReceipt(
  const Value: TOnAfterRegistratorEventExtended);
begin
  FOnAfterPrintReceipt := Value;
end;


procedure TtDatecsFP3530.SetOnAfterProgrammingVisitItems(
  const Value: TOnAfterRegistratorEventItem);
begin
  FOnAfterProgrammingVisitItems := Value;
end;

procedure TtDatecsFP3530.SetOnAfterReceiptReset(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterReceiptReset := Value;
end;

procedure TtDatecsFP3530.SetOnAfterReport_X(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterReport_X := Value;
end;

procedure TtDatecsFP3530.SetOnAfterReport_Z(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterReport_Z := Value;
end;

procedure TtDatecsFP3530.SetOnAfterSaleArticles(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterSaleArticles := Value;
end;

procedure TtDatecsFP3530.SetOnAfterSaleItem(
  const Value: TOnAfterRegistratorEventItem);
begin
  FOnAfterSaleItem := Value;
end;

procedure TtDatecsFP3530.SetOnAfterServiceInOut(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterServiceInOut := Value;
end;

procedure TtDatecsFP3530.SetOnAfterSetHeadeFooters(
  const Value: TOnAfterRegistratorEvent);
begin
  FOnAfterSetHeadeFooters := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeClose(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeClose := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeClrScr(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeClrScr := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeConnect(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeConnect := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeDeleteAllArticle(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeDeleteAllArticle := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeDeleteArticleByItemNo(
  const Value: TOnBeforeRegistratorEventItem);
begin
  FOnBeforeDeleteArticleByItemNo := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeDisConnect(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeDisConnect := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeFiscalReceiptClose(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeFiscalReceiptClose := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeFiscalReceiptOpen(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeFiscalReceiptOpen := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeFiscalReceiptSubTotal(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeFiscalReceiptSubTotal := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeFiscalReceiptTotal(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeFiscalReceiptTotal := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeGetLastReceiptNo(
  const Value: TOnBeforeRegistratorEventExtended);
begin
  FOnBeforeGetLastReceiptNo := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeGetRegistratorSums(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeGetRegistratorSums := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeOpen(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeOpen := Value;
end;

procedure TtDatecsFP3530.SetOnBeforePrintFiscalTextOnVisit(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforePrintFiscalTextOnVisit := Value;
end;

procedure TtDatecsFP3530.SetOnBeforePrintNonfiscalTextOnVisit(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforePrintNonfiscalTextOnVisit := Value;
end;

procedure TtDatecsFP3530.SetOnBeforePrintReceipt(
  const Value: TOnBeforeRegistratorEventExtended);
begin
  FOnBeforePrintReceipt := Value;
end;


procedure TtDatecsFP3530.SetOnBeforeProgrammingVisitItems(
  const Value: TOnBeforeRegistratorEventItem);
begin
  FOnBeforeProgrammingVisitItems := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeReceiptReset(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeReceiptReset := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeReport_X(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeReport_X := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeReport_Z(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeReport_Z := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeSaleArticles(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeSaleArticles := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeSaleItem(
  const Value: TOnBeforeRegistratorEventItem);
begin
  FOnBeforeSaleItem := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeServiceInOut(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeServiceInOut := Value;
end;

procedure TtDatecsFP3530.SetOnBeforeSetHeadeFooters(
  const Value: TOnBeforeRegistratorEvent);
begin
  FOnBeforeSetHeadeFooters := Value;
end;

procedure TtDatecsFP3530.SetOnFinishPrintReceipt(
  const Value: TOnFinishRegistratorEventExtended);
begin
  FOnFinishPrintReceipt := Value;
end;

procedure TtDatecsFP3530.SetOnFinishProgrammingVisitItems(
  const Value: TOnFinishRegistratorEvent);
begin
  FOnFinishProgrammingVisitItems := Value;
end;

procedure TtDatecsFP3530.SetOnStartPrintReceipt(
  const Value: TOnStartRegistratorEventExtended);
begin
  FOnStartPrintReceipt := Value;
end;

procedure TtDatecsFP3530.SetOnStartProgrammingVisitItems(
  const Value: TOnStartRegistratorEvent);
begin
  FOnStartProgrammingVisitItems := Value;
end;

procedure TtDatecsFP3530.SetPassWord(const Value: String);
begin
  FPassWord := Value;
end;

procedure TtDatecsFP3530.SetPayByReceipt(const Value: Double);
begin
  FPayByReceipt := Value;
end;

procedure TtDatecsFP3530.SetReceiptNo(const Value: Integer);
begin
  FReceiptNo := Value;
end;

procedure TtDatecsFP3530.SetReceiptStateText(const Value: String);
begin
  FReceiptStateText := Value;
end;

function TtDatecsFP3530.SetRegistratorDateTime(ADateTime: TDateTime): Boolean;
const
  cAlertSkipSetRegistratorDateTime = 'Установка даты времени регистратора пропущена.';
  cPrintSetRegistratorDateTime = 'Установка даты времени регистратора.';
  cErrorWhileSetRegistratorDateTime = 'Ошибка при установке даты времени регистратора.';
var
  i: Integer;
  lRaiseError: Boolean;
  lDate, lTime: string;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= (egoSetRegistratorDateTime in ExceptionGenerateOptions);
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipSetRegistratorDateTime);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintSetRegistratorDateTime);
        lDate:= FormatDateTime('DD-MM-YY',ADateTime);
        lTime:= FormatDateTime('hh:mm',ADateTime);
        {int CALLBACK  SetDateTime(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,
            LPSTR Date,LPSTR Time)
          Входные данные –
          Date    - строка, определяющая дату, формат строки  DD-MM-YY
          Time - строка, определяющая время, формат строки  HH:MM:SS
          Установка даты и времени. Величина года должна быть до 2089.
          С помощью этой функции  можно изменить время установленное на
            фискальном регистраторе.
          Дата должна соответствовать текущей дате, установленной на регистраторе
            (Изменение даты не допускается). Изменение времени ”назад”
            допускается при условии, если был проведен Z-отчет и после этого не
            открывалось новых фискальных и возвратных чеков.
          Функция не будет выполнена фискальным регистратором, если указана дата,
            предшествующая дате последнего Z-отчета.}
        GetRegistratorStatus;
        i:= SetDateTime(FHWND, PrinterResults, FPar, PChar(lDate), PChar(lTime));
        if (i < 0) or FatalError then begin
          Result:= False;
          LogException(llERROR, cErrorWhileSetRegistratorDateTime, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileSetRegistratorDateTime, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

procedure TtDatecsFP3530.SetReturnOptions(
  const Value: TDatecsFP3530ReturnOptions);
begin
  FReturnOptions := Value;
end;

procedure TtDatecsFP3530.SetSerialPortNumber(const Value: Integer);
begin
  FSerialPortNumber := Value;
end;

procedure TtDatecsFP3530.SetServiceIn(const Value: Double);
begin
  FServiceIn := Value;
end;

procedure TtDatecsFP3530.SetServiceOut(const Value: Double);
begin
  FServiceOut := Value;
end;

procedure TtDatecsFP3530.SetStoredByReceipt(const Value: Double);
begin
  FStoredByReceipt := Value;
end;

procedure TtDatecsFP3530.SetVisit(const Value: TVisit);
begin
  FVisit := Value;
end;

procedure TtDatecsFP3530.SetWriteToLog(const Value: Boolean);
begin
  if FWriteToLog <> Value then begin
    FWriteToLog := Value;
    LogFile.Active:= FWriteToLog;
  end;
end;

function TtDatecsFP3530.GetReceiptStatus: Boolean;
const
  cAlertSkipGetReceiptStatus = 'Определение статуса счета пропущено.';
  cPrintGetReceiptStatus = 'Отпределение статуса счета.';
  cErrorWhileGetReceiptStatus = 'Ошибка при определении статуса счета.';
{------------------------------------------------------------------------------}
  cInfoOpenNonFiscalReceiptCanCansel = 'Открыт не вискальный чек! Необходимо аннулировать!';
  cInfoNoOpenReceipt = 'Нет открытых чеков';
  cInfoOpenSaleReceipt = 'Открыт чек продажи!';
  cInfoOpenReturnReceipt = 'Открыт возвратный чек!';
  cInfoNeedCansel = 'Нужно аннулировать!';
  cInfoNeedRePay = 'Нужно дооплатить чек! Проверьте счет и сумму дооплаты!';
  cInfoNeedClose = 'Необходимо закрыть чек!';
var
  i: Integer;
  lRaiseError: Boolean;
  lStoredByReceipt, lPayByReceipt: Integer;
  lKeepOpened: Boolean;
begin
  Result:= True;
  //lRaiseError:= egoGetReceiptStatus in ExceptionGenerateOptions;
  lRaiseError:= True;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipGetReceiptStatus);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintGetReceiptStatus);
        i:= GetFiscalClosureStatus(FHWND, PrinterResults, FPar,
          roIsReturnInfoSAboutPayLastReceipt in ReturnOption);

        if (i < 0) or FatalError then begin
          Result:= False;
          LogException(llERROR, cErrorWhileGetReceiptStatus, nil, lRaiseError);
        end;
        if Result then begin
          ReceiptStateText:= '';
          // определяем  состояние чека врегистраторе
          with RegistratorStates.AdditioanStates, CommonStates do
          begin
            CommonStates.CanCanselReceipt:= False;
            CommonStates.CanRePayReceipt:= False;
            CommonStates.CanCloseReceipt:= False;
            // Накоплено по чеку
            lStoredByReceipt:= StrToInt(FRetData.RetItem[3]);
            StoredByReceipt:= lStoredByReceipt/100;
            // Накоплено по чеку Оплачено по чеку
            lPayByReceipt:= StrToInt(FRetData.RetItem[4]);
            PayByReceipt:= lPayByReceipt/100;
            if strToInt(FRetData.RetItem[1]) = 0 then begin
              ReceiptStateText:= cInfoNoOpenReceipt;
              CommonStates.CanCanselReceipt:= False;
              CommonStates.CanRePayReceipt:= False;
              CommonStates.CanCloseReceipt:= False;
            end;

            if RegistratorStates.AdditioanStates.NONFISCAL_OPEN then begin
              ReceiptStateText:= cInfoOpenNonFiscalReceiptCanCansel;
              CommonStates.CanCanselReceipt:= True;
              CommonStates.CanRePayReceipt:= False;
              CommonStates.CanCloseReceipt:= False;
            end;

            if (FISCAL_OPEN or ExistsOpenReceipt) and PRINT_RESTART then
              ReceiptStateText:= cInfoOpenReturnReceipt;

            if (FISCAL_OPEN or ExistsOpenReceipt) and not PRINT_RESTART then
              ReceiptStateText:= cInfoOpenSaleReceipt;

            if lPayByReceipt <> 0 then begin
              if lStoredByReceipt = lPayByReceipt then begin
                ReceiptStateText:= ReceiptStateText + cInfoNeedClose;
                CommonStates.CanCanselReceipt:= False;
                CommonStates.CanRePayReceipt:= False;
                CommonStates.CanCloseReceipt:= True;
              end
              else begin
                ReceiptStateText:= ReceiptStateText + cInfoNeedRePay;
                CommonStates.CanCanselReceipt:= False;
                CommonStates.CanRePayReceipt:= True;
                CommonStates.CanCloseReceipt:= False;
              end;
            end
            else begin
              ReceiptStateText:= ReceiptStateText + cInfoNeedCansel;
              CommonStates.CanCanselReceipt:= True;
              CommonStates.CanRePayReceipt:= False;
              CommonStates.CanCloseReceipt:= False;
            end;

          end;//with RegistratorStates.AdditioanStates do
        end; //if Result then begin
      end //if Open then begin
      else begin
        Result:= False;
      end;//else  Open then begin
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileGetReceiptStatus, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.GetRegistratorDateTime(
  var ADateTime: TDateTime): Boolean;
const
  cAlertSkipGetRegistratorDateTime = 'Получение даты / времени регистратора пропущено.';
  cPrintGetRegistratorDateTime = 'Получение даты / времени регистратора.';
  cErrorWhileGetRegistratorDateTime = 'Ошибка при Получение даты / времени регистратора.';
var
  i: Integer;
  lRaiseError, lKeepOpened: Boolean;
  lStr: string;
  lFormatSettings: TFormatSettings;
begin
  Result:= True;
//  lRaiseError:= in ExceptionGenerateOptions;
  lRaiseError:= True;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipGetRegistratorDateTime);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintGetRegistratorDateTime);
        GetRegistratorStatus;
        {int CALLBACK  GetDateTime(HWND hwnd,void (CALLBACK *Fn),LPARAM UI)
           Входные данные - нет   Выходные данные - Возвращаются в структуре
           RetData - LPSTR RetItem[0], RetItem[1];
           <DD-MM-YY> - Текущая дата
           <HH:MM[:SS]> - Текущее время
        По этой команде в прикладную программу возвращается дата и время.}
        i:= GetDateTime(FHWND, PrinterResults, FPar);
        lStr:= FRetData.RetItem[1]+' '+FRetData.RetItem[2];
        Insert( '20',lStr, 7);
        lFormatSettings.DateSeparator:= '-';
        lFormatSettings.TimeSeparator:= ':';
        lFormatSettings.ShortDateFormat:= 'dd-mm-yyyy';
        lFormatSettings.ShortTimeFormat:='hh:mm:ss';
        lFormatSettings.LongDateFormat:= 'dd-mm-yyyy';
        lFormatSettings.LongTimeFormat:='hh:mm:ss';

        ADateTime:= StrToDateTime(lStr, lFormatSettings);
        if (i < 0) or FatalError then begin
          Result:= False;
          LogException(llERROR, cErrorWhileGetRegistratorDateTime, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileGetRegistratorDateTime, e, lRaiseError);
      end;
    end;
  finally
    if Result then LogFile.Add(llINFO, cSuccessfully);
    KeepOpened:= lKeepOpened;
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.GetRegistratorStatus: Boolean;
const
  cAlertSkipGetRegistratorStatus = 'Получение данных о состоянии регистратора пропущено.';
  cPrintGetRegistratorStatus = 'Получение данных о сосотонии регистратора.';
  cErrorWhileGetRegistratorStatus = 'Ошибка при получении данных о состоянии регистратора.';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoGetRegistratorStatus in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipGetRegistratorStatus);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintGetRegistratorStatus);
        i:= GetStatus(FHWND, PrinterResults, FPar, False);
        if (i < 0) then begin
          Result:= False;
          LogException(llERROR, cErrorWhileGetRegistratorStatus, nil, lRaiseError);
        end;
        if FatalError then begin
          FatalError:= False;
          LogException(llERROR, cFatalErrorOccuredOnPreviousStep, nil, True);
        end;                                                    
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileGetRegistratorStatus, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.GetRegistratorSums(): Boolean;
const
  cAlertSkipGetRegistratorSums = 'Пропускаем считываение сумм работы фискального регистратора!';
  cGetRegistratorSums = 'Считываем сумм работы фискального регистратора!';
  cErrorWhileGetRegistratorSums = 'Ошибка при считывании сумм работы фискального регистратора!'+#10#13;
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoGetRegistratorSums in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipGetRegistratorSums);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cGetRegistratorSums);
        {int   CALLBACK ServiceInputOutput(HWND, void (CALLBACK far *), LPARAM, double);
        Входные данные -
        Amount -	Размер служебно внесенной в кассу суммы. Операция зависит от знака (+ - внос суммы, - - вынос суммы)
        Выходные данные - Возвращаются в структуре RetData - LPSTR RetItem[0], RetItem[1],
        RetItem[2];
        CashSum -	Наличность в кассе;
        ServiceIn -	Общая сумма денег в кассе внесенных
        за день;
        ServiceOut -	Общая сумма всех служебно выплаченных сумм из
        кассы за день;
        При ненулевом значение регистра Amount  отпечатывается сообщение об операции.}
        if Assigned(FOnBeforeGetRegistratorSums) then
          FOnBeforeGetRegistratorSums(Self, FatalError, FRetData);
        GetRegistratorStatus;
        i:= ServiceInputOutput(FHWND, PrinterResults, FPar, Get_Registrator_Sum);
        if Assigned(FOnAfterGetRegistratorSums) then
          FOnAfterGetRegistratorSums(Self, FatalError, FRetData);                    
        if (i < 0) or FatalError then begin
          FatalError:= False;
          Result:= False;
          LogException(llTRACE, cErrorWhileGetRegistratorSums, nil, lRaiseError);
        end;
        try
          CashSum:= StrToFloat(copy(FRetData.RetItem[1],2,length(FRetData.RetItem[1])))/cConvertToMoney;
          ServiceIn:= StrToFloat(copy(FRetData.RetItem[2],2,length(FRetData.RetItem[2])))/cConvertToMoney;
          ServiceOut:= StrToFloat(copy(FRetData.RetItem[3],2,length(FRetData.RetItem[3])))/cConvertToMoney;
        except on e: Exception do
          begin
            Result:= False;
            LogException(llTRACE, cErrorWhileGetRegistratorSums, e, lRaiseError);
          end;
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin                                                                  
        Result:= False;
        LogException(llERROR, cErrorWhileGetRegistratorSums, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.ServiceInOut(Amount: double): Boolean;
const
  cAlertSkipServiceIn = 'Служебное внесение пропущено.';
  cServiceIn = 'Служебное внесение.';
  cErrorWhileServiceIn = 'Ошибка Служебном внесении.';
  cAlertSkipServiceOut = 'Служебное вынесение пропущено.';
  cServiceOut = 'Служебное вынесение.';
  cErrorWhileServiceOut = 'Ошибка Служебном вынесении.';
var
  lAlertSkipServiceInOut: String;
  lServiceInOut: String;
  lErrorWhileServiceOut: String;
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  if Amount > 0  then begin
    lAlertSkipServiceInOut:= cAlertSkipServiceIn;
    lServiceInOut:= cServiceIn;
    lErrorWhileServiceOut:= cErrorWhileServiceIn;
  end
  else begin
    lAlertSkipServiceInOut:= cAlertSkipServiceOut;
    lServiceInOut:= cServiceOut;
    lErrorWhileServiceOut:= cErrorWhileServiceOut;
  end;
  Result:= True;
  lRaiseError:= egoServiceInOut in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+lAlertSkipServiceInOut);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, lServiceInOut);
        {if FatalError then begin
          lRaiseError:= False;
          FatalError:= False;
          raise Exception.Create(cFatalErrorOccuredOnPreviousStep);
        end;}
        {int   CALLBACK ServiceInputOutput(HWND, void (CALLBACK far *), LPARAM, double);
          Входные данные -
          Amount -	Размер служебно внесенной в кассу суммы. Операция зависит от знака (+ - внос суммы, - - вынос суммы)
          Выходные данные - Возвращаются в структуре RetData - LPSTR RetItem[0], RetItem[1],
          RetItem[2];
          CashSum -	Наличность в кассе;
          ServiceIn -	Общая сумма денег в кассе внесенных
          за день;
          ServiceOut -	Общая сумма всех служебно выплаченных сумм из
          кассы за день;
          При ненулевом значение регистра Amount  отпечатывается сообщение об операции.}
        if Assigned(FOnBeforeServiceInOut) then
          FOnBeforeServiceInOut(Self, FatalError, FRetData);
        GetRegistratorStatus;
        i:= ServiceInputOutput(0, PrinterResults, 0, Amount);
        if Assigned(FOnAfterServiceInOut) then
          FOnAfterServiceInOut(Self, FatalError, FRetData);
        if (i < 0) or FatalError then begin
          FatalError:= False;
          Result:= False;
          LogException(llERROR, lErrorWhileServiceOut, nil, lRaiseError);
        end;
        FReceiptNo:= GetLastReceiptNo;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, lErrorWhileServiceOut, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.GetLastReceiptNo: Integer;
const
  cAlertSkipGetLastReceiptNo = 'Пропущено получение последнего номер чека.';
  cErrorWhileGetLastReceiptNo = 'Ошибка при получении последнего номера чека.';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  {функция возвращает последний номер чека, если произошла ошибка, то функция в
   возвращает -1}
  Result:= 0;
  lRaiseError:= egoGetLastReceiptNo in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipGetLastReceiptNo);
     Exit;
  end;
  {int   CALLBACK GetLastReceipt(HWND hwnd, void (CALLBACK far *Fn), LPARAM UI);
  Входные данные - нет Выходные данные – LPSTR RetItem[0]
  RetItem[0]- Номер последнего фискального чека
  По этой команде возвращается номер последнего фискального чека}
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        if Assigned(FOnBeforeGetLastReceiptNo) then
          FOnBeforeGetLastReceiptNo(Self, FatalError, FRetData, Result);
        GetRegistratorStatus;
        i:= GetLastReceipt(FHWND, PrinterResults, FPar);
        Result:= StrToInt(FRetData.RetItem[1]);
        if Assigned(FOnAfterGetLastReceiptNo) then
          FOnAfterGetLastReceiptNo(Self, FatalError, FRetData, Result);

        if (i < 0) or FatalError then begin
          FatalError:= False;
          Result:= -1;
          LogException(llERROR, cErrorWhileGetLastReceiptNo, nil, lRaiseError);
        end;
      end;
    Except on e: Exception do
      begin
        Result:= -1;
        LogException(llERROR, cErrorWhileGetLastReceiptNo, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.GetProgrammedItemsInMemory: Boolean;
const
  cAlertGetProgrammedItemsInMemory =
    'Считывание данных по запрограммированным ариткулам пропущено.';
  cPrintGetProgrammedItemsInMemory =
    'Считывание данных по запрограммированным ариткулам.';
  cErrorWhileGetProgrammedItemsInMemory =
    'Ошибка при считывание данных по запрограммированным ариткулам.';
var
  i, j: Integer;
  lRaiseError, lKeepOpened: Boolean;
  lMaxItemNo: Integer;
  lStr: string;
  lArticle: TArticle;
begin
  Result:= True;
  lRaiseError:= True;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertGetProgrammedItemsInMemory);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintGetProgrammedItemsInMemory);
        GetRegistratorStatus;
        {int   CALLBACK GetCommonArticleInfo(HWND hwnd,void (CALLBACK *Fn),LPARAM UI)
         Входные данные – Нет
         Выходные данные – Длина,Всего,Запрограммировано}
        GetCommonArticleInfo(FHWND, PrinterResults, FPar);
        {Количество запрограммированных артикулов}
        lMaxItemNo:= StrToInt(FRetData.RetItem[3]);
        for I := 0 to ProgrammedItemsInMemory.Count - 1 do
        begin
          lArticle:= ProgrammedItemsInMemory[i];
          if lArticle <> nil then begin
            lArticle.Free;
          end;
        end;
        ProgrammedItemsInMemory.Clear;
        {int   CALLBACK GetArticleInfo(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,
          int numart)
        Входные данные – numart
        Выходные данные - НомерАрт,НалГруппа,Группа,Цена,Кол,Всего,ЧКол,ЧВсего,
          Название.}

        for j := 1 to lMaxItemNo do
        begin
          lArticle:= TArticle.Create;
          i:= GetArticleInfo(FHWND, PrinterResults, FPar, j);
          lStr:= FRetData.RetItem[5];
          lArticle.FCode:= StrToInt(FRetData.RetItem[2]);
          lStr:= StringReplace(lStr, ',', DecimalSeparator, [rfReplaceAll, rfIgnoreCase]);
          lStr:= StringReplace(lStr, '.', DecimalSeparator, [rfReplaceAll, rfIgnoreCase]);
          lArticle.FPrice:= StrToFloat(lStr);
          lArticle.FName:= FRetData.RetItem[10];
          if (i < 0) or FatalError then begin
            Result:= False;
            LogException(llERROR, cErrorWhileGetProgrammedItemsInMemory, nil, lRaiseError);
            Break;
          end;
          ProgrammedItemsInMemory.Add(lArticle);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileGetProgrammedItemsInMemory, e, lRaiseError);
      end;
    end;
  finally
    if Result then LogFile.Add(llINFO, cSuccessfully);
    KeepOpened:= lKeepOpened;
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.SetHeadeFooters: Boolean;
const
  cAlertSkipSetHeadeFooters = 'Установка заголовка счета пропущена.';
  cSetHeadeFooters = 'Установка заголовка счета .';
  cErrorWhileSetHeadeFooters = 'Ошибка при установке заголовка счета .';
  cSetLine = 'Устанавливаем строку № ';
var
  i, j: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
  lStr: String;
begin
  Result:= True;
  lRaiseError:= egoSetHeadeFooters in ExceptionGenerateOptions;
  if Assigned(FOnBeforeSetHeadeFooters) then
    FOnBeforeSetHeadeFooters(Self, FatalError, FRetData);
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipSetHeadeFooters);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cSetHeadeFooters);
        for j := 0 to HeaderLines.Count - 1 do
        begin
          lStr:= HeaderLines[j];
          //if Trim(lStr) = '' then Continue;          
          LogFile.Add(llINFO, cSetLine+IntToStr(j));
          LogFile.Add(llINFO, lStr);
          GetRegistratorStatus;
          i:= SetHeaderFooter(FHWND, PrinterResults, FPar, j, PChar(lStr));
          if (i < 0) or FatalError then begin
            FatalError:= False;
            Result:= False;
            LogException(llERROR, cErrorWhileSetHeadeFooters, nil, lRaiseError)
          end;
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileSetHeadeFooters, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.ReceiptReset: Boolean;
const
  cAlertSkipReceiptReset = 'Аннулирование чека пропущено .';
  cPrintReceiptReset = 'Аннулирование чека.';
  cErrorWhileReceiptReset = 'Ошибка при аннулирование чека.';
  cAlertNotExistsOpenReceipt = 'Нет открытых счетов. Нечего аннулировать.';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoReceiptReset in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipReceiptReset);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintReceiptReset);
        KeepOpened:= True;
        GetRegistratorStatus;
        {if FatalError then begin
          lRaiseError:= False;
          FatalError:= False;
          raise Exception.Create(cFatalErrorOccuredOnPreviousStep);
        end;}
        {int   CALLBACK ResetReceipt(HWND hwnd,void (CALLBACK *Fn),LPARAM UI)
         Входные данные - нет
         Выходные данные - нет
         С помощью этой функции  аннулируется текущий открытый фискальный чек или
         чек возврата.}
        i:= 0;
        if Assigned(FOnBeforeReceiptReset) then
          FOnBeforeReceiptReset(Self, FatalError, FRetData);
        if CommonStates.ExistsOpenReceipt then
          i:= ResetReceipt(FHWND, PrinterResults, FPar)
        else
          LogFile.Add(llINFO, cAlertNotExistsOpenReceipt);

        if Assigned(FOnAfterReceiptReset) then
          FOnAfterReceiptReset(Self, FatalError, FRetData);
        if (i < 0) or FatalError then begin
          FatalError:= False;
          Result:= False;
          LogException(llERROR, cErrorWhileReceiptReset, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileReceiptReset, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);    
    Close;
    CallStackDeep:= CallStackDeep-1;
    if Assigned(FOnAfterSetHeadeFooters) then
      FOnAfterSetHeadeFooters(Self, FatalError, FRetData);
  end;
end;

function TtDatecsFP3530.ProgrammedArticlesFromProgrammedItems: Boolean;
var
  i: Integer;
  lArticle: TArticle;
begin
  Result:= True;
  for i:= 0 to ProgrammedItems.Count - 1 do
  begin
    lArticle:= ProgrammedItems[i];
    ProgrammingArticle(FHWND, PrinterResults, FPar, cGroupInventory,
      lArticle.FCode, cGroupNumber, lArticle.FPrice, PChar(FPassWord),
      PChar(lArticle.FName));
  end;
end;

function TtDatecsFP3530.ProgrammedCurrentOperatorName: boolean;
var
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  lRaiseError:= egoProgrammedCurrentOperatorName in ExceptionGenerateOptions;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    Result:= false;
    try
      if Open then begin
        KeepOpened:= True;
        Result:= ProgrammedOperatorNameByNamber(CurrentOperatorNumber,
          CurrentOperatorName, CurrentOperatorPassword);
      end;
    except  on e: Exception do
      begin
        LogException(llERROR, e.Message, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.ProgrammedOperatorNameByNamber(
  AOperatorNamuber: integer; AOperatorName, AOperatorPassword: String): boolean;
const
  cAlertSkipProgrammedOperatorNameByNamber = 'Программирование имени оператора пропущено.';
  cPrintProgrammedOperatorNameByNamber = 'Программирование имени оператора:';
  cErrorWhileProgrammedOperatorNameByNamber = 'Ошибка при программировании имени оператора.';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoProgrammedOperatorNameByNamber in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+
       cAlertSkipProgrammedOperatorNameByNamber);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintProgrammedOperatorNameByNamber+AOperatorName);
        {int   CALLBACK SetOperatorName(HWND hwnd, void (CALLBACK *Fn), LPARAM UI, int NumOper, LPSTR Password, LPSTR Name)
         Входные данные –
         NumOper - Номер оператора (может быть от 1 до 13)
         Password - Пароль оператора (от 4 до 8 цифр)
         Name - Имя оператора (до 24 символов)
         С помощью этой функции можно задать имя для любого из тринадцати
         операторов фискального регистратора. Вслед за инициализацией и
         обнулением оперативной памяти значения паролей операторов равны нулю.
         Имя оператора (оператщр1 – оператор13) печатается при открытии
         фискального чека.}
        GetRegistratorStatus;
        i:= SetOperatorName(FHWND, PrinterResults, FPar, AOperatorNamuber,
          Pchar(AOperatorPassword), Pchar(AOperatorName));
        if (i < 0) or FatalError then begin
          Result:= False;
          LogException(llERROR, cErrorWhileProgrammedOperatorNameByNamber, nil,
            lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileProgrammedOperatorNameByNamber, e,
          lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.ProgrammingVisitItems: Boolean;
const
  cAlertSkipProgammingVisitItems = 'Программирование артикулов пропущено.';
  cPrintProgammingVisitItems = 'Программирование артикулов.';
  cErrorWhileProgammingVisitItems = 'Ошибка при программировании артикулов.';
  cPrintProgrammedItemsCount = 'Всего запрограммировано: ';
  cPrintNextNumber = 'Следующий номер: ';
var i, j, lMaxItemNo: Integer;
  lName: String;
  lCode: Integer;
  lVisitItem: TItem;
  lNewArticle, lArticle: TArticle;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoProgrammingVisitItems in ExceptionGenerateOptions;
  if Assigned(FOnStartProgrammingVisitItems) then
    FOnStartProgrammingVisitItems(Self, FatalError, FRetData, Result);

  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipProgammingVisitItems);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintProgammingVisitItems);
        {int   CALLBACK GetCommonArticleInfo(HWND hwnd,void (CALLBACK *Fn),LPARAM UI)
         Входные данные – Нет
         Выходные данные – Длина,Всего,Запрограммировано}
        GetCommonArticleInfo(FHWND, PrinterResults, FPar);
        lMaxItemNo:= StrToInt(FRetData.RetItem[3])+1;
        LogFile.Add(llTRACE, cPrintProgrammedItemsCount+FRetData.RetItem[3]);
        LogFile.Add(llTRACE, cPrintNextNumber+IntToStr(lMaxItemNo));
        for j:= 0 to FVisit.FVisitItems.Count - 1 do
        begin
         { TypeOfPayment: Char(1);
          Group: Integer;
          Code: Integer;
          Price: Integer;
          DiscountSum: Double;
          DiscountPercent: Double;
          Data: Pointer;}
          //if lVisitItem.FCode = 0 then begin
            lCode:= isItemProgrammed(j);
            lVisitItem:= FVisit.FVisitItems[j];
          //end
          //else lCode:= lVisitItem.FCode;

          if lCode >= 0 then begin
            lVisitItem.FCode:= lCode;
            for I := 0 to ProgrammedItems.Count - 1 do
            begin
              lArticle:= ProgrammedItems[i];
              if lArticle.FCode = lCode then begin
                lArticle.FisSaled:= True;
                Break;
              end;
              //lArticle:= nil;
            end;
          end
          else
            with lVisitItem do
            begin
              lName:= FName;
              // один символ отдаем для #9
              //lName:= copy(lName,1,24)+#9+copy(lName,25,23);
              lName:= FName;
              if Assigned(FOnBeforeProgrammingVisitItems) then
                FOnBeforeProgrammingVisitItems(Self, FatalError, FRetData,
                  Result, j, lVisitItem);
              GetRegistratorStatus;
              i:= ProgrammingArticle(FHWND, PrinterResults, FPar, FInventoryGroup,
                lMaxItemNo, FGroup, FPrice, PChar(FPassWord), PChar(lName));
                FCode:= lMaxItemNo;
              if (i < 0) or FatalError then begin
                LogFile.Add(llERROR, cErrorWhileProgammingVisitItems);
                FatalError:= False;
                Result:= False;
                LogException(llERROR, cErrorWhileProgammingVisitItems, nil, lRaiseError);
              end;
              FCode:= lMaxItemNo;
              lNewArticle:= TArticle.Create;
              CopyItemToArticle(lVisitItem, lNewArticle);
              ProgrammedItems.Add(lNewArticle);
              inc(lMaxItemNo);
              if Assigned(FOnAfterProgrammingVisitItems) then
                FOnAfterProgrammingVisitItems(Self, FatalError, FRetData, Result,
                  j,lVisitItem);
            end;
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileProgammingVisitItems, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
    if Assigned(FOnFinishProgrammingVisitItems) then
      FOnFinishProgrammingVisitItems(Self, FatalError, FRetData, Result);
  end;
end;

function TtDatecsFP3530.SaleItem(AItem: TItem; AIndex: Integer; ASign: Boolean): Boolean;
const
  cAlertSkipSaleArticles = 'Продажа артикула пропущена...';
  cPrintSaleArticle = 'Продажа артикула %s.';
  cErrorWhileSaleArticle = 'Ошибка при продаже артикула.';
  cErrorNotZeroDiscountSumAndDiscountPercent = 'Сумма скидки и процент скидки одновременно не равны нулю.';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  {int CALLBACK SaleArticleAndDisplay(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,
     bool sign, int numart, double qwant, double perc, double  dc)
   Входные данные –
   sign - ‘+’ или ‘-‘ (тип внутричековой операции – продажа или возврат вышепроданной позиции)
   numart - номер артикула
   qwant - количество для продажи (произведение количества на цену не должно
     превышать 9 знаков (два после запятой))
   perc -  надбавки/скидки (в зависимости от знака, может меняться от -99.00 до +99.00)
   dc – количественная надбавка/скидка (в зависимости от знака) в абсолютном исчислении.
   Выходные данные – нет
   Функция предназначена для осуществления продажи  товара в фискальном чеке,
   либо возврата в чеке возврата и выводе информации о продаже на дисплей
   покупателя. perc и dc не могут быть одновременно ненулевыми.}
  {int CALLBACK SaleArticle(HWND hwnd,void (CALLBACK *Fn),LPARAM UI, bool sign,
     int numart, double qwant, double perc, double  dc)
   Входные данные –
   sign - ‘+’ или ‘-‘ (тип внутричековой операции – продажа или возврат вышепроданной позиции)
   numart - номер артикула
   qwant - количество для продажи (произведение количества на цену не должно
     превышать 9 знаков (два после запятой))
   perc - процент надбавки/скидки (в зависимости от знака, может меняться от -99.00 до +99.00)
   dc – количественная надбавка/скидка (в зависимости от знака) в абсолютном исчислении.
   Выходные данные – нет

   Функция предназначена для осуществления продажи  товара в фискальном чеке,
   либо возврата в чеке возврата. perc и dc не могут быть одновременно ненулевыми.}
  lRaiseError:= egoSaleItem in ExceptionGenerateOptions;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    lKeepOpened:= True;
    Result:= True;
    try
      KeepOpened:= True;
      if not Enabled then begin
        LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipSaleArticles);
        Exit;
      end;
      with AItem do
      begin
        LogFile.Add(llINFO, Format(cPrintSaleArticle,[FName]));
        LogFile.Add(llTRACE, 'FTypeOfPayment ='+FInventoryGroup);
        LogFile.Add(llTRACE, 'FGroup ='+IntToStr(FGroup));
        LogFile.Add(llTRACE, 'FCode ='+IntToStr(FCode));
        LogFile.Add(llTRACE, 'FFPrice ='+FloatToStr(FPrice));
        LogFile.Add(llTRACE, 'FDiscountSum ='+FloatToStr(FDiscountSum));
        LogFile.Add(llTRACE, 'FDiscountPercent ='+FloatToStr(FDiscountPercent));
        LogFile.Add(llTRACE, 'FName ='+FName);
        LogFile.Add(llTRACE, 'FItemNo ='+IntToStr(FCode));
        LogFile.Add(llTRACE, 'FQuantity ='+FloatToStr(FQuantity));
        if (Abs(FDiscountSum-0) > 0.001) and (Abs(FDiscountPercent-0) > 0.001) then begin
          LogFile.Add(llERROR, cErrorNotZeroDiscountSumAndDiscountPercent);
          Result:= False;
          Exit;
        end;
        if Assigned(FOnBeforeSaleItem) then
          FOnBeforeSaleItem(Self, FatalError, FRetData, Result, AIndex, AItem);
        GetRegistratorStatus;
        if ( doDisplayWhileSaleItem in DisplayOption) then
          i:= SaleArticleAndDisplay(FHWND, PrinterResults, FPar, ASign, FCode,
            FQuantity, FDiscountPercent, FDiscountSum)
        else
          i:= SaleArticle(FHWND, PrinterResults, FPar, ASign, FCode,
            FQuantity, FDiscountPercent, FDiscountSum);
        if Assigned(FOnAfterSaleItem) then
          FOnAfterSaleItem(Self, FatalError, FRetData, Result, AIndex, AItem);
      end;

      if (i < 0) or FatalError then begin
        FatalError:= False;
        Result:= False;
        LogException(llERROR, cErrorWhileSaleArticle, nil, lRaiseError);
      end
      else
        LogFile.Add(llINFO, cSuccessfully);
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileSaleArticle, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.SaleArticles(ASign: Boolean): Boolean;
const
  cAlertSkipSaleArticles = 'Продажа артикулов пропущена.';
  cPrintSaleArticles = 'Продаем артикулы...';
  cErrorWhileSaleArticles = 'Ошибка при продаже артикулов.';
var
  i: Integer;
  lItem: TItem;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
  //lstr: String;
begin
  Result:= True;
  lRaiseError:= egoSaleArticles in ExceptionGenerateOptions;
  if Assigned(FOnBeforeSaleArticles) then
    FOnBeforeSaleArticles(Self, FatalError, FRetData);

  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipSaleArticles);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintSaleArticles);
  //------------------------------------------------------------------------------
        for i:= 0 to FVisit.FVisitItems.Count - 1 do
        begin
          lItem:=FVisit.FVisitItems[i];
          Result:= SaleItem(lItem, i, cSignSale);
          {lstr:= 'Testing While SaleArticles!!!'+#10#13+
          'StoredByReceipt = '+FloatToStr(StoredByReceipt)+#10#13+
          'PayByReceipt = '+FloatToStr(PayByReceipt);
          ShowMessage(lstr);}
          if not Result then Break;
        end;
  //------------------------------------------------------------------------------
        if not Result or FatalError then begin
          FatalError:= False;
          Result:= False;
          LogException(llERROR, cErrorWhileSaleArticles, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileSaleArticles, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
    if Assigned(FOnAfterSaleArticles) then
      FOnAfterSaleArticles(Self, FatalError, FRetData);
  end;
end;

function TtDatecsFP3530.PrintReceipt(ASign: Boolean): Integer;
const
  cAlertSkipPrintReceiptSale = 'Печать чека "Продажа" пропущена.';
  cAlertSkipPrintReceiptReturn = 'Печать чека "Возврат" пропущена';
  cPrintPrintReceiptSale = 'Печать чека "Продажа".';
  cPrintPrintReceiptReturn = 'Печать чека "Возврат".';
  cErrorWhileReceiptSale = 'Ошибка при печати чека "Продажа".';
  cErrorWhileReceiptReturn = 'Ошибка при печати чека "Возврат".';
var
  lKeepOpened: Boolean;
  lRaiseError: Boolean;
//  lstr: String;
begin
  {функция печатает чек "Продажа" если ASign = 1 и "Возврат" если ASign = 0.
   Функция возвращает номер напечатанного чека, или же 0, если регистратор
   деактивирован и -1 если в результате работы программы произошла ошибка}
  Result:= 0;
  lRaiseError:= egoPrintEmptyReceipt in ExceptionGenerateOptions;
  if Assigned(FOnStartPrintReceipt) then
    FOnStartPrintReceipt(Self, FatalError, FRetData, Result);

  if not Enabled then begin
     if ASign then
       LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipPrintReceiptSale)
     else
       LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipPrintReceiptReturn);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        if Assigned(FOnBeforePrintReceipt) then
          FOnBeforePrintReceipt(Self, FatalError, FRetData, Result);

        if ASign then
          LogFile.Add(llINFO, cPrintPrintReceiptSale)
        else
          LogFile.Add(llINFO, cPrintPrintReceiptReturn);
        // ### Tatarinov Testing
        {lstr:= 'Testing FiscalReceiptOpen!!!'+#10#13+
        'StoredByReceipt = '+FloatToStr(StoredByReceipt)+#10#13+
        'PayByReceipt = '+FloatToStr(PayByReceipt);
        ShowMessage(lstr);}
        //raise Exception.Create('Testing Begfore FiscalReceiptOpen!!!');
        if not FiscalReceiptOpen(ASign) then begin
          Result:= -1;
          Exit;
        end;
        {done: Добавить в свойство вызов функции для печати как не фискального
          текста номер счета }
        // ### Tatarinov Testing          
        {lstr:= 'Testing before SaleArticles!!!'+#10#13+
        'StoredByReceipt = '+FloatToStr(StoredByReceipt)+#10#13+
        'PayByReceipt = '+FloatToStr(PayByReceipt);
        ShowMessage(lstr);}
        //raise Exception.Create('Testing Before SaleArticles!!!');
        if not SaleArticles(ASign) then begin
          Result:= -1;
          Exit;
        end;
        // ### Tatarinov Testing
        {GetReceiptStatus;
        lstr:= 'Testing after SaleArticles!!!'+#10#13+
        'StoredByReceipt = '+FloatToStr(StoredByReceipt)+#10#13+
        'PayByReceipt = '+FloatToStr(PayByReceipt);
        ShowMessage(lstr);}
        //raise Exception.Create('Testing Before FiscalReceiptSubTotal!!!');
        if not FiscalReceiptSubTotal then begin
          Result:= -1;
          Exit;
        end;
        // ### Tatarinov Testing
        {GetReceiptStatus;
        lstr:= 'Testing FiscalReceiptSubTotal!!!'+#10#13+
        'StoredByReceipt = '+FloatToStr(StoredByReceipt)+#10#13+
        'PayByReceipt = '+FloatToStr(PayByReceipt);
        ShowMessage(lstr);}
        //raise Exception.Create('Testing Before FiscalReceiptTotal!!!');
        if not FiscalReceiptTotal then begin
          Result:= -1;
          Exit;
        end;
        // ### Tatarinov Testing
        {GetReceiptStatus;
        lstr:= 'Testing FiscalReceiptTotal!!!'+#10#13+
        'StoredByReceipt = '+FloatToStr(StoredByReceipt)+#10#13+
        'PayByReceipt = '+FloatToStr(PayByReceipt);
        ShowMessage(lstr);}
        //raise Exception.Create('Testing Before FiscalReceiptClose!!!');
        if not FiscalReceiptClose(ASign) then begin
          Result:= -1;
          Exit;
        end;
        // ### Tatarinov Testing
        {GetReceiptStatus;
        lstr:= 'Testing FiscalReceiptClose!!!'+#10#13+
        'StoredByReceipt = '+FloatToStr(StoredByReceipt)+#10#13+
        'PayByReceipt = '+FloatToStr(PayByReceipt);
        ShowMessage(lstr);}
        Result:= GetLastReceiptNo;
        if Assigned(FOnAfterPrintReceipt) then
          FOnAfterPrintReceipt(Self, FatalError, FRetData, Result);
      end
      else begin
        Result:= -1;
      end;
    Except on e: Exception do
      begin
        Result:= -1;
        LogException(llERROR, cErrorWhileReceiptSale, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result > 0 then LogFile.Add(llINFO, cSuccessfully);
    try
      if (Result = -1) or FatalError then begin
        FatalError:= False;
        Result:= -1;
        if ASign then
          LogException(llERROR, cErrorWhileReceiptSale, nil, lRaiseError)
        else
          LogException(llERROR, cErrorWhileReceiptReturn, nil, lRaiseError);
      end;
    finally
      Close;
      CallStackDeep:= CallStackDeep-1;
      if Assigned(FOnFinishPrintReceipt) then
        FOnFinishPrintReceipt(Self, FatalError, FRetData, Result);
    end;
  end;
end;

function TtDatecsFP3530.FiscalReceiptOpen(ASign: Boolean): Boolean;
const
  cAlertSkipFiscalReceiptSaleOpen = 'Открытие чек "Продажа" пропущено.';
  cAlertSkipFiscalReceiptReturnOpen = 'Открытие чек "Возврат" пропущено.';
  cPrintFiscalReceiptSaleOpen = 'Открываем чек "Продажа".';
  cPrintFiscalReceiptReturnOpen = 'Открываем чек "Возврат".';  
  cErrorWhileFiscalReceiptSaleOpen = 'Ошибка открытии чека "Продажа".';
  cErrorWhileFiscalReceiptReturnOpen = 'Ошибка открытии чека "Возврат".';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  {функция печатает чек "Продажа" если ASign = 1 и "Возврат" если ASign = 0.}
  {int CALLBACK  OpenFiscalReceipt(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,
    DWORD Operator=1,	LPSTR Text="0000", DWORD TillNumber=1, BOOL TaxCheck=true)
    Входные данные –
    Operator – номер оператора (1-13)
    Text – пароль оператора (от 4 до 8 цифр)
    TillNumber – номер кассового места
    TaxCheck- этот параметр должен быть всегда установлен в true. Используется
      для совместимости с предыдущими версиями.
    Выходные данные –
    Возвращаются в структуре RetData - LPSTR RetItem[0], RetItem[1], RetItem[2];
    Счетчик чеков - счетчик всех нефискальный чеков от последнего Z-отчета (4 байта)
    Счетчик фискальных чеков - счетчик всех фискальный чеков от последнего Z-отчета (4 байта)
    СчетчикВозвЧеков - счетчик всех возвратных чеков от последнего Z-отчета (4 байта)
    По этой функции открывается фискальный чек.


    Функция не выполняется успешно если:
    •	Уже был открыт фискальный, возвратный или нефискальный чек
    •	Переполнен счетчик чеков
    •	Фискальная память переполнена
    •	Фискальная память повреждена
    •	Ошибка в параметрах команды
    •	Заголовок чека содержит менее двух рядов
    •	Неверно задан пароль оператора (при троекратном неправильном задании
      пароля фискальный регистратор блокируется, пока не будет проведено его
      выключение и затем включение)
    •	Дата/время не установлены
    •	Не подключен индикатор покупателя}
  {int CALLBACK  OpenRepaymentReceipt(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,
    DWORD, LPSTR, DWORD, BOOL)
    Входные данные –
    Operator – номер оператора (1-13)
    Text – пароль оператора (от 4 до 8 цифр)
    TillNumber – номер кассового места
    TaxCheck- этот параметр должен быть всегда установлен в true. Используется
      для совместимости с предыдущими версиями.
    Выходные данные –
    Возвращаются в структуре RetData - LPSTR RetItem[0], RetItem[1], RetItem[2];
    Счетчик чеков - счетчик всех нефискальный чеков от последнего Z-отчета (4 байта)
    Счетчик фискальных чеков - счетчик всех фискальный чеков от последнего Z-отчета (4 байта)
    СчетчикВозвЧеков - счетчик всех возвратных чеков от последнего Z-отчета (4 байта)

    Эта функции открывает чек возврата.

    Функция не выполняется успешно если:
    •	Уже был открыт фискальный, возвратный или нефискальный чек
    •	Переполнен счетчик чеков
    •	Фискальная память переполнена
    •	Фискальная память повреждена
    •	Ошибка в параметрах команды
    •	Заголовок чека содержит менее двух рядов
    •	Неверно задан пароль оператора (при троекратном неправильном задании пароля фискальный регистратор блокируется, пока не будет проведено его выключение и затем включение)
    •	Дата/время не установлены
    •	Не подключен индикатор покупателя}
  Result:= True;
  lRaiseError:= egoFiscalReceiptOpen in ExceptionGenerateOptions;
  if not Enabled then begin
     if ASign then
       LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipFiscalReceiptSaleOpen)
     else
       LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipFiscalReceiptReturnOpen);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try              
      if Open then begin
        KeepOpened:= True;
        GetRegistratorStatus;
        if ASign then begin
          LogFile.Add(llINFO, cPrintFiscalReceiptSaleOpen);
          i:= OpenFiscalReceipt(FHWND, PrinterResults, FPar, CurrentOperatorNumber,
            PChar(CurrentOperatorPassword), CurrentCashDeskNumber, cTaxCheck);
        end
        else begin
          LogFile.Add(llINFO, cPrintFiscalReceiptReturnOpen);
          i:= OpenRepaymentReceipt(FHWND, PrinterResults, FPar, CurrentOperatorNumber,
            PChar(CurrentOperatorPassword), CurrentCashDeskNumber, cTaxCheck);
        end;
        if Assigned(FOnBeforeFiscalReceiptOpen) then
          FOnBeforeFiscalReceiptOpen(Self, FatalError, FRetData);
        if (i < 0) or FatalError then begin
          FatalError:= False;
          Result:= False;
          if ASign then
            LogException(llERROR, cErrorWhileFiscalReceiptSaleOpen, nil, lRaiseError)
          else
            LogException(llERROR, cErrorWhileFiscalReceiptReturnOpen, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileFiscalReceiptSaleOpen, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.FiscalReceiptClose(ASign: Boolean): Boolean;
const
  cAlertSkipFiscalReceiptSaleClose = 'Закрытие чека "Продажа" пропущено.';
  cAlertSkipFiscalReceiptReturnClose = 'Закрытие чека "Возврат" пропущено.';
  cAlertNoOpenReceiptFiscalReceiptReturnClose = 'Нет открытого счета.';
  cPrintFiscalReceiptSaleClose = 'Закрытие чека "Продажа".';
  cPrintFiscalReceiptReturnClose = 'Закрытие чека "Возврат".';
  cErrorWhileFiscalReceiptSaleClose = 'Ошибка закрытие чека "Продажа".';
  cErrorWhileFiscalReceiptReturnClose = 'Ошибка закрытие чека "Возврат".';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  {int   CALLBACK CloseFiscalReceipt(HWND, void (CALLBACK far *), LPARAM);
  Входные данные - нет
  Выходные данные - Возвращаются в структуре RetData - LPSTR RetItem[0],
    RetItem[1]; Счетчик чеков - счетчик всех нефискальный чеков от последнего
    Z-отчета (4 байта)
  Счетчик фискальных чеков - счетчик всех фискальный чеков от последнего Z-отчета (4 байта)
  СчетчикВозвЧеков - счетчик всех возвратных чеков от последнего Z-отчета (4 байта)
  С помощью этой функции закрывается фискальный или возвратноый чек.}

  Result:= True;
  lRaiseError:= egoFiscalReceiptClose in ExceptionGenerateOptions;
  if not Enabled then begin
     if ASign then
       LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipFiscalReceiptSaleClose)
     else
       LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipFiscalReceiptReturnClose);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        if ASign then
          LogFile.Add(llINFO, cPrintFiscalReceiptSaleClose)
        else
          LogFile.Add(llINFO, cPrintFiscalReceiptReturnClose);
        {int CALLBACK  GetFiscalClosureStatus(HWND hwnd,void (CALLBACK *Fn),
          LPARAM UI,BOOL Current)
        Входные данные – [Параметр]
        Выходные данные – Чек, Счетчик, СуммаЧек, [Оплата]
        Параметр – если true , то возвращается информация о об оплате последнего
          чека (сумма, которую заплатил клиент по последнему чеку)
        Чек – 1 – открыт фискальный или нефискальный чек, 0 - нет открытого чека
        Счетчик – счетчик фискальных чеков
        СуммаЧек – сумма по чеку
        Оплата – сумма, которую заплатил клиент в последнем чеке.}
        GetRegistratorStatus;
        {if FatalError then begin
          lRaiseError:= False;
          FatalError:= False;
          raise Exception.Create(cFatalErrorOccuredOnPreviousStep);
        end;}
{        GetFiscalClosureStatus(FHWND, PrinterResults, FPar,
          (roIsReturnInfoSAboutPayLastReceipt in ReturnOption));}

        if not CommonStates.ExistsOpenReceipt then begin
          Result:= False;
          LogFile.Add(llINFO, cAlertNoOpenReceiptFiscalReceiptReturnClose);
          Exit;
        end;
        if Assigned(FOnBeforeFiscalReceiptClose) then
          FOnBeforeFiscalReceiptClose(Self, FatalError, FRetData);
        i:= CloseFiscalReceipt(FHWND, PrinterResults, FPar);
        if Assigned(FOnAfterFiscalReceiptClose) then
          FOnAfterFiscalReceiptClose(Self, FatalError, FRetData);
        if (i < 0) or FatalError then begin
          if ASign then
            LogFile.Add(llERROR, cErrorWhileFiscalReceiptSaleClose)
          else
            LogFile.Add(llERROR, cErrorWhileFiscalReceiptReturnClose);
          FatalError:= False;
          Result:= False;
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileFiscalReceiptSaleClose, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.FiscalReceiptSubTotal: Boolean;
const
  cAlertSkipFiscalReceiptSubTotal = 'Подитог фискального чека пропущен  пропущена.';
  cPrintFiscalReceiptSubTotal = 'Подитог фискального чека.';
  cErrorWhileFiscalReceiptSubTotal = 'Ошибка при печати подитога фискального чека.';
  cErrorNotZeroSubTotalSumAndSubTotalPercent = 'Сумма и процент подитога чека не равны нулю одновременно.';
var
  i: Integer;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoFiscalReceiptTotal in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipFiscalReceiptSubTotal);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintFiscalReceiptSubTotal);
        if (Abs(FVisit.SubTotalSum-0) > 0.001) and (Abs(FVisit.SubTotalPercent-0) > 0.001) then begin
          LogFile.Add(llERROR, cErrorNotZeroSubTotalSumAndSubTotalPercent);
          Result:= False;
          Exit;
        end;
        GetRegistratorStatus;
        {if FatalError then begin
          lRaiseError:= False;
          FatalError:= False;
          raise Exception.Create(cFatalErrorOccuredOnPreviousStep);
        end;}
        
        {int CALLBACK  SubTotal(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,BOOL Print,
          BOOL Display, double Percent=0.0, double disc=0.0)
        Входные данные – Print, Display, Percent, disc
        Выходные данные – Подсумма, Налог А, Налог Б, Налог В, Налог Г
        Print -   если true, то регистратор печатает величину подсуммы
                  если false, то регистратор не печатает величину подсуммы
        Display - если true, то на дисплее отображается величина подсуммы
                  если false, то на дисплее не отображается величина подсуммы
        Percent - надбавка (+), скидка (-), выраженная в процентах (-99.00   :   +99.00).
                  Общие суммы по надбавкам и скидкам печатаются в дневном отчете.
        disc – количественная надбавка (+), скидка (-).
        Percent и disc не могут одновременно принимать ненулевые значения.

        Выходные данные –
        Возвращаются в структуре RetData - LPSTR RetItem[0], RetItem[1], RetItem[2], RetItem[3], RetItem[4];
        Подсумма – Подсумма на текущий момент фискального чека (до 10 байт)
        Налог А – Сумма налогов по налоговой группе А (до 10 байт)
        Налог Б - Сумма налогов по налоговой группе Б (до 10 байт)
        Налог В - Сумма налогов по налоговой группе В (до 10 байт)
        Налог Г - Сумма налогов по налоговой группе Г (до 10 байт)
        Налог Д - Сумма налогов по налоговой группе Г (до 10 байт)}
        if Assigned(FOnBeforeFiscalReceiptSubTotal) then
          FOnBeforeFiscalReceiptSubTotal(Self, FatalError, FRetData);
        i:= SubTotal(FHWND, PrinterResults, FPar,
          (doPrintWhileSubTotal in DisplayOption),
          (doDisplayWhileSubTotal in DisplayOption) ,
          FVisit.SubTotalPercent,
          FVisit.SubTotalSum);
        if Assigned(FOnAfterFiscalReceiptSubTotal) then
          FOnAfterFiscalReceiptSubTotal(Self, FatalError, FRetData);
        if (i < 0) or FatalError then begin
          FatalError:= False;
          Result:= False;
          LogException(llERROR, cErrorWhileFiscalReceiptSubTotal, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileFiscalReceiptSubTotal, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.FiscalReceiptTotal: Boolean;
const
  cAlertSkipFiscalReceiptTotal = 'Итог фискального чека пропущен  пропущен.';
  cPrintFiscalReceiptTotal = 'Итог фискального чека.';
  cErrorWhileFiscalReceiptTotal = 'Ошибка при печати итога фискального чека.';
  clDllFuncResultError = 'F - ошибка. -> ';
  clDllFuncResultNegativeSum = 'E	- вычисленная сумма отрицательна. Оплата не совершается.';
  clDllFuncResultPayLessTotal = 'D - сумма оплаты меньше суммы чека (остаток в Сумма).';
  clDllFuncResultTotalLessPay = 'R - сумма оплаты больше суммы чека (остаток в Сумма).';
  clDllFuncResultSumBySomeTaxIsNegative = 'I		- сумма по некоторой налоговой группе отрицательна (текущая подсумма в Сумма).';
var
  i: Integer;
  lRetItem: String;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoFiscalReceiptTotal in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipFiscalReceiptTotal);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintFiscalReceiptTotal);
        {if FatalError then begin
          lRaiseError:= False;
          FatalError:= False;
          raise Exception.Create(cFatalErrorOccuredOnPreviousStep);
        end;}
          {int CALLBACK  Total(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,
            LPSTR Comment,char PaidCode,double Amount)
          Входные данные –
          Comment - Строка, длиной до 25 байтов, содержащая комментарий.
            Можно указать две строки, разделенные кодом 0AH.
          PaidCode - 	 ‘P’:	оплата наличными;
              ‘N’:	оплата в кредит;
              ‘C:	оплата чеком;
              ‘D:	оплата с помощью платежной карты;
          Amount - Сумма, которая вносится клиентом.

          Выходные данные - Возвращаются в структуре RetData - LPSTR RetItem[0], RetItem[1];
          Результат – Один байт (результат выполнения команды):
              = F   - ошибка
              = E		- вычисленная сумма отрицательна. Оплата не совершается
              = D		- сумма оплаты меньше суммы чека (остаток в Сумма)
              = R		- сумма оплаты больше суммы чека (остаток в Сумма)
              = I		- сумма по некоторой налоговой группе отрицательна (текущая подсумма в Сумма)
          Сумма – До 9 цифр со знаком (зависит от Результат)
          С помощью этой функции  выполняется оплата текущего чека, допускается
          несколько таких команд, например для использования различными видами
          оплаты. Не допускается сдача по безналичной форме оплаты.}
        if Assigned(FOnBeforeFiscalReceiptTotal)then
          FOnBeforeFiscalReceiptTotal(Self, FatalError, FRetData);
        GetRegistratorStatus;
        i:= Total(FHWND, PrinterResults, FPar, PChar(FVisit.Comment),
          FVisit.PaymentType, FVisit.Total);
        if Assigned(FOnAfterFiscalReceiptTotal)then
          FOnAfterFiscalReceiptTotal(Self, FatalError, FRetData);
        if (i < 0) or FatalError or (FRetData.RetItem[1] = cDllFuncResultError) then begin
          lRetItem:= PChar(FRetData.RetItem[2]);
          if lRetItem = cDllFuncResultNegativeSum then
            LogFile.Add(llERROR, clDllFuncResultError+ clDllFuncResultNegativeSum);
          if lRetItem = cDllFuncResultPayLessTotal then
            LogFile.Add(llERROR, clDllFuncResultError+ clDllFuncResultPayLessTotal);
          if lRetItem = cDllFuncResultTotalLessPay then
            LogFile.Add(llERROR, clDllFuncResultError+ clDllFuncResultTotalLessPay);
          if lRetItem = cDllFuncResultSumBySomeTaxIsNegative then
            LogFile.Add(llERROR, clDllFuncResultError +
              clDllFuncResultSumBySomeTaxIsNegative);
          FatalError:= False;
          Result:= False;
          LogException(llERROR, cErrorWhileFiscalReceiptTotal, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileFiscalReceiptTotal, e, lRaiseError);
      end;
    end;
  finally
    KeepOpened:= lKeepOpened;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.DeleteArticleByItemNo(AItemNo: integer): Boolean;
const
  cAlertSkipDeleteArticleByItemNo = 'Удаление артикула номер: %d пропущено.';
  cPrintDeleteArticleByItemNo = 'Удаление артикула: %d';
  cErrorWhileDeleteArticleByItemNo = 'Ошибка при удаление артикула: %d';
  cAlertSkipDeleteAllArticle = 'Удаление всех артикулов пропущено.';
  cPrintDeleteAllArticle = 'Удаление всех артикулов.';
  cErrorWhileDeleteAllArticle = 'Ошибка при удаление всех артикулов.';
  cInfoNoProgrammedArticles = 'нет запрограммированных артикулов.';
var
  i, lMaxItemNo: Integer;
  lAlertSkipDeleteArticle, lPrintDeleteArticle, lErrorWhileDeleteArticle: string;
  lRaiseError: Boolean;
  lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= egoDeleteArticleByItemNo in ExceptionGenerateOptions;

  if AItemNo <> 0 then begin
    lAlertSkipDeleteArticle:= Format(cAlertSkipDeleteArticleByItemNo, [AItemNo]);
    lPrintDeleteArticle:= Format(cPrintDeleteArticleByItemNo, [AItemNo]);
    lErrorWhileDeleteArticle:= Format(cErrorWhileDeleteArticleByItemNo, [AItemNo]);
  end
  else begin
    lAlertSkipDeleteArticle:= cAlertSkipDeleteAllArticle;
    lPrintDeleteArticle:= cPrintDeleteAllArticle;
    lErrorWhileDeleteArticle:= cErrorWhileDeleteAllArticle;
  end;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+lAlertSkipDeleteArticle);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        GetCommonArticleInfo(FHWND, PrinterResults, FPar);
        lMaxItemNo:= StrToInt(FRetData.RetItem[3]);
        if lMaxItemNo = 0 then begin
          LogFile.Add(llINFO, cInfoNoProgrammedArticles);
          exit;
        end;
        
        KeepOpened:= True;
        LogFile.Add(llINFO,Format(lPrintDeleteArticle, [AItemNo]));
        {int   CALLBACK DeleteArticle(HWND hwnd,void (CALLBACK *Fn),LPARAM UI,
          int numart, LPSTR psw)
        Входные данные – numart, psw
        Выходные данные – P (команда выполнилась успешно), F(ошибка)
        numart – номер удаляемого артикула (если 0, то удаляются все артикулы,
          не продаваемые ранее).
        psw - Пароль для программирования (оператор 14)
        С помощью этой функции  удаляется указанный артикул (если он не
        продавался ранее с последнего Z-отчета). Если в качестве артикула
        указан 0, то удаляются все запрограммированные артикулы, которые
        не продавались от последнего Z-отчета.}
        if Assigned(FOnBeforeDeleteArticleByItemNo) then
          FOnBeforeDeleteArticleByItemNo(Self, FatalError, FRetData, Result, AItemNo,
            Visit.FVisitItems[AItemNo]);
        GetRegistratorStatus;
        i:= DeleteArticle(FHWND, PrinterResults, FPar, AItemNo,
          PChar(CurrentOperatorPassword));
        if Assigned(FOnAfterDeleteArticleByItemNo) then
          FOnAfterDeleteArticleByItemNo(Self, FatalError, FRetData, Result, AItemNo,
            Visit.FVisitItems[AItemNo]);
        if (i < 0) or FatalError or (FRetData.RetItem[1] = cDllFuncResultError) then begin
          Result:= False;
          LogException(llERROR, lErrorWhileDeleteArticle, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, lErrorWhileDeleteArticle, e, lRaiseError);
      end;
    end;
  finally
    if Result then LogFile.Add(llINFO, cSuccessfully);
    KeepOpened:= lKeepOpened;
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.DeleteAllArticle: Boolean;
var
  lKeepOpened: Boolean;
begin
  lKeepOpened:= KeepOpened;
  try
    Result:= False;
    CallStackDeep:= CallStackDeep+1;
    try
      KeepOpened:= True;
      if Assigned(FOnBeforeDeleteAllArticle) then
        FOnBeforeDeleteAllArticle(Self, FatalError, FRetData);
      Result:= DeleteArticleByItemNo(0);
      if Assigned(FOnAfterDeleteAllArticle) then
        FOnAfterDeleteAllArticle(Self, FatalError, FRetData);
    except on e: Exception do
      raise
    end;
  finally
    KeepOpened:= lKeepOpened;
    CallStackDeep:= CallStackDeep-1;
  end;
end;

function TtDatecsFP3530.CompareArticles(const AFirstArticle, ASecondArticle: TArticle): Boolean;
begin
  Result:= True;
  if AFirstArticle.FCode <> ASecondArticle.FCode then begin
    Result:= False;
    Exit;
  end;
  if abs (AFirstArticle.FPrice - ASecondArticle.FPrice) > 0.00001 then begin
    Result:= False;
    Exit;
  end;
  if AFirstArticle.FName <> ASecondArticle.FName then begin
    Result:= False;
    Exit;
  end;
end;


function TtDatecsFP3530.FullPeriodicalReportByDate(ADateBeg, ADateEnd: TDateTime): Boolean;
const
  cAlertSkipFullPeriodicalReportByDate = 'Печать периодического отчета пропущена.';
  cPrintFullPeriodicalReportByDate = 'Печать периодического отчета.';
  cErrorWhileFullPeriodicalReportByDate = 'Ошибка при печати Печать периодического отчета.';
var
  i: Integer;
  lRaiseError, lKeepOpened: Boolean;
begin
  Result:= True;
  lRaiseError:= True;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipFullPeriodicalReportByDate);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintFullPeriodicalReportByDate);
        GetRegistratorStatus;
        FormatDateTime('DDMMYY', ADateBeg);
        FormatDateTime('DDMMYY', ADateEnd);

        i:= PrintFiscalMemoryByDate(FHWND, PrinterResults, FPar,
          PAnsiChar(FCurrentOperatorPassword),
          PAnsiChar(FormatDateTime('DDMMYY', ADateBeg)),
          PAnsiChar(FormatDateTime('DDMMYY', ADateEnd)));
        {int CALLBACK  PrintFiscalMemoryByDate(HWND hwnd,void (CALLBACK *Fn),
           LPARAM UI, LPSTR psw, LPSTR Start,LPSTR End)
         Входные данные –
           psw - пароль для снятия отчета (оператор 15)
           Start – начальная дата Z-отчета (DDMMYY, например 100500)
           End – конечная дата Z-отчета (DDMMYY)
         С помощью этой функции  печатается информация из фискальной памяти о
         Z–отчетах по датам  (полный периодический отчет).}
        if (i < 0) or FatalError then begin
          Result:= False;
          LogException(llERROR, cErrorWhileFullPeriodicalReportByDate, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileFullPeriodicalReportByDate, e, lRaiseError);
      end;
    end;
  finally
    if Result then LogFile.Add(llINFO, cSuccessfully);
    KeepOpened:= lKeepOpened;
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;
{function TtDatecsFP3530.Report_Z: Boolean;
const
  cAlertSkipZReport = 'Печать Х - отчета пропущена.';
  cPrintZReport = 'Печать Х - отчета.';
  cErrorWhileZReport = 'Ошибка при печати Х - отчета.';
var
  i: Integer;
  lRaiseError: Boolean;
begin
  Result:= True;
  lRaiseError:= in ExceptionGenerateOptions;
  if not Enabled then begin
     LogFile.Add(llINFO, cAlertEnabledModeON+cAlertSkipZReport);
     Exit;
  end;
  lKeepOpened:= KeepOpened;
  try
    CallStackDeep:= CallStackDeep+1;
    try
      if Open then begin
        KeepOpened:= True;
        LogFile.Add(llINFO, cPrintZReport);
        GetRegistratorStatus;
        if (i < 0) or FatalError then begin
          Result:= False;
          LogException(llERROR, cErrorWhileZReport, nil, lRaiseError);
        end;
      end
      else begin
        Result:= False;
      end;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileZReport, e, lRaiseError);
      end;
    end;
  finally
    if Result then LogFile.Add(llINFO, cSuccessfully);
    KeepOpened:= lKeepOpened;
    Close;
    CallStackDeep:= CallStackDeep-1;
  end;
end;
}



end.


