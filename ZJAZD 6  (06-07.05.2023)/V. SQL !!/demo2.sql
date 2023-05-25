-- LINK do dokumentacji AdventureWorks2014, na bazie której mozna wyciągnąć wszystkie powiązania
-- https://www.sqldatadictionary.com/AdventureWorks2014.pdf

--- INNER join = łączenie na bazie wspólnych części -----
-- łączenie tych danych, które zarówno występują w tabeli 1 i tabeli 2, czyli na bazie wspólnych cześci te tabele
-- łączymy (only the things that match on the left and the right). Poniżej przykład łączenia tabel:
-- Select * (wybierz nam wszystko - to się wiąże z tym, że wybierze na wszystkie kolumny z tabeli 1 i tabeli2, i je
-- pokaże(np. tab.1 = 5 kolumn, tab.2 = 7, to pokaże nam 12 kolumn) + będzie próbował połaczyć -
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

-- Te wszystkie kody dla Outer Joins(Left, Right, Full) i Inner Joins nazywają się zapytaniami = po angielsku
-- mówimy na nie Query(Zapytanie), Queries(Zapytania).

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

  -- Jak się wchodzi z poziomu PyCharm do Diagramu: najeżdzam na bazę danych, która mnie interesuje -> prawy myszki
  -- -> schodzę w dół i najeżdzam na 'Diagrams' -> rozwijam 'show visualization' -> i teraz daje 'ctr+f' i wpisuje
  -- nazwę tabeli, które mnie interesuje -> i teraz już wyszukuje między tabelami, które mnie interesują kluczy,
  -- za pomocą ktorych te tabele będę w stanie ze sobą zjoinować.

  -- I teraz sam sobie decyduję, która tabela będzie tą główną(przy left join = lewa Tabela).
  -- Generalnie żeby dwie tabele ze sobą połączyć, muszą mieć one wspólne keys, gdzie w jednej tabeli
  -- ten wspólny key będzie jako główny klucz = PK, zaś w drugiej ta kolumna będzie występować, ale nie będzie
  -- głównym kluczem, bo ona będzie miała inny PK, a będzie FK, a dlatego FK, bo w innej tabeli jest PK,
  -- czyli w tej tabeli jest kluczem obcym, zapożyczonym z innej tabeli.
  -- I żeby było jasne, nawet jak już zrobię to joinowanie (np.Left), to na schemacie(diagramie) nie zobaczę,
  -- że te tabele są połączone. To jest całkiem niezależny temat - ja zobaczę takie łączenie, jak zaciągnę
  -- taką połączoną tabelę, z bazy danych na swój komputer. Natomiast na schemacie (diagramie) ja widzę jakie są
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
-- oraz ProductCategory(z tej tabeli wyciągamy nazwę kategorii) --> + z których to te dane ściągamy z kolumn 'Name'.
-- Z tym, że te dane kryjące się w kolumnie Name, są w każdej tabeli różne - tak jak opisałem powyżej.
-- Dodatkowo widać, że kolumnę 'name' z tabeli product, zaliasowaliśmy na 'ProductName', zaś kolumnę 'name' w tabeli
-- productsubcategory zostawiliśmy taką samą jak oryginalnie oraz w tabeli ProductCategory kolumnę 'name'
-- zaliasowaliśmy na 'CategoryName'. Gdybyśmy ich nie zaliasowali, dostalibyśmy z defaultu: nazwatabeli.name, czyli:
-- 1 kolumna:Product.name, 2 kolumna:Productsubcategory.name, 3 kolumna:ProductCategory.name --> jak widać nazwy
-- tych kolumn byłyby bardzo długie, więc dlatego je aliasujemy, żeby tabelę uprościć, a kolumny nazwać tak jak my
-- chcemy.
       Production.Productsubcategory.name,
       Production.ProductCategory.name AS CategoryName
FROM production.Product -- tabela Product jest tabelą wyjściową i do niej będziemy łączyć kolejne tabele
    -- jak wiemy można zrobić więcej niż jednego joina, w jednym całościowym Query, żeby połączyć więcej niż
    -- jedną tabelę ze sobą
         INNER JOIN Production.Productsubcategory -- tu joinujemy tabelę Productsubcategory z tabelą Product. Ale
             -- żeby joinowanie zrobić, musimy to zrobić po tym samym kluczu. Więc teraz rozwijamy sobie
             -- schemat folderowy tabeli 'Product' i 'Productsbcategory' albo diagram (np. w QlikSense),gdzie widać
             -- jakie klucze są dostępne i po jakich można zrobić łączenie tabel
             -- za pomocą operatora ON robimy łączenie tabel
                    ON Production.Productsubcategory.Productcategoryid = Production.Product.Productsubcategoryid
    -- teraz wpierw sobie wchodzimy do kolumn tabeli Product i tam patrzymy, po której kolumnie z tabeli
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
-- Tutaj przykład aliasowania całych tabel (WAŻNE: nie trzeba podawać słowa kluczowego 'AS')
SELECT p.name As ProductName, pc.name As SubCategoryName, c.name AS CategoryName
-- jak widać tu aliasowanie polega na tym, że poprzez 'p' zaliasowaliśmy 'Production(schema).Product(table)' -
-- finalne zdefiniowanie tego aliasowania tej tabeli nastąpiło w linii z FROM.
-- --> 'pc' to alias dla production(schemat).productsubcategory(table) - aliasowanie tej tabeli nastąpiło
-- w linii z pierwszym Joinem
-- --> 'c' jest aliasem dla  dla Production(schema).ProductCategory(table) zrealizowanym w drugim Joinie.
-- Dodatkowo widzimy, że mamy samo słowo JOIN, czyli jest to INNER JOIN - tłumaczenie powyżej
-- w Selectach powyżej już wpisujemy zaliasowane nazwy schematów i tabel, tylko wrzucamy kolumny oryginalnie,
-- ktore również jak widać powyżej zostały zaliasowane.
-- Jak widać taki kod zamiast 8 linii zajął 4 linie - czyli jest szybszy, co nie znaczy, że np. dla mnie
-- czytelniejszy.. ;--)
FROM production.Product p -- przy aliasowaniu nie ma 'AS' bo nie ma potrzeby, ale oczywiście też może być użyte
         JOIN production.productsubcategory pc on pc.productcategoryid = p.productsubcategoryid
         JOIN production.ProductCategory c ON pc.productcategoryid = c.productcategoryid;


