-- FUNKCJE SKALARNE
---- Funkcje skalarne(przykłady):
-- LEFT - pobiera znaki/ cyfry od lewej strony
-- ISNULL - ktora przekształca dane które są nullem, na dane które dalej są nullem,
  -- ale mają inną nazwę + dodatkowo można sobie we własny sposób nazwać kolumnę
  -- SELECT Name, Color, ISNULL(Color, 'no color') AS SuperColor FROM Production.Product --tu mamy już aliasowanie,
  -- czyli wyświetlamy kolumnę Name i Color, gdzie kolumna Color wszystkie wartości NULL wyświetla jako: no color +
  -- wtedy w tej nowej kolumnie gdzie zamiast NULL jest 'no color' ta nowa dodatkowa kolumna zmienia nazwę na SuperColor
  -- + oczywiście są wyświetlane wszystkie inne kolory
-- SUBSTRING - wyciąga wycinek ciągu znaków, np. mamy ciąg ABCD, to za pomocą tej funkcji wyciągniemy np. wycinek BC
-- YEAR - ona wyciąga tylko rok z kolumn, bez miesięcy/dni
-- Transact-SQL !! Wprowadza dużą ilość różnych funkcji których nie damy rady omówić w całości -> i nikt by tego nie zapamiętał
-- Ważną informacją jest to że funkcję występujące w SQLServer nie muszą występować w innych RMDBS!!!!!
   -- -> T-SQL to rozwinięcie standardowego języka SQL

USE AdventureWorks2014

-- wyciągnięcie roku z daty
SELECT YEAR(SellStartDate) AS SellStart, SellStartDate, ProductID, Name
FROM Production.Product
ORDER BY SellStart;
--1. jak widać żeby tylko rok wyciągnąć, wpisujemy funkcję 'YEAR' + w nawiasie podajemy z jakiej kolumny
-- ten rok ma być wyciągnięty + dalismy aliasowanie za pomocą 'AS', gdzie ta kolumna została nazwana jako
-- 'SellStart'
--2. Potem zrobiliśmy na samym koncu sortowanie 'Order by' po nowej kolumnie 'SellStart', która wyciąga tylko rok
--3. Obok też podana ta kolumna 'SellStartDate', żeby było widać, że zawiera ona rok-miesiąc-dzien


-- działania na dacie + GETDATE()
SELECT YEAR(SellStartDate) AS SellStartYear,  -- tu wyciągamy rok z kolumny SellStartDate
       DATENAME(mm,SellStartDate) AS SellStartMonth, -- tu wyciągamy miesiąc, do kolumny SellStartMonth
       DAY(SellStartDate) AS SellStartDay, -- tu wyciągamy numer dnia miesiąca, np.30
       DATENAME(dw, SellStartDate) AS SellStartWeekday, -- tu wyciągamy nazwę dnia, np.  Wednesday
       DATEDIFF(yy,SellStartDate, GETDATE()) AS YearsSold, -- tu mamy dwie funkcje 'DateDiff', która
       -- wyciąga różnice lat pomiędzy obecną datą (obecną datę dostajemy za pomocą funkcji 'GetDate'), a datą
       -- podaną w kolumnie SellStartDate, czyli sprzedaży. I dostajemy to w latach, np. 15.
       -- i w tym przypadku używamy funkcję(GETDATE), w funkcji(DATEDIFF)
       SellStartDate,
       ProductID,
       Name
FROM Production.Product
ORDER BY SellStartYear;

