-- Jak DODAWAĆ nowe bazy danych:
-- otwieram po prawej 'DataBase' -> rozwijam '+' -> wybieram 'Data source' -> wybieram silnik,
-- który obsługuje daną DB, np. niech to będzie Microsoft SQL Server -> wpisuje name
-- -> host daje taki jaki jest zeby się połączyć z tą bazą danych, czyli jest ona przetrzymywanana na serwerze np.
-- 'morfeusz.wszib.edu.pl -> Port: nie daje nic - wypełni sie automatycznie -> user, daje taki, jaki jest żeby się z tą bazą
-- danych połączyć, np.wiltos + hasło -> i na koniec mogę sobie zrobić test połączenia (lewy dolny róg)


----------------------------------------------
-- SELECT
-- SSMS pomaga konstruować zapytania- kolorując
-- i podpowiadając (IntelliSense) składnię
-- tekst zaznaczony na zielono to komentarze.
-----------------------------------------
-- SKRÓTY:
-- 1. zaznaczam cały fragment kodu, który ma się wykonać + ctrl + ent -- uruchomienie danej instrukcji

-- EKSPORT danych:
-- generalnie to co się wyświetla u Klienta=idle=PyCharmie lub Microsft SQL Server Management, to są dane ściągnięte
-- za pomocą silnika, z konkretnej bazy danych --> które to dane możemy sobie z pozycji idle zapisać do rządanego
-- pliku, np. typu .csv, .xlsx, który potem jest w jakichś kalkulacjach jest wykorzystywany.
-- Robimy to w PyCharmie za pomocą znaczka: strzałka w dół, która się zatrzymuje na podkreślniku (dolny prawy róg).

-- Generalnie Postrgre SQL, Microsoft SQL Server, MySQL, Maria DB to są silniki bazy danych, a nie bazy danych.
-- Te silniki baz danych, za pomocą idle=Klientów takich jak np. PyCharm, Microsoft SQL Server Management STudio,
-- obsługują konkretną bazę danych, którą w naszym przypadku jest np. baza danych AdventureWorks, czy 'Master -
-- za pomocą kodu/instrukcji które wychodzą z Idle=Klient. Wiadomo też, że Idle=Klient musi się wpierw połączyć z
-- danym silnikiem konkretnej bazy danych, żeby móc jako Klient, który coś chce wysyłać żądania do silnika, który to
-- następnie wyciągnie te dane z jakiejś bazy danych albo coś na niej zapisze.
-- I jak idle=Klient wysyła polecenie pobrania danej kolumny z danej bazy danych i tabeli,
-- to silnik te polecenia odbiera i pobiera te dane z konkretnej bazy danych i docelowo te dane albo
-- modyfikuje, albo zapisuje jako nowe, na danej bazie danych.

-- ustawiamy bazę danych, na ktorej będziemy pracować - tu jest AdventureWorks jako bieżącą
-- ale zanim ją odpalimy musimy wybrać z tej bazy, jakie schematy nas interesują ->
-- -> czyli w tą bazę wchodzę -> wciskam pole po prawej, gdzie jest zapisane: '0 of 18',
-- czyli baza ma 18 schematów, ale zaczytanych jest 0 -> teraz jak już w nią wejdę zaznaczam
-- te schematy, które mnie interesują i daje lewym myszki na bok, czyli np. zaczytma 6 schematów,
-- to powinno sie pojawić '6 of 18' -> i dopiero teraz po zaczytaniu schematów z tej bazy danych
-- mogę ją odpalić. Bez zaczytania schematów, odpalenie bazy danych nic by nie dało,
-- bo przecież nic by nie zaczytało
-- żeby ją odpalić muszę tą linię 'USE AdventureWorks' ZAZNACZYĆ i następnie za pomocą
-- ctrl+ ent uruchomić.
-- ! WAŻNE: Jeśli danej części query nie zaznaczę, to ta nie zaznaczona część
-- się nie odpali!
-- Również ctrl+ent używam do odpaleń queries
USE AdventureWorks

-- wyświetl wszystkie kolumny (*) z tabeli Product w schemacie Production
SELECT * FROM Production.Product
-- 'AdventureWorks' to baza danych, z której schemat, a docelowo tabela będzie zaciągna.
  -- myśmy tą DB 'AdventureWorks' podali i uruchomili powyżej, ale można też to zrobić od razu w jednej linii,
  -- tak jak poniżej --> '... FROM AdventureWorks.Production.Product', ale to się będzie tyczyło danych tylko
  -- dla tego jednego pobrania. Jak chcemy żeby cały czas była obsługiwana dana DB, to musimy poprzez
  -- polecenie 'USE' ją odpalić: '... USE AdventureWorks'