--- WHERE i ORDER by normalnie działają na złączeniach
-- to poniżej jest omówione powyżej:
SELECT p.name As ProductName, pc.name As SubCategoryName, c.name AS CategoryName
FROM production.Product p
         JOIN production.productsubcategory pc on pc.productcategoryid = p.productsubcategoryid --PrzyAliasowaniu
-- nie musimy używac operatora 'as' - jak widać przy aliasowaniu powyżej i tu. ALe wiadomo, ze jak się je użyje
-- to oczywiście będzie ok. ALe profesjonalni developerzy piszą kod bez 'as'.
         JOIN production.ProductCategory c ON pc.productcategoryid = c.productcategoryid
WHERE c.name like '%Clo%' -- tu sobie sortujemy po nazwie kategorii, gdzie wiemy, że słowa mogą się zaczynać/mieć w
-- środku / konczyć się litery 'Clo' - dla tabeli 'c', czyli ProductCategory i mowa o kolumnie Category Name
ORDER BY SubCategoryName desc, ProductName; -- dodatkowo możemy sobie posortować inne kolumny, np. tu posortowaliśmy
-- malejąco po nazwie (desc) kolumnę SubCategoryName, z tabeli productsubcategory + kolumnę ProductName z tabeli
-- ProductName (to jest tez sortowanie po nazwie, ale rosnąco, bo nie daliśmy 'desc', a wiadomo że z defaultu
-- jest przyjmowane asc



--------- Outer joins, czyli (1)Left, (2)Right, (3)Full ---------

-- Wyświetlmy liczbę klientów - 19820
Select count(c.customerid) -- tu dajemy za pomocą funkcji 'count' bezpośrednie i szybkie zliczenie rekordów
-- w Sales(schemat).Customer(table).customerid(kolumna), gdzie jako 'c' zostało zaliasowane Sales(schemat).
-- .Customer(table)
from Sales.Customer AS c;


-- Wyniki zawierają dane dla każdego klienta. Jeśli klient złożył zamówienie, to
-- wyświetlany jest numer zamówienia. Klienci, którzy zarejestrowali się,
-- ale nie złożyli zamówienia, są wyświetlani z numerem zamówienia NULL.
SELECT c.customerid, oh.salesorderid -- tu jak widać już zostały użyte aliasy dla schematów i tabel, które dla
-- kolumny customerid to: Sales(schemat).Customer(tabela)-zdefiniowane w linii gdzie jest 'From', zaś dla kolumny
-- salesorderid to: Sales(schemat).SalesOrderHeader(tabela) zdefiniowane w linii 'Left Outer Join'.
FROM Sales.Customer AS c
         LEFT OUTER JOIN Sales.SalesOrderHeader AS oh ON c.CustomerID = oh.CustomerID
-- i teraz robimy Left Outer Join. (1)Wpierw sprawdzam po jakich kluczach mogę te tabele: Customer + SalesOrderHeader
-- zjoinować - więc sobie wchodzę w strukturę drzewa tych tabel i patrze na kolumny. (2)Jak widzę PK=CustomerID
-- z tabeli Customer jest FK dla tabeli SallesOrderHeader, czyli już wiadomo, że po tym kluczy mogę te tabele
-- ze sobą połączyć.
-- Dodatkowo tu używam Left Joina, za pomocą którego kolumny customerid(tabela:Customer) zostanie połączona
-- z kolumną tabelą
ORDER BY c.CustomerID; -- tu kolumnę 'CustomerID' z tabeli Customer dodatkowo sortuje rosnąco (bo nie ma Desc,
-- a wiadomo, że z defaultu jest ASC).


-- Potwierdzenie - tu dokładnie co powyżej, ale dodatkowo za pomocą polecenia 'where' sprawdzam czy aby na pewno
-- jest tyle nulli ile powyżej - i jest dokładnie ta sama liczba, czyli 500.
SELECT c.customerid, oh.salesorderid
FROM Sales.Customer AS c
         LEFT OUTER JOIN Sales.SalesOrderHeader AS oh ON c.CustomerID = oh.CustomerID
WHERE oh.salesorderid is NULL -- tu daje polecenie 'where' które filtruje kolumnę salesorder z tabeli SalesOrderHeader
-- po zamówieniach, które mają wartość null
ORDER BY c.CustomerID;

-- OK, ale chcemy otrzymać klientów którzy wykonali jakies zamówienia -> PROSTA sprawa WHERE -> TAK?
SELECT c.customerid, oh.salesorderid
FROM Sales.Customer AS c
         LEFT OUTER JOIN Sales.SalesOrderHeader AS oh
                         ON c.CustomerID = oh.CustomerID
WHERE oh.salesorderid is not NULL -- a tu mamy przeciwieństwo do powyższych, czyli chcemy zobaczyć zamówienia
-- które się wykonały, nie są nullami -- czyli dajemy warunek do where, ze wyselekcjonuj po 'is not null',
-- czyli daj wszystkie wyniki, które nie są nullami
ORDER BY c.CustomerID;


-- Lepsze rozwiązanie: Zamieniająć Łączenie tabel z LEFT -> RIGHT otrzymamy tylko klientów którzy złożyli jakieś
-- zamówienie - i tu już nie trzeba korzystać z warunku 'where', gdzie przy left join, ten warunek where trzeba
-- było zastosować, żeby rozdzielic null = brak zamówienia, od is not null = są zamówienia
-- W poprzednim przykładzie z Left było więcej łączeń i reasumując można powiedzieć, że w tamtym przypdaku
-- left join był mniej wydajny, ale generalnie większość by użyła lefta - mało kto używa righta, więc on balance
-- ten left join mimo tego że troszkę dluższy jest generalnie używany i najbardziej popularny.
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
WHERE oh.salesorderid is NULL -- tu dostajemy 0, bo przy zastosowaniu right joina nie ma wyników null
ORDER BY c.CustomerID;

-- Dodajemy więcej Łączeń
-- wyniki obejmują wszystkie produkty wraz z numerami zamówień dla tych, które zostały zakupione.
-- Wymagało to sekwencji połączeń od Product do SalesOrderDetail do SalesOrderHeader.

SELECT p.Name As ProductName, oh.salesorderid
-- ALIASOWANIE: (1) Alias 'p' odnosi się do kolumny 'Name', gdzie: Production(schemat).Product(Table)
-- (2) Alias 'od' odnosi się do kolumny 'ProductID' która to będzie kluczem do połączenie z tabelą 'p',
-- gdzie: Sales(schemat).SalesOrderDetail(Table)
-- (3) Alias 'oh' odnosi się do kolumny 'SalesOrderID', gdzie: Sales(schemat).SalesOrderHeader(Table)
FROM production.Product AS p
         LEFT JOIN Sales.SalesOrderDetail AS od
-- tu jak widać po left joinie, zostały połączone tabele SalesOrderDetail z tabelą Product, za pomocą 'ON'
-- po wspólnym kluczu ProductID, gdzie dla tabeli SalesOrderDetail jest on FK,a dla tabeli Product jest PK
                   ON p.ProductID = od.ProductID
         LEFT JOIN Sales.SalesOrderHeader AS oh
-- Zaś tu również mamy left joina pomiędzy tabelami SalesOrderHeader a SalesOrderDetail, i połączenie nastąpiło
-- za pomocą klucza SalesOrderID, który jest PK dla tabeli SalesOrderHeader, a FK dla tabeli SalesOrderDetail
                   ON od.SalesOrderID = oh.SalesOrderID
ORDER BY p.ProductID; -- + kolumna ProductID z tabeli Product jest posortowana rosnąco. Zwróćmy uwagę, że
-- dlatego daliśmy sortowanie po ProductID, bo chcemy dostać listę niepowtarzalnych się productów - czyli wszystkie
-- jakie są dostępne, a nie wszystkie jakie są, nawet te, które się powtarzają(to byśmy dostali gdybyśmy wybrali
-- sortowanie poprzez ProductName.




-- Dlaczego daje nam to 0 wierszy? -- generalnie należy unikać mieszania w jednym zapytaniu różnego typu łączeń,
-- np. jak tutaj lewy z prawym
SELECT DISTINCT c.CustomerID, oh.salesorderid
from Sales.Customer AS c
         left join Sales.SalesOrderHeader As oh on c.CustomerID = oh.CustomerID
         right join Sales.SalesOrderDetail od on oh.SalesOrderID = od.SalesOrderID
where oh.salesorderid is NULL;
-- Te 2 złączenia wykluczają się - trzeba bardzo uważać podczas sekwencji złączeń
-- Przeanalizujmy je po kolei
-- Po analizie wychodzi nam że przy złączeniu w linii: 'right join Sales.SalesOrderDetail od on oh.SalesOrderID = od.SalesOrderID'
-- chcemy łączyć wszystkie SalesOrderDetail które mają klucz główny NULL i nie da nam to żadnych wyników

-- Zamieniając right joina na left joina dostaniemy wyniki które chcemy otrzymać
--      -> czyli wszystkich klientów którzy nie mają zamówienia


-- TODO SUBQUERIES

-- maksymalna cena jednostkowa w Sales.SalesOrderDetail (najwyższa cena, za jaką sprzedano pojedynczy produkt).
-- MAX - jest to funkcja
SELECT MAX(UnitPrice) -- funkcja MAX szuka nam najwyższej ceny w kolumnie UnitPrice, gdzie Sales(schemat).
-- .SalesOrderDetail(tabela). I ona nam nie będzie sortować jak to robi Order BY, ale pokaże pojedyńczą najwyższą
-- wartość, która nawet nie będzie przypisana do żadnej rzeczy - tylko podawana jest najwyższa wartość-ile wynosi.
-- U nas jest to cena, ale w innych przypadkach (innech kolumnach) może to być największa długość, waga itd.
FROM Sales.SalesOrderDetail;

--- W poniższym Query, powyższe zapytanie=Query, wkleimy do poniższego jako podzapytanie (SubQuery)
-- Natomiast poniżej dostaniemy nie tylko tą  pojedynczą najwyższą wartość, która nie jest przypisana do żadnej
-- konkretnej rzeczy (zapytanie powyżej), ale listę konkretnych rzeczy, które tą najwyższą wartość posiadają.
-- Używając właśnie uruchomionego zapytania jako podzapytania otrzymamy produkty z ListPrice
-- równą maksymalnej cenie sprzedaży.
SELECT Name, ListPrice -- tu bierzemy dane z dwóch kolumn 'Name' i 'ListPrice' z tabeli Product i schematu production
FROM production.Product
WHERE ListPrice =
      (SELECT MAX(UnitPrice)
       FROM sales.SalesOrderDetail);

-- Znajdź produkty które były zamówione przynajmniej 20 razy - z tym że w tym zapytaniu pokazuje nam wszystkie
-- rekordy, które mają 20 lub więcej zamówień, nawet jak się te same ID produktu powtarza.
SELECT ProductID
FROM Sales.SalesOrderDetail
WHERE OrderQty >= 20
order by productid desc;

-- Tutaj zastosujemy distinct - po co nam powtórki, dzięki Disitinct funkcji, pokaże nam tylko IDs produktów, które
-- miały >= ilosc zamówien i nie będzie ich powtarzał, bo jak wiemy z powyższego przrykładu, pokarze nam wszystkie
-- zamówienia nawet tego samego ID tyle razy ile razy ta ilość była większa od 20, a wiadomo, że jeśli chodzi o
-- różny okres czasu, to jeden ID produktu mogł mieć taką ilość zamówień 'n' razy.
SELECT DISTINCT ProductID -- tu mamy filtr po productID, a nie po nazwie, jak jest poniżej, czyli będziemy widzieć
-- IDs produktów
FROM Sales.SalesOrderDetail
WHERE OrderQty >= 20;

--- W poniższym Query, zapytanie powyższe wklejamy jako podzapytanie(SubQuery)
-- Wynik zawiera nazwy produktów, które zostały zamówione w ilości 20 lub więcej.
-- ProductID IN
-- Pisianie podzapytań tego typu jest bardziej wydajne niż przekazywanie gotowych ID do IN -> wynika to już z wewnętrznej implemetnacji SQL Server
SELECT DISTINCT Name -- tu wybieramy wybór po name, a nie po producID, jak jest powyżej, czyli sumarycznie dostaniemy
-- nazwy produktów, a nie ich ID + jeszcze na koncu zrobimy sortowanie po Name, czyli po ich nazwie
FROM production.Product
WHERE ProductID IN -- tu w tym Query, za pomocą poniższego subquery szukamy produktów (ale bez powtorzen, bo
-- mamy funkcję  Distinct, które zostały zamówione
      (SELECT DISTINCT ProductID
       FROM Sales.SalesOrderDetail
       WHERE OrderQty >= 20)
ORDER BY name;

-- A teraz ten sam wynik osiągniety w inny sposób (JOIN) -> Tutaj Pamiętamy o DISTINCT, co by nie dostać powtórek
-- tych samych ID produktów.
-- Generalnie można stosować SubQueries, ale najbardziej wydajną metodą jest za pomocą joinów.
SELECT DISTINCT p.Name -- Tu jak widać dajemy od razu Distinct, co by nie mieć w wynikach powtórzeń
-- tych samych ID produktów + jak widać również selectujemy Name, czyli będziemy selectowac=wybierać nie po
-- ProductId , ale po nazwach. Z tym, że żeby te nazwy wyciągnąć i dostosować do odpowiednich ID produktów,
-- musimy zrobić joina tej tabeli Produkt, w której są nazwy, ale nie ma ProductID, z tabelą SalesOrderDetail,
-- w ktorej to mamy detale nazw
FROM production.Product AS p -- tu sobie robimy alias 'p' dla Production(schemat).Product(tabela)
         JOIN Sales.SalesOrderDetail AS o ON p.ProductID = o.ProductID -- i teraz po wspólnym kluczu ProductID,
-- który jest PK dla tabeli Product i FK dla tabeli SalesOrderDetail, joinujemy sobie te tabele: Product z
-- tabelą SalesOrderDetail
WHERE OrderQty >= 20; -- no i oczywiście w ilości >= 20