-- Funkcje w funkcjach
SELECT UPPER(Name) AS ProductName, -- Funkcja 'UPPER' przekształca wszystkie litery w kolumnie 'Name' na duże +
                                   -- + zaliasowała ją na nową nazwę, czyli 'ProductName'
       ProductNumber, -- tu niezależnie/normalnie wyświetlamy kolumnę 'ProductNumber'
       Weight, -- tu niezależnie/normalnie wyświetlamy kolumnę 'Weight'
       ROUND(Weight, 0) AS ApproxWeight, -- a tu wartości w kolumnie 'Weight' zaokrąglamy za pomocą funkcji 'ROUND',
                                         -- do pełnej liczby, bo mamy '0', jakby było '1' byłoby zaokrąglenie do 1
                                         -- liczby po przecinku. Czyli w naszym przypadku po zaokrągrleniu '0',
                                         -- dostajemy liczbę bez przecinka, np.2.00 + aliasujemy ją jako
                                         -- 'ApproxWeight'
                                         -- ! WAŻNE: w SQL po liczbie zawsze dajemy '.'
       LEFT(ProductNumber, 2) AS ProductType, -- tu stosując funkcję 'LEFT', pobieramy znaki z lewej strony,
                                        -- w naszym przypadku pobieramy dwa pierwsze znaki + kolumnę aliasujemy
                                        -- jako ProductType
       SUBSTRING(ProductNumber,CHARINDEX('-', ProductNumber) + 1, 4) AS ModelCode -- tu robimy za pomocą funkcji
       -- 'SUBSTRING' z kolumny 'ProductNumber' wyciągninęcie jakichś znaków i umieszczenie ich w innej kolumnie -
       -- w kolumnie 'ModelCode'. ProductNumber wygląda następująco: FR-T98Y-54, czyli za pomocą funkji w funkcji -
       -- u nas tą funkcją zagnieżdżoną jest funkcja 'CharIndex', która identyfikuje pierwszy dash= '-',
       -- który jest znakiem numer 3, więc żeby zacząć wyciąganie od znaku 4, nie zawrzeć dasha,
       -- musimy dodać 1, i po przecinku podajemy
       -- ile znaków wyciągamy, czyli podaliśmy 4, więc wyciągamy 4 znaki + wrzucamy te 4 znaki w nową zaaliaso-
       -- waną kolumnę ''ModelCode'
FROM Production.Product; -- dane bierzemy ze schematu Production i z tabeli Product

---- Funkcje agregujące (przykłady):
-- sum, - sumuje jakieś założone wartości - np. mamy kolumne z cenami, to zsumuje nam te ceny
-- count, - sumuje nam np. wszystkie wiersze w tabeli
-- average, - wyciąga średnią
-- minimum, or maximum. - wyciąga minimalną lub maksymalną wartość


SELECT COUNT(*) AS Products, -- count + (*), liczy nam ile mamy wszystkich = '*' wierszów w kolumnie Products
       COUNT(DISTINCT ProductSubcategoryID) AS SubCategories, -- tu nam Count liczy ile jest unikalnych kategorii
       -- w kolumnie 'ProductSubcategoryID' i wrzuca nam tą daną do zaliasowanej kolumny 'SubCategories'
       AVG(ListPrice) AS AveragePrice -- i tu za pomocą funkcji AVG, wyciągamy średnią cenę, z cen zawartych
        -- w kolumnie ListPrice, które to zostały przerzucone do nowej kolumny AveragePrice
FROM Production.Product; -- dane ze schematu Production i tabeli Product



SELECT COUNT(DISTINCT p.ProductID) AS BikeModels, AVG(p.ListPrice) AS AveragePrice --tu nam liczy (Count) ile jest
-- unikalnych (Distinct) produktów, które zawierają w sobie słowo Bikes ('%Bikes' - na końcu po prawej stronie jest
-- Bikes + inne cyfry/znaki/litery po lewej,przed Bikes)zawarte w kolumnie 'ProductID',zaliasowane jako'BikeModels'
-- + dodatkowo liczy średnią cenę z kolumny ListPrice, która została zaliasowana jako 'AveragePrice'
FROM Production.Product AS p -- te dane pochodzę ze shematu Production i tabeli Product, ktore to zostało (ten
    -- schemat i tabela nazwane jako 'p') i użyte w dalszym joinowaniu
         JOIN Production.ProductSubcategory AS c -- a tu jak widzimy najpierw nazwę schematu Production i tabeli
         --ProductSubcategory zamieniamy(aliasujemy) na 'c', które to ('p' i 'c') następnie joinujemy po kolumnie
         -- 'ProductSubcategoryID' za pomocą operatora 'ON'
              ON p.ProductSubcategoryID = c.ProductSubcategoryID
WHERE c.Name LIKE '%Bikes'; -- gdzie struktura 'c' w kolumnie 'Name' zawiera po brawej słowo 'Bikes'



------ Grupowanie danych po wykonaniu funkcji agregujących  -- 'GROUP BY' --
-- pozwala zgrupować dane po kolumnach
-- występuje wraz z funkcją agregującą, np. 'Count' lub 'Sum' lub 'Average' lub 'Min' lub 'Max'
-- chcąc filtrować dane po zgrupowaniu, należy zamiast 'Where', używać 'Having'
-- Kolumny, po których chcemy wykonać grupowanie muszą znajdować się po słowie 'Select'

SELECT StoreID, COUNT(CustomerID) AS Customers --wybieramy kolumne StoreID + zliczamy ilość klientów w kolumnie
-- CustomerID którzy są przypisani do danego sklepu + tą kolumnę CustomersID aliasujemy na Customers
FROM Sales.Customer
GROUP BY StoreID -- czyli grupujemy po StoreID
ORDER BY Customers desc; -- filtrowanie uzależniamy od danych w kolumnie Customers, które to są sortowane
-- poprzez ORDER BY malejąco (bo desc)