-- 'PRODUCTION' = to schemat (czyli takie nasze pudełko, w  którym są trzymane różne tabele)
-- 'PRODUCT' = to tabela, w której są trzymane dane, które nas interesują


-- teraz przechodzimy do innej bazy danych
USE master

-- 3-part table name (DB-SCHEMA-TABLE) --> tu podajemy 3-składniową ścieżkę, czyli:
-- wybieram wszystkie kolumny = * z lokacji jak:
-- Baza Danych = AdventureWorks + Schemat = Production + Tabele = Product
-- a wiadomo, że nie wybieramy żadnych specjalnych kolumn  ztej tabeli 'Product',
-- tylko wyciągamy wszystkie kolumny, bo daliśmy '*'
SELECT * FROM AdventureWorks.Production.Product

USE AdventureWorks

-- teraz wyświetlamy 5 kolumn z tabeli Product (dajemy je po przecinku), schematu Production i wcześniej
-- uruchomionej bazy danych 'AdventureWorks'
SELECT ProductID, Name, ProductNumber, Color, StandardCost
FROM Production.Product


-- Sortowanie wierszy za pomocą polecenia ORDER BY ASC | DESC
SELECT ProductID, Name, Color FROM Production.Product
ORDER BY Name --z defaultu to jest sortowanie alfabetyczne
-- w zależności w jakiej kolejności sobie wpiszę kolumny, w takiej
                              -- kolejności one będą wyświetlane, czyli tu jako pierwsze ProductID, potem Name,
                              -- a na końcu Color
 -- te trzy kolumny są posortowane po kolumnie 'name' - czyli zgodność alfabetyczna dla tej kolumny 'name'
              -- a pozostałe kolumny już wynikowo, ale jeśli pozostałe nie mają DESC, to z defaultu jest to ASC
    -- WAŻNE: jak widać sortowanie jest rosnąco, czyli od 'a' do 'z', po defaultowo to sortowanie zawsze jest rosnące,
    -- czyli 'ASCEnD'. Jakbyśmy chcieli zmienić na malejąco, to musimy to zrobic specjalnie,
    -- za pomocą instrukcji 'DESCEnD'

SELECT Name, Color, ProductID FROM Production.Product
ORDER BY Color, Name -- sortowanie najpierw po kolumnie Color, a potem po Name -
-- ale to mówi nam, że wszystko się zaczyna od Color,a potem jak coś jest w tej samej
-- kategprii Color do posortowania od strony Name jest sortowane

-- the same result as above ze słowami ASC(ascending), które PyCharm zaznacza że są niepotrzebne, bo
-- ta kolejność jest domyślna
SELECT ProductID, Name, Color FROM Production.Product
ORDER BY Color ASC, Name ASC

SELECT ProductID, Name, Color FROM Production.Product
ORDER BY Name DESC, Color -- jak widać możemy też sortować kolumny w rożny sposób. Kolumna Name jest sortowana
-- w sposób malejący, zaś kolumna Color defaultowo, czyli w sposób rosnący. Oczywiście kolumną nadrzedną, do której
-- kolumna Color jest sortowana, to kolumna Name, która jest wyświetlana jako pierwsza


-- Filtrowanie danych, robimy za pomocą słowa kluczowego 'WHERE'
----------------------------------------
-- Odczytywanie produktów koloru czarnego
SELECT * FROM Production.Product
         WHERE Color = 'Black' -- tu wyświetlamy wszystkie kolumny +
-- filtrujemy kolumne 'Color' po black, czyli wyświetli się tylko kolor 'black'


SELECT ProductID, Name, ProductNumber, Color, ProductSubcategoryID
FROM Production.Product WHERE Color = 'Black'
-- tu robimy co powyższe, ale tylko dla 5 kolumn, czyli zawęziliśmy ilość kolumn

SELECT ProductSubcategoryID
FROM Production.Product WHERE Color = 'Black'--! WAŻNE: my nawet możemy tej kolumny Color nie wyświetlać,
-- ale możemy dalej po niej filtrować, jak w tym przypadku: wyświetlamy tylko kolumnę ProductSubcategoryID, ale
-- filtrujemy ją po kolumnie Color, która nie jest wyświetlana

SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.ProductCategory


SELECT * FROM Production.ProductSubcategory WHERE ProductSubcategoryID = 2 --tu filtrujemy po ProdSUbcID po cyfrze 2,
-- a z racji, że jest on kluczem głównym, to w tej tabeli występuje tylko raz

SELECT * FROM Production.ProductCategory WHERE ProductCategoryID = 1 -- tu zas filtrujemy po 1, który też jest
-- kluczem głównym, więc wystąpi tylko raz.

SELECT ProductID, Name, Color, ProductSubcategoryID
FROM Production.Product WHERE ProductSubcategoryID = 2
-- ciekawa rzecz - jak w tabeli wyświetlimy te kolumny, które ustawiliśmy, to zobaczymy różne kolory kluczy -->
-- jako że 'ProduktID' jest kluczem głównym tej tabeli 'Product' ma kolor żółty, zaś kolumna 'ProductSubcID'
-- z racji, że jest kluczem obcym, ten kluczyk ma kolor niebieski

-- Operatory porównania
-- =, <>, >, <, >=, <, <=, !=
SELECT * FROM Production.ProductSubcategory
WHERE ProductSubcategoryID <= 10 -- mniejsze lub równe 10

SELECT * FROM Production.ProductSubcategory
WHERE Name <> 'Mountain Bikes' -- jest różna niż (ISO) - ten diamencik <> to jest 'różne', czyli to
-- samo co !=, ale jest bardziej oficjalną wersją zgodną z ISO. Zaś != nie jest zgodne z ISO, nie mniej jednak
-- oba te operatory są stosowane. Można je stosować zamiennie. Chociaż częstszym jest !=.

SELECT * FROM Production.ProductSubcategory
WHERE Name != 'Mountain Bikes' -- jest różna niż (not ISO standard)


SELECT * FROM Production.ProductSubcategory
WHERE ProductSubcategoryID <= 10 OR ProductSubcategoryID > 20 -- spodziewamy się po tej
-- filtracji wyniku, że ProdSubCatID będzie <=10 lub (or) >=20

-- zakres wartosci
SELECT * FROM Production.ProductSubcategory
WHERE ProductSubcategoryID >= 10 AND ProductSubcategoryID < 20
-- taki sam wynik, ale szybciej/zwięźlej bo za pomocą komendy BETWEEN
SELECT * FROM Production.ProductSubcategory
WHERE ProductSubcategoryID BETWEEN 10 AND 19



-- Porównywanie ciągów znaków: albo '=' - dokładnie taka // 'LIKE' + % = ciąg znaków przed lub po taki jak w filtrze
SELECT * FROM Production.ProductSubcategory
WHERE Name = 'Mountain Bikes' -- tu filtrujemy po ciągu znaków, które w tym przypadku są umieszczone w kolumnie
-- Name, i muszą być w całości równe 'Mountain Bikes'

-- % dowolna ilość (lub brak) dowolnego znaku za pomocą polecenia 'LIKE'
SELECT * FROM Production.ProductSubcategory
WHERE Name LIKE '%Bikes'  -- jeśli mamy '%Bikes' to weźmie nam wyfiltruje wszystko co ma
-- Bikes na końcu, z różnymi
-- przedrostkami przed nim, bo % jest przed nim -- czyli za Bikes już nic nie będzie,
-- chyba że % będzie na koncu słowa, czyli 'Bikes%' - to wyfiltruje nam wszystkie slowa
-- które się zaczną od Bikes, a za nim będą miały rożne ciągi znaków, którym również jest
-- spacja

SELECT * FROM Production.ProductSubcategory
WHERE Name LIKE 'C%'  -- tu filtrujemy kolumne Name, po słowach które się zaczynają od 'C', a za nim jest dowolny
                      -- ciąg znaków


SELECT * FROM Production.ProductSubcategory
WHERE Name LIKE '%es%' -- tu 'es' stałe, które może być na początku, końcu, w  środku,
-- + wszystko inne co przed i po 'es' będzie

-- _ pojedynczy, dowolny znak
SELECT * FROM Production.Product
WHERE Name LIKE 'Flat Washer _' -- tu mamy: słowo 'Flat Washer' + 'spacja' + '_'
--, gdzie '_' to jest wyfiltrowanie po znaku, czyli jeden dowolny OSOBNY znak
-- (może być litera, cyfra), np. Flat Washer 1


