# ruby-library ruby  garage

The component is designed for simple addition of the ability to work with fiscal register in you applications.

1. Installation

1.1. Components -> Install Packages ... Components -> Install Packages ... -> Add -> Add 
1.2. Select tDatecsFP3530.bpl, click Open Select tDatecsFP3530.bpl, click Open 
1.3. OK 

2.1. File -> Open Project ... File -> Open Project ... 
2.2. Select tDatecsFP3530.dpk, click Open Select tDatecsFP3530.dpk, click Open 
2.3. Compile tDatecsFP3530.dpk Compile tDatecsFP3530.dpk 
2.4. Install tDatecsFP3530.dpk Install tDatecsFP3530.dpk 
2.5. OK 
 
This component is class wrapper for functions implemented in fp.dll . For more information use official info page http://service.systema.com.ua/index.php?id=rrovoprosotvet_fp3530t
In component wrapped next functions 
function SetHeadeFooters: Boolean;
function ReceiptReset: Boolean;
function ProgrammingVisitItems: Boolean;
function SaleArticles(ASign: Boolean): Boolean;
function SaleItem(AItem: TItem; AIndex: Integer; ASign: Boolean): Boolean;
function PrintReceipt(ASign: Boolean): Integer;
function GetLastReceiptNo: Integer;
function FiscalReceiptOpen(ASign: Boolean): Boolean;
function FiscalReceiptClose(ASign: Boolean): Boolean;
function FiscalReceiptSubTotal: Boolean;
function FiscalReceiptTotal: Boolean;
function Connect: Boolean;
function DisConnect: Boolean;
function DeleteArticleByItemNo(AItemNo: integer): Boolean;
function DeleteAllArticle: Boolean;
function Open: Boolean;
function Close: Boolean;
procedure ClrScr;
function Report_X: Boolean;
function Report_Z: Boolean;
function GetRegistratorSums(): Boolean;
function ServiceInOut(Amount: double; var AReceiptNo: Integer; AComPort, AFRSpeed: Integer): Boolean;
function PrintNonfiscalTextOnVisit(AString: String): Boolean;
function PrintFiscalTextOnVisit(AString: String): Boolean;
