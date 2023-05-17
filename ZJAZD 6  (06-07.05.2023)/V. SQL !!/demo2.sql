--- INNER join = łączenie na bazie wspólnych części -----test
-- łączenie tych danych, które zarówno występują w tabeli 1 i tabeli 2, czyli na bazie wspólnych cześci te tabele
-- łączymy (only the things that match on the left and the right). Poniżej przykład łączenia tabel:
-- Select * (wybierz nam wszystko - to się wiąże z tym, że wybierze na wszystkie kolumny z tabeli 1 i tabeli2, i je
-- pokaże(np. tab.1=5 kolumn, tab.2=7, to pokaże nam 12 kolumn) + będzie próbował połaczyć -
-- tam gdzie będzie wspólny mianownik, to będą wyniki, tam gdzie nie będzie wspólnej
-- części będzie null. Jeśli chcę żeby były tylko konkretne kolumny, to nie mogę dać ALL=*, tylko wylistować
-- konkretne kolumny do zjoinowania. To samo się tyczy LEFT, RIGHT i FULL JOINów!!))
-- From Table_1 (z tabeli 1 - - wiadomo, że zarówno przy tabeli 1 i 2 trzeba  podać: schemat.tabela 1)
-- INNER JOIN Table_2 (tu jaki rodzaj łączenia tabel=INNER JOIN+która to tabela ma być połączona(tabela 2)zTabelą 1
-- ON Table_1.KEY = Table_2.KEY (ON = łączenie, tabeli 1, na bazie jakiegoś wspólnego klucza(tu KEY), który piszemy
-- po kropce, za nazwą tabeli  --> i teraz dajemy
-- znak '=' i wpisuje nazwę drugiej tabeli wraz z kluczem, która ma być połączona z pierwszą tabelą,
-- bo to jest przyrównanie tych tabel, żeby się one w konsekwencji połączyły.

-- Może być więcej niż jeden Join tabeli

-- Odnośnie kluczy, to mamy PK = Primary Key (klucz glówny) i FK = Foreign Key. Ważne jest też to, że te Klucze
-- muszą mieć wartości niepowtarzalne, np. nr pesel, żeby nie było sytuacji, że po połączeniu dwa różne wiersze się
-- połączą w jeden, bo miały te same dane, np. imię - i w sumie nie wiadomo, o którego np. Pawła chodzi.
-- I teraz jak łączymy 2 tabele, to klucz pierwszej tabeli która jest punktem odniesienia, to PK,
-- zaś tabela2, która jest dołączana, jest dołączana
-- na bazie jej FK, który jest u niej (ta nazwa kolumny, która jest PK w tabeli 1), ale nie jest on jej PK,
-- tylko jest ta kolumna w niej, ale ta kolumna jest PK dla tabeli 1.
-- Ważne - Key = to nazwa kolumny, nie wiersza!

-- Generalnie jest dobrze aliasować tabelę, żeby potem były po pierwsze łatwo rozpoznawalne tabele + nie trzeba było
-- długich nazw przepisywać. Mogą to być nawet aliasy składające się z pary liter, ktore są początkami elementów
-- nazwy tabeli

--- LEFT Outer Join = everything on the left table  + anything on the right that matches based on common KEY
-- Tu dostajemy wszystko co jest po lewej stronie(Tabela 1),łącznie z częścią wspólną tego co jest po prawej(Tab 2)
-- Ważna uwaga, po złączeniu tabel, jeśli np. jakiś Klient nie ma żadnego zamówienia, to do połączenia tabel dojdzie
-- po wspólnym Key-u (nazwie kolumny), ale wtedy po prostu po połączeniu tych tabel wyświetli się 'null', co
-- nie jest błędem.
-- Poniżej przykład Lewego Joina:
-- Select *
-- From Table_1  (to jest nasza lewa tabela, użyta jako pierwsza, poprzez zastosowanie 'From')
   -- - wiadomo, że zarówno przy tabeli 1 i 2 trzeba  podać: schemat.tabela 1
-- Left Join Table_2 (to jest prawa tabela, która będzie dołączana do lewej) -- nie trzeba pisać OUTER,
   -- wystarczy że wpiszemy Left Join lub Right Join
-- ON Table_1.KEY = Table_2.KEY
  -- Co jest ważne, to na schemacie(diagramie) Bazy Danych nie zobaczę, która tabela jest tabelą lewą, a która prawą,
  -- zobaczę po prostu powiązania kluczy między nimi.
  -- I teraz sam sobie decyduję, która tabela będzie tą główną(przy left join = lewa Tabela).
  -- Generalnie żeby dwie tabele ze sobą połączyć, muszą mieć one wspólne keys, gdzie w jednej tabeli
  -- ten wspólny key będzie jako główny klucz = PK, zaś w drugiej ta kolumna będzie występować, ale nie będzie
  -- głównym kluczem, bo ona będzie miała inny PK, a będzie FK, a dlatego FK, bo w innej tabeli jest PK,
  -- czyli w tej tabeli jest kluczem obcym, zapożyczonym z innej tabeli.
  -- I żeby było jasne, nawet jak już zrobię to joinowanie (np.Left), to na schemacie(diagramie) nie zobaczę,
  -- że te tabele są połączone. To jest całkiem niezależny temat - ja zobaczę takie łączenie, jak zaciągnę
  -- taką połączoną tabelę, z bazy danych na sówj komputer. Natomiast na schemacie (diagramie) ja widzę jakie są
  -- tabele, jakie mają kolumny,jakie są w nich PK, a jakie FK,
  -- i które tabele za pomocą kluczy PK i FK są ze sobą powiązane - i na tą bazę danych
  -- moje Joinowanie nie ma żadnego wpływu - to jest tylko na moje wewnętrzne potrzeby.

  -- ! A wiadomo, że jak są ze sobą za pomocą PK i FK powiązane te tabele (mają wspólną relację),
  -- to mogę je zjoinować - bo żeby tabele zjoinować, jasna sprawa jest, że musi być jakaś część wspólna!


--- RIGHT Outer Join = everything on the right table  + anything on the left that matches based on common KEY
-- Tu dostajemy wszystko co jest po prawej stronie (Tabela 1), łącznie z częścią wspólną tego co jest
-- po lewej stronie(Tabela 2).
-- Przykład kodu:
-- Select *
-- FROM Table_1 (z tabeli 1 - - wiadomo, że zarówno przy tabeli 1 i 2 trzeba  podać: schemat.tabela 1 / 2)
-- Right JOIN Table_2
-- ON Table_1.KEY = Table_2.KEY
  -- Right Joiny się dużo rzadziej stosuje niż Left Joiny.


--- FULL Outer Join = everything on the left table  + everything on the right table
-- Tu dostajemy wszystko co jest po prawej stronie (Tabela 1), i po stronie lewej (Tabela 2). Czyli łączymy wszystko
-- jak leci. Jeśli jakieś kolumny nawet będą te same, to i tak się dodają do tej tabeli, po prostu będziemy mieli
-- powtórki kolumn.  Np. łączymy table 1(ma 5 kolumn) z tabelą 2(7 kolumn), to jakby nie było, dostaniemy 12 kolumn.
-- Przykład kodu:
-- Select *
-- FROM Table_1 (z tabeli 1 - - wiadomo, że zarówno przy tabeli 1 i 2 trzeba  podać: schemat.tabela 1 / 2)
-- Outer JOIN Table_2 (jak damy samo Outer, to wiadomo, że jest to Full Joining)
-- ON Table_1.KEY = Table_2.KEY

--- SUBQUERIES - czyli używanie zagnieżdżonych odwołań - mowa o różnych funkcjach w funkcji + że w jednym Query
-- będziemy wyciągać i ewentualnie sortować/grupować jakieś dane z różnych tabel (np. tabeli 1 i tabeli 2).
-- jest to wydajne, jeśli chcemy wyciągnąć jakieś konkretne ciągi..
-- Przykład kodu poniżej:
-- Select column_name (tu wybieramy konkretną kolumne/lub parę kolumn, którą chcemy wyswietlić jako pierwszą)
--   From table_name (z jakiej tabeli - wiadomo, że trzeba  podać: schemat.tabela)
-- Where value IN (Select column_name (gdzie kolumna 'Value' pochodzi z tabeli table_name, gdzie są spełnione
--                                     następujące warunki: xyz)
--                  FROM table_name
--                 Where condition)

-- przykład wykorzystania Inner Join
USE AdventureWorks2014


-- przykład wykorzystania Inner Join
-- Produkt -> SubKategoria -> Kategoria
SELECT Production.Product.name         As ProductName, -- tu jak widać korzystamy(Selectujemy) z 3 różnych tabel:
-- product (z tej tabeli wyciągamy nazwę PRODUKTU),productsubcategory (z tej tabeli wyciągamy nazwę podkategorii)
-- oraz ProductCategory(z tej tabeli wyciągamy nazwę kategorii) --> i z których te dane ściągamy z kolumn 'Name'.
-- Z tym, że te dane kryjące się w kolumnie Name, są w każdej tabeli różne - tak jak opisałem powyżej.
-- Dodatkowo widać, że kolumnę 'name' z tabeli product, zaliasowaliśmy na 'ProductName', zaś kolumnę 'name' w tabeli
-- productsubcategory zostawiliśmy taką samą jak oryginalnie oraz w tabeli ProductCategory kolumnę 'name'
-- zaliasowaliśmy na 'CategoryName'. Gdybyśmy ich nie zaliasowali, dostalibyśmy z defaultu: nazwakolumny.name, czyli:
-- 1 kolumna:Product.name, 2 kolumna:Productsubcategory.name, 3 kolumna:ProductCategory.name --> jak widać nazwy
-- tych kolumn byłyby bardzo długie, więc dlatego je aliasujemy, żeby tabelę uprościć, a kolumny nazwać tak jak my
-- chcemy.
       Production.Productsubcategory.name,
       Production.ProductCategory.name AS CategoryName
FROM production.Product -- tabela Product jest tabelą wyjściową i do niej będziemy łączyć kolejne tabele
    -- jak wiemy można zrobić więcej niż jednego joina, w jednym całośiowym Query, żeby połączyć więcej niż
    -- jedną tabelę ze sobą
         INNER JOIN Production.Productsubcategory -- tu joinujemy tabelę Productsubcategory z tabelą Product. Ale
             -- żeby joinowanie zrobić, musimy to zrobić po tym samym kluczu. Więc teraz rozwijamy sobie
             -- schemat folderowy tabeli 'Product' i 'Productsbcategory' albo diagram (np. w QlikSense),gdzie widać
             -- jakie klucze są dostępne i po jakich można zrobić łączenie tabel
             -- za pomocą operatora ON robimy łączenie tabel
                    ON Production.Productsubcategory.Productcategoryid = Production.Product.Productsubcategoryid
    -- teraz wpierw sobie whcodzimy do kolumn tabeli Product i tam patrzymy, po której kolumnie z tabeli
    -- Productsubcategory, jesteśmy w stanie połączyć się z tabelą Product - i jest to FK 'Productsubcategoryid'
    -- widoczny w liście kolumn tabeli Product, jako FK (niebieski kluczyk), gdzie on oczywiście jest PK w tabeli
    -- ProductSubcategory. Czyli dajemy:
    -- Production(schemat).Productsubcategory(tabela, którą łączymy z tabelą Product).Productcategoryid(klucz obcy
    -- w tabeli Productsubcategory, który jest kluczem głównym w tabeli Product i jest łącznikiem z tabelą
    -- Productsubcategory),
    -- teraz dajemy znak '=' po którym pokazujemy kolejną tabelę i kolumnę, po których się łączymy,
    -- także mamy: Production(schema).Product(tabela główna, która zaczyna łączenie).Productsubcategoryid(jak sobie
    -- rozwiniemy drzewko kolumn tabeli Product, to zobaczymy tam FK, który jest PK dla tabeli Productsubcategory
    -- czyli Productsubcategoryid i po którym tabela product będzie zaś w drugą strone - w stronę tabeli
    -- Productsubcategory się łączyć.

    --teraz robimy drugi INNER JOIN, polegający na tym ,że już do powyższego połączenia tabel dołączamy kolejne
    -- połączenie, które da nam w sumie te trzy wartości kolumn 'name' z trzech różnych tabel.
    -- Zaś tutaj tabelą startową, do której jest dołączana kolejna tabela jest tabela Productsubcategory, która
    -- po jakmiś kluczu będzie się łączyć z tabelą ProductCategory, z której to też wyciągniemy dane jej kolumnyName.
    -- *Ale ważna uwaga - po powyższym połączeniu mamy połączenie i zsumowanie dwóch kolumn tabeli Product + tabeli
    -- ProductSubCategory, a teraz z racji, że nie ma jak połączyć ze sobą tabeli Product i ProductCategory(nie mają
    -- wspólnego klucza), robimy to za pomocą tabeli ProductSubcategory, która łączy się z tabelą ProductCategory,
    -- ale wiadomo, że po tym połączeniu tych dwóch tabel, ta dołączana do Product, tabela ProductSubCategory, będzie
    -- miała już dwie kolumny (swoją i właśnie poniżej dołączoną od tabeli ProductCategory).
    -- Czyli sumarycznie dostaniemy wszystko o co nam chodziło!
         INNER JOIN Production.ProductCategory
    -- czyli wchodzimy sobie do drzewka kolumn tabeli Productsubcategory i szukamy klucza, po którym się połączymy
    -- z tabelą ProductCategory. I tu mamy klucz 'ProductCategoryID'(oczywiście kluczyk niebieski), który jak łatwo
    -- sprawdzę jest PK dla tabeli ProductCategory. Więc po nim robię łączenie tych dwoch tabel:
    -- 'ON' operator łączenia tabel --> Production(schemat).Productsubcategory(tabela która się łączy z tabelą
    -- ProductCategory).productcategoryid (klucz obcy=FK, widoczny w kolumnach tabeli Productsubcategory, który
    -- wiadomo jednocześnie jest PK tabeli Product Category) --> '=' znak porównania tabel, które się łączą -->
    -- --> production(schemat).ProductCategory(tabela, która łączy się z tabelą PruductSubcategory, po jej PK,
    -- czuli ProductCategoryID).productcategoryid(PK tabeli ProductCategory, który jednocześnie jest FK dla tabeli
    -- ProductSubCategory i dzięki temu wspólnemu kluczowi jest możliwe połączenie tych dwóch tabel)
                    ON Production.Productsubcategory.productcategoryid = production.ProductCategory.productcategoryid;




-- Modyfikujemy zapytanie i usuwany z niego słowo kluczowe INNER
-- Wynik będzie taki sam ponieważ Inner Join jest domyślym łączeniem tabel w MsSql Server,
-- czyli jak wpiszemy sam join, bez inner, left, right, domyślnie będzie użyty INNER JOIN.
SELECT Production.product.name         As ProductName,
       production.productsubcategory.name,
       production.ProductCategory.name AS CategoryName
FROM production.Product
         JOIN production.productsubcategory
              on production.productsubcategory.productcategoryid = Production.product.productsubcategoryid
         JOIN production.ProductCategory
              ON production.productsubcategory.productcategoryid = production.ProductCategory.productcategoryid;


-- Zastosujemy Aliasy dla czytelności
-- Przy łączeniu tabel szczególnie ważne jest używanie Aliasów - ułatwiają one czytelność
-- Przy wielu łączonych tabelach na prawdę można się pogubić.
-- Tutaj przykład aliasowania całych tabel (nie trzeba podawać słowa kluczowego as)
SELECT p.name As ProductName, pc.name As SubCategoryName, c.name AS CategoryName
-- jak widać aliasowanie polega na tym, że poprzez 'p' zaliasowaliśmy 'Production(schema).Product(table)' -
-- aliasowanie tej tabeli nastąpiło w linii z FROM.
-- --> 'pc' to alias dla production(schemat).productsubcategory(table) - aliasowanie tej tabeli nastąpiło
-- w linii z pierwszym Joinem
-- --> 'c' jest aliasem dla  dla Production(schema).ProductCategory(table) zrealizowanym w drugim Joinie.
-- Dodatkowo widzimy, że mamy samo słowo JOIN, czyli jest to INNER JOIN - tłumaczenie powyżej
-- w Selectach powyżej już wpisujemy zaliasowane nazwy schematów i tabel, tylko wrzucamy kolumny oryginalnie,
-- ktore również jak widać powyżej zostały zaliasowane.
-- Jak widać taki kod zamiast 8 linii zajął 4 linie - czyli jest szybszy, co nie znaczy, że np. dla mnie
-- czytelniejszy.. ;--)
FROM production.Product p
         JOIN production.productsubcategory pc on pc.productcategoryid = p.productsubcategoryid
         JOIN production.ProductCategory c ON pc.productcategoryid = c.productcategoryid;

-- WHERE i ORDER by normalnie działają na złączeniach
SELECT p.name As ProductName, pc.name As SubCategoryName, c.name AS CategoryName
FROM production.Product p
         JOIN production.productsubcategory pc on pc.productcategoryid = p.productsubcategoryid
         JOIN production.ProductCategory c ON pc.productcategoryid = c.productcategoryid
WHERE c.name like '%Clo%'
ORDER BY SubCategoryName desc, ProductName;



-- Outer joins

-- Wyświetlmy liczbę klientów - 19820
Select count(c.customerid)
from Sales.Customer AS c;

-- Wyniki zawierają dane dla każdego klienta. Jeśli klient złożył zamówienie,
-- wyświetlany jest numer zamówienia. Klienci, którzy zarejestrowali się,
-- ale nie złożyli zamówienia, są wyświetlani z numerem zamówienia NULL.
SELECT c.customerid, oh.salesorderid
FROM Sales.Customer AS c
         LEFT OUTER JOIN Sales.SalesOrderHeader AS oh ON c.CustomerID = oh.CustomerID
ORDER BY c.CustomerID;

-- Potwierdzenie
SELECT c.customerid, oh.salesorderid
FROM Sales.Customer AS c
         LEFT OUTER JOIN Sales.SalesOrderHeader AS oh
                         ON c.CustomerID = oh.CustomerID
WHERE oh.salesorderid is NULL
ORDER BY c.CustomerID;

-- OK, ale chcemy otrzymać klientów którzy wykonali jakies zamówienia -> PROSTA sprawa WHERE -> TAK?
SELECT c.customerid, oh.salesorderid
FROM Sales.Customer AS c
         LEFT OUTER JOIN Sales.SalesOrderHeader AS oh
                         ON c.CustomerID = oh.CustomerID
WHERE oh.salesorderid is not NULL
ORDER BY c.CustomerID;

-- Lepsze rozwiązanie: Zamieniająć Łączenie tabel z LEFT -> RIGHT otrzymamy tylko klientów którzy złożyli jakieś zamówienie
-- W poprzednim przykładnie będzie więcej łączeń i będzie to mniej wydajne
SELECT c.customerid, oh.salesorderid
FROM Sales.Customer AS c
         RIGHT OUTER JOIN Sales.SalesOrderHeader AS oh
                          ON c.CustomerID = oh.CustomerID
ORDER BY c.CustomerID;

-- Potwierdzenie, tutaj powinniśmy dostać w wyniku 0 wierszy
-- Dodajemy Where is Null
SELECT c.customerid, oh.salesorderid
FROM Sales.Customer AS c
         RIGHT OUTER JOIN Sales.SalesOrderHeader AS oh
                          ON c.CustomerID = oh.CustomerID
WHERE oh.salesorderid is NULL
ORDER BY c.CustomerID;

-- Dodajemy więcej Łączeń
-- wyniki obejmują wszystkie produkty wraz z numerami zamówień dla tych, które zostały zakupione.
-- Wymagało to sekwencji połączeń od Product do SalesOrderDetail do SalesOrderHeader.

SELECT p.Name As ProductName, oh.salesorderid
FROM production.Product AS p
         LEFT JOIN Sales.SalesOrderDetail AS od
                   ON p.ProductID = od.ProductID
         LEFT JOIN Sales.SalesOrderHeader AS oh
                   ON od.SalesOrderID = oh.SalesOrderID
ORDER BY p.ProductID;

-- Dlaczego daje nam to 0 wierszy?
SELECT DISTINCT c.CustomerID, oh.salesorderid
from Sales.Customer AS c
         left join Sales.SalesOrderHeader As oh on c.CustomerID = oh.CustomerID
         right join Sales.SalesOrderDetail od on oh.SalesOrderID = od.SalesOrderID
where oh.salesorderid is NULL;


-- Te 2 złączenia wykluczają się - trzeba bardzo uważać podczas sekwencji złączeń
-- Przeanalizujmy je po kolei
-- Po analizie wychodzi nam że przy złączeniu w linii 111 chcemy łączyć
-- wszystkie SalesOrderDetail które mają klucz główny NULL i nie da nam to żadnych wyników

-- Zamieniając right joina na left joina dostaniemy wyniki które chcemy otrzymać
--      -> czyli wszystkich klientów którzy nie mają zamówienia


-- TODO SUBQUERIES

-- maksymalna cena jednostkowa w Sales.SalesOrderDetail (najwyższa cena, za jaką sprzedano pojedynczy produkt).
-- MAX - jest to funkcja -> będziemy o tym mówić za chwilę
SELECT MAX(UnitPrice)
FROM Sales.SalesOrderDetail;

-- Używając właśnie uruchomionego zapytania jako podzapytania otrzymamy produkty z ListPrice równą maksymalnej cenie sprzedaży.

SELECT Name, ListPrice
FROM production.Product
WHERE ListPrice =
      (SELECT MAX(UnitPrice)
       FROM sales.SalesOrderDetail);

-- Znajdź produkty które były zamówione przynajmniej 20 razy
SELECT ProductID
FROM Sales.SalesOrderDetail
WHERE OrderQty >= 20
order by productid desc;

-- Tutaj zastosujmy distinct - po co nam powtórki w IN -> Bo zaraz wykorzystamy to zapytanie w sekcji IN(...)
SELECT DISTINCT ProductID
FROM Sales.SalesOrderDetail
WHERE OrderQty >= 20;

-- Wynik zawiera nazwy produktów, które zostały zamówione w ilości 20 lub więcej.
-- ProductID IN
-- Pisianie podzapytań tego typu jest bardziej wydajne niż przekazywanie gotowych ID do IN -> wynika to już z wewnętrznej implemetnacji SQL Server
SELECT DISTINCT Name
FROM production.Product
WHERE ProductID IN
      (SELECT DISTINCT ProductID
       FROM Sales.SalesOrderDetail
       WHERE OrderQty >= 20)
ORDER BY name;

-- A teraz ten sam wynik osiągniety w inny sposób (JOIN) -> Tutaj Pamiętamy o DISTINCT!
SELECT DISTINCT p.Name
FROM production.Product AS p
         JOIN Sales.SalesOrderDetail AS o ON p.ProductID = o.ProductID
WHERE OrderQty >= 20;