-- [] PRZEKAZANIE listy znaków, które robimy za pomocą nawiasu kwadratowego
SELECT * FROM Production.Product WHERE Name LIKE 'Classic Vest, [LM]' -- tu dostajemy słowo
-- Classic Vest + spacja,
-- bo jak widać po przecinku jest spacja + pojedynczą literę 'L' albo 'M', czyli dostaniemy
-- np. 'Classic Vest, L ' lub 'Classic Vest, M'

SELECT * FROM Production.Product WHERE Name LIKE 'Classic Vest, [K-Z]' -- zaś tu dostajemy
-- słowo Classic Vest + spacja + pojedyncze litery z zakresu od K do Z



-- Operatory logiczne
-- Red Subcategory: 2, 14, 31
-- Kolejność operatorów
-- 1) AND - ma wyższe znaczenie niż OR, czyli jak będzie Or i And, to zawsze pierwszy będzie
-- rozpatrywany argument, który jest po And, a dopiero potem ten po Or.
-- 2) OR


-- W poniższym przypadku jak widzimy Color 'Black' jest połączony z 'ProductSubCatID'
-- za pomocą AND,więc dostaniemy
-- wszystkie kolory 'black' z ProductSubcategoryID = 1,
-- zaś Color 'Red' nie jest połączony z ProdSubCatID=1, bo po sobie ma OR, więc dostaniemy
-- kolor 'red', ale dla wszystkich ProdSubCatID = 1,12,3,4,5,6 itd.
-- ALe można to też załatwić za pomocą nawiasu, który damy tam gdzie poszczególne argumenty chcemy ze sobą połączyć.
SELECT Color, ProductSubcategoryID, * FROM Production.Product
WHERE Color = 'Red' OR Color = 'Black' AND ProductSubcategoryID = 1


SELECT Name, Color FROM Production.Product
WHERE Color = 'Black' OR Color = 'Red' -- tu prosto - dostajemy wszystkie warianty z kolumny NAME, które mają kolory
-- Black OR Red

-- !!! wykluczający się warunek- kolumna może mieć tylko jedną wartość
SELECT Name, Color FROM Production.Product
WHERE Color = 'Black' AND Color = 'Red' -- tu jest wykluczenie polegające na tym,
-- że chcemy kolumnę Name i Color,
-- ale nie możemy dać do tej samej kolumny 'And' dla dwóch argumentów, bo przecież kolor nie może być czerwony
-- i czarny jednocześnie.. ;-).

-- poprawnie
SELECT * FROM Production.Product
WHERE ProductSubcategoryID = 2 AND Color = 'Red' -- tu już jest ok, bo są dwie różne kolumny i tu szukamy gdzie jedna
-- kolumna ma wartość ProdSubCatID = 2 i Color 'Red' - wiadomo, że może tak być, czyli ta filtracja po tych
-- danych się nie wyklucza


SELECT * FROM Production.Product
WHERE ProductSubcategoryID = 2 AND NOT Color = 'Red' -- tu mamy wyniki, gdzie mamy
-- ProdSubCatID=2 i NIE kolory czerwone
-- taki sam wynik co powyżej, w troszkę inny sposób, poprzez dodanie znaku różny '<>':
SELECT * FROM Production.Product
WHERE ProductSubcategoryID = 2 AND Color <> 'Red'


SELECT * FROM Production.Product
WHERE Color = 'Black' OR Color= 'Silver' OR Color  = 'Red' -- tu mamy dłuższą wersję różnych kolorów
-- taki sam wynik, ale poprzez krótszą wersję, za pomocą IN i w nawiasie okrągłym
-- podajemy argumenty do filtrowania
SELECT * FROM Production.Product
WHERE Color IN ('Black', 'Silver', 'Red')

-- zaś poniżej poprzez NOT, eliminujemy te trzy kolory z filtra, czyli dostaniemy wszystkie inne kolory,
-- oprócz tych trzech
SELECT * FROM Production.Product
WHERE Color NOT IN ('Black', 'Silver', 'Red')

SELECT * FROM Production.Product
WHERE Color <> ('Black', 'Silver', 'Red') -- tak nie zadziała - operator różnicy nie może być użyty, musi byc NOT IN


-- nawiasy - a teraz dzięki nawiasom można zdecydować kolejnośc wykonywania operacji.
-- Wiadomo, że w nawiasie się rzeczy wykonają razem.
-- Czyli poniżej dwa podwójne warunki się wykonają
SELECT ProductSubcategoryID, Color FROM Production.Product
WHERE (ProductSubcategoryID = 2 AND Color <> 'Red') -- ProdSubCATID=2 wszystko różne od red +
-- ProdSubCATID=1 wszystko rożne od black
 OR (ProductSubcategoryID = 1 AND Color <> 'Black')