--a teraz połączenie grupowania z joinem ???-tu jak przerobię joinowanie, powinno mi się wyjaśnić!!
SELECT sp.businessentityid, SUM(oh.SubTotal) AS SalesRevenue -- wybierz kolumnę businessentityid ze schematu
-- sales i tabeli salesperson (czyli: sales.salesperson sp) + zsumuj dane z kolumny SubTotal, które to pochodzą
-- ze schematu Sales i tabeli SalesOrderHeader (Sales.SalesOrderHeader oh)
FROM Sales.Customer c -- startując ze źródła: schemat Sales i tabela Customer zrób następujące łączenia
         JOIN sales.store s on s.businessentityid = c.storeid --schemat sales i tabelę store nazwij jako s +
    -- następnie już ten skrót s ma kolumnę businessentityid (s.businessentity), który to finalnie będzie
    -- z joinowany ze schematem Sales i tabelą Customer, nazwanymi jako c, z kolumną storeid (c.storeid)
         JOIN sales.salesperson sp on s.salespersonid = sp.businessentityid
         JOIN Sales.SalesOrderHeader oh ON c.CustomerID = oh.CustomerID
GROUP BY sp.businessentityid -- wiadomo, że żeby grupowanie mogło zajść, musi się ono odbyć po poleceniu SELECT
-- + funkcji agregującej (u nas funkcją agregującą jest funkcja SUM)
ORDER BY SalesRevenue DESC;


-- TO nie zadziała
-- Spodziewamy się wyniku zwracającgo handlowców z ponad 100 klientami
-- Dlaczego to nie działa??!
SELECT sp.businessentityid, count(c.customerid) AS SalesRevenue
FROM Sales.Customer c
         JOIN sales.store s on s.businessentityid = c.storeid
         JOIN sales.salesperson sp on s.salespersonid = sp.businessentityid
         JOIN Sales.SalesOrderHeader oh ON c.CustomerID = oh.CustomerID
GROUP BY sp.businessentityid
WHERE COUNT(c.CustomerID) > 100 -- to nie zadziała bo zamiast Where musimy mieć Having. Nawet jak Where damy tak
-- jak w poniższym przypdaku przed Group By, to dalej nie zadziała
ORDER BY SalesRevenue DESC;

-- WHERE musi znaleźć się przed słowem kluczowym GROUP BY (Dalej nie działa)
SELECT sp.businessentityid, count(c.customerid) AS SalesRevenue
FROM Sales.Customer c
         JOIN sales.store s on s.businessentityid = c.storeid
         JOIN sales.salesperson sp on s.salespersonid = sp.businessentityid
         JOIN Sales.SalesOrderHeader oh ON c.CustomerID = oh.CustomerID
WHERE COUNT(c.CustomerID) > 100
GROUP BY sp.businessentityid
ORDER BY SalesRevenue DESC;


-- W jaki sposób filtorwać wyniki funkcji agregujących?
-- HAVING!! <- to pytanie pojawia się często na rozmowach kwalifikacyjnych
-- Ale w Having nie możemy użyć naszego aliasu

SELECT sp.businessentityid, count(c.customerid) AS Customers
FROM Sales.Customer c
         JOIN sales.store s on s.businessentityid = c.storeid
         JOIN sales.salesperson sp on s.salespersonid = sp.businessentityid
         JOIN Sales.SalesOrderHeader oh ON c.CustomerID = oh.CustomerID
GROUP BY sp.businessentityid
HAVING count(c.customerid) > 100 -- having = daj nam wyniki, które po zliczeniu za pomocą funkcji COUNT, dadzą
-- nam wyniki większe od 100
ORDER BY Customers DESC;


-- Oczywiście w jednym zapytaniu możemy połączyć oba WHERE i HAVING
-- chcemy wziac tylko pod uwagę klientów sklepów z rowerami
SELECT sp.businessentityid, count(c.customerid) AS Customers
FROM Sales.Customer c
         JOIN sales.store s on s.businessentityid = c.storeid
         JOIN sales.salesperson sp on s.salespersonid = sp.businessentityid
         JOIN Sales.SalesOrderHeader oh ON c.CustomerID = oh.CustomerID
WHERE s.name like '%Bike%'
GROUP BY sp.businessentityid
HAVING count(c.customerid) > 100
ORDER BY Customers DESC;




