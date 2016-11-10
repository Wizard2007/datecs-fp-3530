unit uDatecsFP3530_UtilCommonFunction;

interface
  uses SysUtils, uDatecsFP3530CommonTypes;
  {Функция для сравнения двух объектов типа TItem}
  function CompareItems(AFirstItem, ASecondItem: TItem): Integer;overload;
  function CompareItems(AFirstItem, ASecondItem: TArticle): Integer;overload;
  function CompareItems(AFirstItem:TItem; ASecondItem: TArticle): Integer;overload;
  function CompareItems(AFirstItem:TArticle; ASecondItem: TItem): Integer;overload;
  {Функция для копированя двух объектов типа TItem}
  function CopyItemFromTo(const AFirstItem: Titem; var ASecondItem: TItem): Boolean;
  function CopyItemToArticle(const AFirstItem: Titem; var ASecondItem: TArticle): Boolean;
implementation

function CompareItems(AFirstItem, ASecondItem: TItem): Integer;
begin
  {0 - если два объекта равны, -1 в противном случае}
  Result:= -1;
  if (abs(AFirstItem.FPrice - ASecondItem.FPrice) < 0.00001)
    and (UpperCase(AFirstItem.FName) = UpperCase(ASecondItem.FName)) then
    Result:= 0;
end;

function CompareItems(AFirstItem, ASecondItem: TArticle): Integer;
begin
  {0 - если два объекта равны, -1 в противном случае}
  Result:= -1;
  if (abs(AFirstItem.FPrice - ASecondItem.FPrice) < 0.00001)
    and (UpperCase(AFirstItem.FName) = UpperCase(ASecondItem.FName)) then
    Result:= 0;
end;

function CompareItems(AFirstItem: TItem; ASecondItem: TArticle): Integer;
begin
  {0 - если два объекта равны, -1 в противном случае}
  Result:= -1;
  if (abs(AFirstItem.FPrice - ASecondItem.FPrice) < 0.00001)
    and (UpperCase(AFirstItem.FName) = UpperCase(ASecondItem.FName)) then
    Result:= 0;
end;

function CompareItems(AFirstItem: TArticle; ASecondItem: TItem): Integer;
begin
  {0 - если два объекта равны, -1 в противном случае}
  Result:= -1;
  if (abs(AFirstItem.FPrice - ASecondItem.FPrice) < 0.00001)
    and (UpperCase(AFirstItem.FName) = UpperCase(ASecondItem.FName)) then
    Result:= 0;
end;

function CopyItemFromTo(const AFirstItem: Titem; var ASecondItem: TItem): Boolean;
begin
  try
    Result:= True;
    ASecondItem.FInventoryGroup:=  AFirstItem.FInventoryGroup;
    ASecondItem.FGroup:= AFirstItem.FGroup;
    ASecondItem.FCode:= AFirstItem.FCode;
    ASecondItem.FPrice:= AFirstItem.FPrice;
    ASecondItem.FDiscountSum:= AFirstItem.FDiscountSum;
    ASecondItem.FDiscountPercent:= AFirstItem.FDiscountPercent;
    ASecondItem.FName:= AFirstItem.FName;
    ASecondItem.FCode:= AFirstItem.FCode;
    ASecondItem.FData:= AFirstItem.FData;
    ASecondItem.FQuantity:= AFirstItem.FQuantity;
  except on e: Exception do
    begin
      Result:= False;
    end;
  end;
end;

function CopyItemToArticle(const AFirstItem: Titem; var ASecondItem: TArticle): Boolean;
begin
  try
    Result:= True;
    ASecondItem.FCode:= AFirstItem.FCode;
    ASecondItem.FPrice:= AFirstItem.FPrice;
    ASecondItem.FName:= AFirstItem.FName;
    ASecondItem.FCode:= AFirstItem.FCode;
  except on e: Exception do
    begin
      Result:= False;
    end;
  end;
end;



end.