-- można tez taki warunek zastosować:
SELECT Color, ProductSubcategoryID, * FROM Production.Product
WHERE (Color IN ('Red', 'Black')) AND ProductSubcategoryID = 1 -- kolor red i black dla
-- ProdSubCat=1

-- Lub to powyższe w ten sposób:
SELECT Color, ProductSubcategoryID, * FROM Production.Product
WHERE (Color = 'Red' OR Color = 'Black') AND ProductSubcategoryID = 1


SELECT ProductSubcategoryID, Color FROM Production.Product
WHERE (ProductSubcategoryID = 2 AND Color <> 'Red')
 OR (ProductSubcategoryID = 1 AND Color <> 'Black')
ORDER BY ProductSubcategoryID, Color -- i jeszcze sortowanie po ProdSubCatID rosnąco,
-- a następnie te powtarzalne po kolorze też rosnąco (bo wiadomo, że jak nie podajemy Desc,
-- to z defaultu jest brane ASC, czyli rosnące



-- zakres wartosci
SELECT * FROM Production.ProductSubcategory
WHERE ProductSubcategoryID >= 10 AND ProductSubcategoryID < 20
-- taki sam wynik, ale szybciej/zwięźlej bo za pomocą komendy BETWEEN
SELECT * FROM Production.ProductSubcategory
WHERE ProductSubcategoryID BETWEEN 10 AND 19



-- Teraz sobie odpalamy nową tabelę SalesOrderHeader ze schematu Sales:
SELECT * FROM Sales.SalesOrderHeader

SELECT * FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '20040501' AND '20040507' -- tu filtrujemy po zakresie daty BETWEEN
-- x AND y -- taki sam wynik jak powyżej, dzięki użyciu porównań, ale powyższa składnia
-- lepsza/preferowana
SELECT * FROM Sales.SalesOrderHeader
WHERE OrderDate >= '20040501' AND OrderDate <= '20040507'

-- taki sam wynik (ale inaczej podana data)
SELECT * FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2004-05-01' AND OrderDate <= '2004-05-07'

-- * Generalnie SQL sobie poradził zarówno z datą napisaną jako: '20040501'
-- oraz jako '2004-05-01'.
-- Zapisał je w taki sam sposób.


-- jeszcze inaczej dla T-SQL (to jest płatny silnik, zrobiony przez Microsoft) - to jest
-- rozwinięcie dla SQL przez
-- Microsofta - i np. na PostgreSQL nie zadziała, bo Microsoft chciał mieć bardziej
-- rozbudowany silnik,
-- gdzie PostgreSQL tego nie ma. Ale jest jedna duża różnica, T-SQL jest płatny i to nie mało,
-- a wcale nie tak dużo nie jest lepszy od PostgreSQL, który jest darmowy, dlatego nawe
-- duże korporacje migrują swoje bazy danych do PostgreSQL,
-- który je obsługuje, wiadomo jako silnik.
SELECT * FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN CAST('2004-05-01' as date) AND CAST('2004-05-07' as date) -- raczej nie zadziała na PostgreSQL


-- NULL -- jest wartością niekreśloną w systemie.
SELECT Name, Color FROM Production.Product

SELECT Name, Color FROM Production.Product
WHERE Color IS NOT NULL -- tu mamy wszystkie produkty, które nie są nullem

SELECT Name, Color FROM Production.Product
WHERE Color IS NULL -- tu mamy wszystkie produkty, które są nullem



-- przykład użycia funkcji 'ISNULL', ktora przekształca dane które są nullem, na dane które dalej są nullem,
-- ale mają inną nazwę + dodatkowo można sobie we własny sposób nazwać kolumnę
SELECT Name, Color, ISNULL(Color, 'no color') AS SuperColor FROM Production.Product --tu mamy już aliasowanie,
-- czyli wyświetlamy kolumnę Name i Color, gdzie kolumna Color wszystkie wartości NULL wyświetla jako: no color +
-- wtedy w tej nowej kolumnie gdzie zamiast NULL jest 'no color' ta nowa dodatkowa kolumna zmienia nazwę na SuperColor
-- + oczywiście są wyświetlane wszystkie inne kolory


SELECT ISNULL(Color, 'NO COLOR') FROM Production.Product -- tu to samo co powyżej, tylko od razu z zastosowaniem
-- funkcji ISNULL, czyli dostaniemy kolumnę z wartościami NO Color i nową kolumną (z tym, że ta kolumna nie będzie
-- miała nowej nazwy jak powyżej, tylko nazwę z defaultu nadawana, po wykorzystaniu ISNULLA, czyli 'anonymous'


-- eliminowanie duplikatów z wyniku za pomocą 'DISTINCT'- czyli powtórzeń. Pokaże nam tylko wszystkie niepowtarzalne
--w poniższym przypadku kolory -  czyli jeśli są duplikaty, to nie duplikuj tych kolorów,tylko pokaż te kolory,które
-- są w całym pakiecie, czyli np. red, blue, yellow, null - czyli będą 4 wiersze, mimo tego, że blue jest 10,
-- a yellow 20, to SQL pokaże tylko jakie generalnie są kolory, nie będzie ich powtarzał, jeśli się te kolory
-- powtarzają.
SELECT DISTINCT Color FROM Production.Product ORDER BY Color



-- -- Aliasy kolumn
SELECT CustomerID, OrderDate, ShipDate
FROM Sales.SalesOrderHeader

SELECT CustomerID AS cliente, OrderDate AS [fecha de pedido], ShipDate AS [fecha de entrega]
FROM Sales.SalesOrderHeader -- zmieniamy nazwy kolumny na nowe, np. CustomerID na cliente i
-- td.
-- Ważna rzecz, że jak zmieniamy nazwy kolumn (aliasujemy je) te nowe nazwy muszą być albo
-- w nawiasach kwadratowych albo w apostrofach albo bez niczego (bez apostrofów i bez nawiasów kwadratowych]

-- tabele również możemy aliasować (później..), na razie korzystamy max z 1 tabeli na zapytanie :)



-- FUNKCJA TOP - zwraca żądaną ilość topowych (górnych=pierwszych w tabeli) wierszy
-- poniższe query zwroci nam 5 górnych(pierwszych w tabeli Employee) wierszy (schemat: HumanResources),
-- które jeszcze są posortowane(ORDER BY), po malejącej dacie
SELECT TOP 5 * FROM HumanResources.Employee ORDER BY ModifiedDate DESC

-- FUNKCJA COUNT zlicza nam ilość wierszy w tabeli Employee i zapisuję tą daną
-- w kolumnie o nazwie 'employeeCnt'
SELECT COUNT(*) AS employeesCnt FROM HumanResources.Employee

-- Użycie FUNKCJI TOP w postaci procentowej (np. daj mi 10% TOP=górnych=pierwszych wierszy,
-- z całości=ze wszystkich(czyli np jeśli wszytskich jest 290, to da nam 29 wierszy)
-- wierszy (*), ze schematu HumanResources i tabeli Employee + dodatkowo sortowane po malejącej dacie
SELECT TOP 10 PERCENT * FROM HumanResources.Employee ORDER BY ModifiedDate DESC



-- FUNKCJA Konkatenacji - czyli łączenie
SELECT * FROM Person.Contact -- tu sobie wyświetlamy wszystkie kolumny ze schematu Person i tabeli Contact

SELECT FirstName, LastName, FirstName + ' ' + LastName AS FullName
FROM Person.Contact -- tu wyświetlamy sobie kolumnę FirstName, LastName
-- + teraz używamy konkatenacji żeby połączyć
-- te 2 kolumny w jedną, która będzie od razu wyświetlać imię i nazwisko
-- + zmieniamy jej nazwę za pomocą Aliasu (AS) na FullName


-- Funkcja LEFT, która pobiera znaki od lewej strony
SELECT FirstName,
 LEFT(FirstName, 1) AS FirstLetterOfName,
 LEFT(FirstName, 3) AS First3LettersOfName
FROM Person.Contact -- tu funkcja LEFT pobierze z kolumny FirstName 1 literę od lewej + nada nową nazwę tej kolumnie
-- jako FirstLetterOfName
--  +
-- znów funkcja LEFT pobierze 3 litery od lewej strony, odnośnie kolumny FirstName + nada tej nowej kolumnie,
-- gdzie te 3 litery się będą zawierać 'First3LettersOfName'


















-- T-SQL MA BARDZO DUŻO INNYCH PRZYDATNYCH FUNKCJI - WSZYSTKICH NIE UDA NAM SIE POKAZAĆ