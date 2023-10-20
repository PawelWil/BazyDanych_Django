-- * Split różnych okien=pokazywanie więcej niż jedno query/tabela w jednym
-- oknie - jak to robić:
-- mam powiedzmy jedno okno 1 otwarte, jak chcę otworzyć okno 2 lub tabelę, to klikam 2x
-- na tym oknie lub tabeli -> następnie prawym myszki na oknie2/Tabeli ->
-- -> wybieram split: może być na prawo albo poniżej



-- wyświetl "aktywną" bazę danych
select DB_NAME(); --pokazuje jak jest wczytana baza danych, ale wiadomo, że wcześniej tą
-- bazę danych musimy wczytać, czyli jak wczytam, np. bazę danych 'AdventureWorks'
-- to po wybraniu tej funkcji, wyświetli mi się w tabeli nazwa tej bazy danych

-- przełącz się na bazę danych
use AdventureWorks;
 
-- Przykład tworzenia i usuwania bazy danych (jeżeli mamy uprawnienia)
----------------------------------------------------------------------
CREATE DATABASE NewDatabase -- wyskakuje 'permission denied' , czyli brak uprawnienia
-- do tworzenia bazy danych, ale w ten sposób jak coś można utworzyć bazę danych
 
ALTER DATABASE NewDatabase SET  READ_ONLY WITH NO_WAIT
GO
 
USE master
DROP DATABASE NewDatabase -- 'DROP' to jest usuwanie
 
 
CREATE DATABASE NewDatabase

-- Tworzenie i modyfikowanie tabeli
---------------------------------------
USE wiltos --to jest baza danych, która została nazwana moim studenckim loginem,
-- Poprzez słowo kluczowe 'USE' + nazwa bazy danych, tą bazę wczytujemy

select DB_NAME(); -- tu sobie sprawdzam, czy ta baza danych 'wiltos' jest odpalona - szczególy
-- powyżej

-- RODZAJE ZMIEnnYCH:
--     boolean - wartość logiczna - przyjmuje tylko dwie wartości prawda i fłasz (True/False)
--     integer – liczby całkowite - liczby całkowite, nie posiadające części ułamkowej.
--     float – liczby rzeczywiste - dowolne wartości, po przecinku itd.
--     string – łańcuchy tesktowe - napisy dowolnej długości.
--     date - typ danych daty - tylko data
--     datetime - typ zmiennej, która będzie przetrzymywać datę + czas
--     nvarchar - to jest ciąg znaków - zmienna tekstowa, zgodna ze standardem UniCode
--     varchar - to też jest ciąg znaków - zmienna tekstowa
--          Czym się różni Varchar od NVarchar?
--          NVarchar to jest Unicode, w którym dwa bajty przypadają na jeden znak,
--          a w Varchar jeden bajt przypada na jeden znak,
--          z tego wynika, że nvarchar(100) może mieć długośc do 50 znaków,
--          a varchar(100) moze mieć długość do 100 znaków,
--          ale jeden i drugi zajmuje tyle samo miejsca na dysku (powierzchnia dysku).
--          Z tym, że jeśli chodzi o długość znaku, NVarchar zajmują 2 raz więcej
--          miejsca w porównaniu do typów nieunicodowych tj. 2 bajty na każdy znak.
--              Co to jest 'UNICODE':
--              Typ nvarchar, bo o nim tutaj mowa, jest zapisany w standardzie unicode.
--              Standard ten gwarantuje nam skuteczną pracę z serwerem obsługującym aplikacje
--              wielojęzyczne. Jeśli chcielibyśmy aby nasza aplikacja działała zarówno
--              w języku włoskim, polskim jak i w angielskim, pola zawierające tekst muszą
--              być zadeklarowane jako nchar, w przeciwnym wypadku dojdzie do przekłamań.
--              Ale Kosztem wprowadzenia typu nchar, jest zwiększenie fizycznej objętości.




-- TWORZEnIE TABELI ! :)
-- Tabela domyślnie nam się utworzy w schemacie domyslnym - 'dbo'
CREATE TABLE Customers ( --tworzenie tabeli poprzez polecenie 'CREATE'+Nazwę Tabeli=Customers
  ID int PRIMARY KEY, -- najpierw definiujemy nazwę kolumny, czyli tu będzie 'ID'
  -- następnie definujemy jaki typ danych będzie w tej kolumnie, czyli u nas 'int'
  -- następnie musimy zdefiniować klucz główny tabeli i u nas ta kolumna 'ID'
  -- będzie dla nas kluczem głównym, czyli 'Primary Key'
  -- Primary Key innej tabeli, dla tej bedzie jako Foreign Key, czyli obcy klucz, który jest
  -- ulokowany gdzieś indziej i wlaśnie gdzieś indziej jest Primary Key
  Firstname nvarchar(50) NOT NULL, --teraz tworzę kolumnę o nazwie 'FirstName', o zmiennej
  -- typu nVarchar(czyli unicode), gdzie w nawiasie podaje ile maksymalnie znaków można
  -- zawrzeć, u nas to 50, jeśli będzie więcej wystąpi błąd.
  -- dając 'NOT NULL', oczekujemy, że w kolumnie 'Firstname' nigdy nie będzie sytuacji, że
  -- nie będzie żadnej wartości, czyli wartości w tej kolumnie zawsze będą coś pokazywać,
  -- Jeśli nic nie zostanie wpisane, wtedy będzie błąd.
  Lastname nvarchar(50) NOT NULL, -- tu to samo co u gory
  BirthDate date NOT NULL -- tu kolumna 'BirthDate', zmienna danych 'date' czyli typ
  -- danych datowy + 'NOT NULL'=musi coś tam byc, inaczej będzie błąd, przy zapisie tabeli
)

SELECT * FROM Customers
 
-- usunięcie tabeli
DROP TABLE Customers -- polecenie DROP + co chcemy usunąć=Table + jaką tabelę='Customers'
 
 
CREATE TABLE Customers (
  ID int PRIMARY KEY,
  Firstname nvarchar(50),
  Lastname nvarchar(50),
  WrongColumnName date
)
 
SELECT * FROM Customers
 
-- altering table = updatowanie tabeli + DROP = usunięcie kolumny
ALTER TABLE Customers -- ALTER = Update tabeli 'Customers'
DROP COLUMN WrongColumnName--update poprzez usunięcie = dropnięcie columny 'WrongColumnName'
 
 
SELECT * FROM Customers
 
-- altering table = updatowanie tabeli + ADD = dodanie kolumny
ALTER TABLE Customers
ADD BirthDate date -- tu dajemy ADD=dodanie nowej kolumny + nazwa nowej kolumny=BirthDate +
-- + typ zmiennej tej nowej kolumny
 
SELECT * FROM Customers

-- Teraz sobie dropniemy tabelę Orders, c o by moc utworzyć jeszcze raz
DROP table Orders

CREATE TABLE Orders (
  OrderID int PRIMARY KEY,
  OrderDate datetime,
  CustomerID int
)

SELECT * FROM Orders



--WSTAWIANIE DANYCH DO TABEL !

-- wstawianie danych do tabeli Customer
SELECT * FROM Customers

INSERT INTO Customers (ID, Firstname, Lastname, BirthDate)
-- najpierw polecenie kluczowe 'INSERT' + 'INTO' + do jakiej tabeli=u nas 'Customers' +
-- + teraz podajemy nazwy kolumn tabeli, do której mają być następnie wstawione dane
VALUES (1, 'John', 'Smith', '19800105')
-- a tu poprzez słowo kluczowe 'VALUES' podajemy wartości, jakie mają być wstawione
 
INSERT INTO Customers (ID, Firstname, Lastname, BirthDate)
VALUES (2, 'Kurt', 'Wallander', '19480105')
 
-- cannot insert duplicate PRIMARY KEY
INSERT INTO Customers (ID, Firstname, Lastname, BirthDate)
VALUES (3, 'James', 'Bond', '19680413')

INSERT INTO Customers (ID, Firstname, Lastname, BirthDate)
VALUES (4, 'James', 'Bond', '19680413')
 
SELECT * FROM Customers
 
-- usunięcie wszystkich wierszy z tabeli Customer
DELETE FROM Customers -- w PyCHarmie, generalnie też się powinno podać polecenie 'WHERE',
-- ale generalnie nigdzie indziej się tego nie podaje, więc to nie jest bląd, dlatego też
-- mimo tego, że PyCharm prosi nas o polecenie 'WHERE' możemy je ominąć, klikajac po
-- prawej stronie informacji wyświetlonej na żółto 'execute'

-- czyszczenie tabeli można również wykonać za pomocą polecenia 'TRUNCATE'
   -- Różnica pomiędzy poleceniem 'truncate', a 'delete' jest pokazana ponizej
TRUNCATE TABLE Customers
/*
Ważne jest to, że polecenie TRUNCATE działa o wiele szybciej od DELETE.
Wynika to z mechanizmu działania tych poleceń.

DELETE usuwa wiersze jeden po drugim i tworzy wpis w dzienniku transakcji dla każdego
usuniętego wpisu.
TRUNCATE usuwa strony przechowujące dane i tworzy wpis jedynie dla tych stron.
TRUNCATE resetuje opcję AUTOINCREMENT na danej kolumnie do wartości początkowych.
W poleceniu DELETE można użyć klauzuli WHERE by usunąć jedynie pożądane dane,
czyli w polecenie DELETE jest możliwość filtrowania usuwanych wierszy, nie trzeba wszystkich
usuwać.
Zaś TRUNCATE usuwa wszystkie dane, brak możliwości filtrowania.
*/

 
-- Nullability
---------------------------------------
/*
 PK cannot contain null values
 nullability of other columns can be definied
*/
CREATE TABLE Test (
 ID int PRIMARY KEY, -- Wartości kluczy głównych nie mogą być nullem. I to jest zasada
 -- z defaultu. Dlatego tu nie ma sensu dopisywać 'not null'.
 Col2_NULL int NULL, --tu może mieć wartości 'null', ale nie musi
 Col3_NOTNULL int NOT NULL -- tu nie może mieć wartości 'null'
)
 -- i teraz wprowadzamy wartości do kolumn
INSERT INTO Test (ID, Col2_NULL, Col3_NOTNULL)
VALUES (1, 22, 33) -- tu podaliśmy wszystkie wartości
 
INSERT INTO Test (ID, Col2_NULL, Col3_NOTNULL)
VALUES (2, NULL, 33) -- tu podaliśmy w kolumnie 2 'null' więc się 'null' pokaże
 
INSERT INTO Test (ID, Col3_NOTNULL)
VALUES (3, 33) -- tutaj podaliśmy dwie wartości, ale z racji, że 2 kolumna może zawierać
-- 'nulle', to program z defaultu 1 wartość weźmie do 1-szej kolumny, a drugą do 3-ej.
-- Zaś do drugiej wrzuci 'null', bo nic nie zostało podane + może tam być 'null'.
 
SELECT * FROM Test
 
-- - 3nd column must not contain null values
INSERT INTO Test (ID, Col2_NULL, Col3_NOTNULL)
VALUES (4, 22, NULL) -- w tym doanui wartości(czyli potocznie mówiąc 'insercie', chcemy
-- dodać wartość 'null' dla 3ej kolumny, ale to nie przejdzie, gdyż w 3-ej kolumnie
-- zaznaczyliśmy jasno, że ma byc 'not null', czyli przy wprowadazniu tego do bazy
-- wystąpi błąd, że nie może wprowadzić tej danej.
 
-- failed for implicit defined null value
INSERT INTO Test (ID, Col2_NULL)
VALUES (5, 22) -- tu też będzie błąd, bo w 'insercie' nie wrzuciłe, kolumnt 3ej, w której
-- nie może być nulla
 
SELECT * FROM Test
 
DROP TABLE Test
 
 
 
-- Przestrzenie (schematy): Tworzenie, usuwanie
---------------------------------------
-- wiadomo, że schemat jest pod bazą danych, zaś pod schematem znajdują się tabele,
-- czyli AdvetureWork=Baza Danych, Person = Schemat, Adress=tabela.
 
-- usunięcie tabeli dbo.Customers
DROP TABLE dbo.Customers -- czasami trzeba będzie podać schemat, gdzie jest umieszczona
-- dana tabela, którą np. chcemy usunąć, bo w różnych schematach jednej bazy danych, są
-- takie same nazwy tabel, dlatego musimy zawęzić drzewko poszukiwań, żeby nie usunęło
-- i innych tabel, o tych samych nazwach, ale znajdujących się w innych schematach.
 
-- sukces ponieważ tabela Orders znajduje się w domyślnym schemacie dbo
DROP TABLE Orders
-- GO
 
CREATE SCHEMA SqlLearner -- teraz tworzenie SCHEMATU, poprzez takie samo słowo kluczowe,
-- jak przy tworzeniu tabel, czyli: 'CREATE' + teraz podaje co chcę utworzyć: 'SCHEMA' +
-- + teraz podaję nazwę schematu 'SqlLearner'
-- GO

DROP SCHEMA SqlLearner -- usuwanie schematu, też za pomocą instrukcji DROP

-- Wyświetlenie schematu aktywnego
SELECT SCHEMA_NAME(); --z tym, że nawet jak są różne schematy, to domyślnym jest zawsze 'dbo'

-- Utworzenie Tabeli w innym schemacie
CREATE TABLE SqlLearner.Customers (
  ID int PRIMARY KEY,
  Firstname nvarchar(50),
  Lastname nvarchar(50),
  BirthDate date
)
 
CREATE TABLE SqlLearner.Orders (
  OrderID int PRIMARY KEY,
  OrderDate datetime,
  CustomerID int
)
 
 
-- próba usunięcia utworzonych tabel
 
DROP TABLE SqlLearner.Customers -- wiadomo dajemy DROP do usunięcia, ale nie usuwamy tabel
-- w domyślnym schemacie 'dbo', ale w nowym 'SQlLearninig', więc oprócz tabeli, jeszcze
-- musimy podać nazwę schematu, z którego chcemy ją usunąć
 
-- niepowodzenie ponieważ tabela Orders jest w przestrzeni SqlLearner
DROP TABLE Orders -- jak będziemy tak robić DROPA, to wyrzuci błąd, bo my w schemacie 'dbo'
-- nie posiadamy takiej tabeli
 
-- sukces
DROP TABLE SqlLearner.Orders -- czyli usuwamy tą tabelę po podaniu schematu 'SQlLearner'
 
----To już koniec przykładów na osobnym schemacie.-------


---Teraz z powrotem wracamy do defaultowego schematu, jakim jest 'dbo'------

-- Identities
---------------------------------------
-- DROP TABLE Customers

DROP TABLE Customers

CREATE TABLE Customers (
  ID int IDENTITY PRIMARY KEY, -- w tym przypdaku dajemy komendę 'IDENTITY', dzięki której
  -- dodatkowy rekord dla kolumny 'ID' nie będzie podawany ręcznie, ale będzie powiększany
  -- automatycznie, własnie dzięki temu poleceniu 'Identity'. Czyli dzięki niemy ściągamy
  -- z siebie ciężar wyliczania 'ID'.
  -- Ale jedna ważna rzecz: że jak użyjemy 'Identity', to silnik (idle=program obsługujacy
  -- jakąś bazę danych) który nam wygeneruje ileś tam 'ID', to jak usuniemy np. nr = Kowal,
  -- a potem znów tego Kowala będziemy chcieli dołożyć (zinsertować), to jak najbardziej
  -- go dołożymy, ale już z najwyzszym = kolejnym w liście numerem ID
  Firstname nvarchar(50),
  Lastname nvarchar(50),
  BirthDate date
)
 
 
-- niepowodzenie
--gdyż nie możemy podać jawnie wartości kolumny ID, za nas robi to silnik tej bazy danych,
--czyli idle, który ją obsługuje i sam generuje coraz to kolejne 'ID'.Nie da się jednocześnie
--miksować funkcji 'Identity' z ręcznym zwiększaniem ID, trzeba wybrać jedną metodę.
-- Poniżej już jest dobrze.
INSERT INTO Customers (ID, Firstname, Lastname, BirthDate)
VALUES (1, 'John', 'Smith', '19800105')


-- sukces
--Tu już jest dobrze, bo z racji, że mamy funkcje 'Identity', to nie wpisujemy kolumny 'ID'
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('John', 'Smith', '19800105')
 
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('Kurt', 'Wallander', '19480105')

INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('James', 'Bond', '19980109')
 
SELECT * FROM Customers
 
-- po usunięciu wartości identity nie są ponownie użyte
DELETE FROM Customers WHERE ID = 2
 
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('James', 'Bond', '19680413')
-- Ale jedna ważna rzecz: że jak użyjemy 'Identity', to silnik (idle=program obsługujacy
  -- jakąś bazę danych) który nam wygeneruje ileś tam 'ID', to jak usuniemy np. nr = Kowal,
  -- a potem znów tego Kowala będziemy chcieli dołożyć (zinsertować), to jak najbardziej
  -- go dołożymy, ale już z najwyzszym = kolejnym w liście numerem ID
-- Czyścimy cały nasz Table


DELETE FROM  Customers -- teraz czyścimy całą naszą tabele, za pomocą polecenia 'DELETE' +
-- + oczywiście muszę dać 'Execute', bo takie ma obostrzenia PyCharm
-- ALE Ważna rzecz, że jeśli damy 'Delete' to silnik bazy danych=Idle=PyCharm, nawet
-- jak nam tą tabelę wyczyści=usunie zawartość wszystkich wierszy, to z racji, że przy
-- tworzeniu tej tabeli był użyty 'IDENTITY', to przy dodawaniu kolejnych wierszy,
-- kolumna 'ID' utworzona przy pomocy funkcji 'IDENTITY', wystartuje już od tego ostatniego
-- numeru ID, który być podczas usuwania = Delete, czyli ostatni numer był 4, to teraz jak
-- dodamy nowy wiersz, to jego ID będzie równe 5, a  nie 1.
-- Żeby wystartować od początku, trzeba użyć funkcji 'TRUNCATE'

SELECT * FROM Customers

INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('James', 'Bond', '19680413')

SELECT * FROM Customers

INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('James', 'Bond', '19680413')
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('James', 'Bond', '19680413')

-- Ale po Truncate już lecimy od początku, czyli ID, nie kontynujemy od ostatniego przed
-- usunięciem, ale staryujemy od 1
TRUNCATE TABLE Customers

INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('James', 'Bond', '19680413')

SELECT * FROM Customers
 
 
 
 
-- Klucze obce (foreign keys)
---------------------------------------
DROP TABLE Customers
DROP TABLE Orders
 
-- klucze obce niesą wymagane do łączenia tabel
-- ale pomagają egzekwować integralność referencyjną
 
-- przykład nr 1 - bez kluczy obcych
CREATE TABLE Customers (
  ID int IDENTITY PRIMARY KEY, -- Ważne: w tabeli Customers, Primary key to kolumna ID
  -- to będzie miało znaczenie, przy tworzeniu 'Foreign Key'=kluczy obcych
  Firstname nvarchar(50),
  Lastname nvarchar(50),
  BirthDate date
)
 
CREATE TABLE Orders (
  OrderID int IDENTITY PRIMARY KEY,--Ważne: w tabeli Orders, Primary key to kolumna OrderID
  OrderDate datetime,
  CustomerID int
)
 
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('John', 'Smith', '19800105')
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('Kurt', 'Wallander', '19480105')
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('James', 'Bond', '19680413')
 
 
SELECT * FROM Customers
 
 
-- nowe zamówienie z jawnie określoną datą zamówienia orderDate dla klienta o id 1
INSERT INTO Orders (OrderDate, CustomerID)
VALUES ('20111115 12:20:45', 1) -- tu w kolumnie OrderDate podajemy datę i godzinę,
-- co nam oczywiście je doda. Zaś ciekawa funkcja jest poniżej z aktualną datą i godziną !
 
-- nowe zamówienie z bieżącą datą zamówienia orderDate dla klienta o id 2
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 2) -- tu używamy polecenia 'GETDATE', która pobiera z systemu
-- aktualną datę + godzinę
 
SELECT * FROM Orders
 
-- nowe zamówienie z bieżącą datą zamówienia orderDate dla nieistniejącego klienta
-- naruszona integralność referencyjna
-- zapytanie zakończone powodzeniem
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 10)
 
--- PIERWSZY SPOSÓB definiowania KLUCZY OBCYCH ---
-- przykład nr 2 - z kluczem obcym
DROP TABLE Orders
 
CREATE TABLE Orders (
  OrderID int IDENTITY PRIMARY KEY, --Ważne: to jest Primary key w kolumnie OrderID,
  -- w tej tabeli, czyli w tabeli 'Orders'
  OrderDate datetime,
  CustomerID int FOREIGN KEY REFERENCES Customers(ID) -- logika tworzenia klucza obcego to:
  -- nowa kolumna=CustomerID -> jego właściwości to intiger='int'
  -- -> jest kluczem obcym='FOREIGN KEY' -> odnosi się='REFERENCES' -> tabeli='Customers'
  -- -> kolumny='ID'
  -- czyli tu mamy sytuacje, że dodajemy
  -- nową kolumnę 'CustomerID', która jest Primary Key, dla tabeli 'Customers' - ale tutaj
  -- ta jest ta kolumna traktowana jako 'Foreign Key', bo odnosi się do kolumny, która
  -- jest kluczem głównym w innej tabeli
)

SELECT * FROM Orders
 
INSERT INTO Orders (OrderDate, CustomerID)
VALUES ('20111115 12:20:45', 1)
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 2)

-- Poniższy 'INSERT'=dodanie nowych wartości nie przechodzi, gdyż
-- nowe zamówienie z bieżącą datą zamówienia orderDate jest dla nieistniejącego klienta
-- w tabeli 'Customer', którego oczywiście nie da się dodać, dlatego wyskakuje błąd,
-- bo jak wiemy, uzależniliśmy dane tabeli 'Orders' od klucza obcego 'CustomerID' dla
-- tabeli Customers - a że tam nie ma CustomerID=10, tylko do 5, to wyrzuci błąd.
-- Po prostu została naruszona integralność referencyjna=zapytanie zakończone niepowodzeniem
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 10)
 
SELECT * FROM Orders


--- DRUGI SPOSÓB definiowania KLUCZY OBCYCH ---
-- nazwanie ograniczeń zwiększa czytelność
 
DROP TABLE Orders
 
CREATE TABLE Orders ( -- Tu tworzymy sobie tabelę Orders , na razie bez Foreign Key,
-- ale z kolumną, która jest widoczna w tabeli 'Customers'
  OrderID int IDENTITY,
  OrderDate datetime,
  CustomerID int
)

use wiltos;


--> i teraz DEFINIUJEMY nasz Foreign Key, JAKO STAŁĄ, w osobnym zapytaniu (tym poniższym).
-- Ale żeby to zrobić musimy zrobić update naszej tabeli 'Orders', co oczywiście robimy
-- poprzez użycie funkcji 'ALTER'
ALTER TABLE Orders -- za pomocą 'ALter' update tabeli 'Orders'
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID) -- i teraz dodanie stałej,która
-- będzie kluczem obcym, z logiką jak poniżej:
-- startujemy z funkcją dodawania='ADD' -> stałej='CONSTRAINT' -> nazywamy ją sobie, u nas to:
-- 'FK_Orders_Customers_ID', gdzie tą nazwę możemy sobie rozszyfrować: FK=foreign key,
-- Orders= to będzie w  tabeli Orders + następniesię będzie odnosił się do tabeli 'CustomerID'
-- + do kolumny 'ID' ---ALE DALEJ TO JEST TYLKO NAZWA NASZEJ SATŁEJ ->
-- -> stała 'FK_Orders_Customers_ID' jest kluczem obcym = 'FOREIGN KEY'
-- -> na kolumnie 'CustomerID'
REFERENCES Customers (ID)--ale musimy jeszcze podać, że my odnosimy się do tabeli 'Customers'
-- i do kolumny 'ID'
GO

-- I teraz jak sobie wejdziemy w strukturę 'Database'(ta po prawej stronie), żeby sprawdzić,
-- czy ten foreign key został dodany  + oczywiście rozwiniemy tabelę 'Orders',
-- to pojawi nam się foreign key=FK_Orders_Customers_ID. Czyli sukces!

SELECT * from Orders

INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 10) --teraz sobie robimy insert danych, czy po utworzeniu foreign key=
-- =FK_Orders_Customers_ID, wszystko działa -- ale wiadomo, że to ID=10 nie istnieje, więc
-- się dodanie tego  NIE POWIEDZIE.


ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Customers_ID -- ale możemy sobie naszą stałą
-- foreign key=FK_Orders_Customers_ID też usunąć, używając funkcję DROP, ale musimy
-- pokazać na jakiej tabeli chcemy ten update robić, czyli dla tabeli Orders=TABLE  Orders
GO


INSERT INTO Orders (OrderDate, CustomerID)
-- Usunęliśmy naszą stałą - znowu można zrobić insert danych niespójnych pomiędzy dwoma
-- tabelami, czyli Customers i Orders, bo nie ma między nimi powiązania, czyli możemy
-- sobie do tabeli 'Orders' dodawać bez konsekwencji kolumnę, która nie ma takich wartości
-- dla tabeli Customers.
VALUES (GETDATE(), 10)
 
SELECT * FROM Orders
 
/*
CHECK to kolejne ograniczenie (CONSTRAINTS) które można nadać na kolumny w tabeli.
Ogranicza ono zakres wartości które mogą się pojawić w kolumnie.
Ograniczenie to możemy nałożyć na jedną kolumnę, wtedy ognicza ono wartości
we wskazanej kolumnie lub nałożyć je na wiele kolumn. Ograniczenie CHECK
możemy nadać w momencie tworzenia nowej tabeli (Create 'new table'.. lub na już istniejącej
tabeli (z użyciem polecenia ALTER).
  - Ponizej przykład uzycia check, przy tworzeniu nowej tabeli:
CREATE TABLE Pracownicy
(
ID_pracownik int NOT NULL CHECK (ID_pracownik >0)
,Imie varchar(20)
,Nazwisko varchar(50)
,Adres varchar(50)
,Email varchar(30)
,Telefon int
)

  - Ponizej przykład uzycia check, przy edycji już istniejącej tabeli:
ALTER TABLE Pracownicy
ADD CHECK (ID_pracownik > 0)
*/
ALTER TABLE Orders WITH CHECK -- wartość domyślna w naszym przypadku przy definiowaniu klucza
-- głównego, w tabeli 'Orders', który powyżej w linii 461, przy tworzeniu nowej tabeli nie
-- zostal zrobiony
ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID)
GO
 
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 10)

SELECT * from Orders

ALTER TABLE Orders  WITH NOCHECK -- !
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID) -- teraz znowu dodajemy
-- klucz obcy do tabeli 'Customer' (po ostatnim usunięciu nie dodawaliśmy go). Oczywiście
-- możemy sobie podejrzeć, czy się pojawił jak rozwiniemy sobie tabelę 'Orders'
-- i opcję Foreign Keys i tam go zobaczymy
REFERENCES Customers (ID)
GO
 
SELECT * FROM Orders
 
-- dziwna składnia... niepowodzenie z powodu niespójnych danych, polegająca na tym, że
-- znów chcemy dodać klucz obcy, który już powyżej dodalismy, z tą samą nazwą - także
-- wiadomo, że program tego nie przyjmie
ALTER TABLE Orders WITH CHECK CHECK CONSTRAINT FK_Orders_Customers_ID
 
-- usunięcie wszystkich wierszy...
DELETE FROM Orders
 

ALTER TABLE Orders WITH CHECK CHECK CONSTRAINT FK_Orders_Customers_ID
-- dziwna składnia...
-- sukces, bo wcześniej za pomocą Delete wyczyściliśmy wszystkie kolumny i mimo tego, że
-- użyliśmy znów tej samej zmiennej nie wystąpił błąd, ale ta zmienna oczywiście
-- nie zduplikowała się, tylko dalej jest jedna.
 
 
 
 
--- Opcja DELETE CASCADE i UPDATE CASCADE ---
/*
- Czym jest Cascade Delete i UPDATE CASCADE?
Cascade Delete i update to proces automatycznego usuwania/updatowania powiązanych wierszy
w relacyjnych bazach danych. Polega on na usuwaniu/updatowaniu wierszy związanych kluczem
obcym z tabeli nadrzędnej, co prowadzi do automatycznego usunięcia/updatu wszystkich
powiązanych wierszy z tabeli podrzędnej.
Dzięki temu operacja usuwania/updatu jest bardziej efektywna, ponieważ nie trzeba ręcznie
usuwać/updatować każdego powiązanego wiersza.

- Jak działa Cascade Delete i Cascade Update?
Cascade Delete i Update to mechanizm służący do automatycznego usuwania/updatu powiązanych
rekordów z tabeli nadrzędnej w relacyjnej bazie danych. Oznacza to, że gdy usuniemy/updatujemy
rekord z tabeli rodzica, wszystkie powiązane z nim rekordy w tabeli potomnej zostaną
usunięte/zupdatowane w sposób automatyczny. Dzięki temu nie musimy ręcznie usuwać/updatować
rekordów zależnych, co znacznie ułatwia pracę z bazą danych i minimalizuje ryzyko popełnienia
błędów przy usuwaniu/updatowaniu rekordów.
 */


-- wstawienie testowych danych do tabeli 'Orders', które są powiązane z kluczem obcym
-- z naszymi Klientami z tabeli 'Clients'
-- żeby móc użyć polecenie 'Delete Cascade'
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 1)
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 2)
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 2)
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 2)
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 3)
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 3)
 
SELECT * FROM Orders
SELECT * FROM Customers
-- w tabeli 'Customer' Primary Key to ID, zaś w tabeli 'Orders' 'CustomerID' to klucz obcy

-- niepowodzenie ze względu na więzy integralności pomiędzy tabelą Orders i Customers.
-- Za pomocą samego Delete, nie można usunąć czegoś, co jest również zawarte w innej tabeli.
-- Do tego trza będzie użyć 'Cascade Delete'!
-- nie możemy usunąć klienta posiadającego zamówienie
DELETE FROM Customers WHERE ID = 1 -- NIEPOWODZENIE - wytłumaczenie powyżej.
 
-- możemy zmienić to zachowanie poprzez opcję CASCADE
/*
[ ON DELETE { NO ACTION | CASCADE | SET NULL | SET DEFAULT } ]
[ ON UPDATE { NO ACTION | CASCADE | SET NULL | SET DEFAULT } ]
 
NO ACTION
 Opcja DEFAULTOWA
ON DELETE/ON UPDATE NO ACTION
 Określa, że jeśli zostanie podjęta próba usunięcia wiersza za pomocą
 klucz, do którego odwołują się klucze obce w istniejących wierszach w innych tabelach,
 zgłaszany jest błąd i instrukcja DELETE jest wycofywana
*/
 
-- ON UPDATE CASCADE
ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Customers_ID
 
ALTER TABLE Orders -- teraz robimy update tabeli Orders, co by skorzystać z 'Cascade'
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID) -- za pomocą polecenia
-- CONSTRAINT znów dodajemy stałą o nazwie 'FK_Orders_Customers_ID', która będzie FK(kluczem
-- obcym), i który będzie kolumną 'CustomerID', oczywiscie dla tabeli 'Orders', bo jak widać
-- robimy ALTER dla tabeli 'Orders'
REFERENCES Customers ([ID]) -- tu poprzez REFERENCE, widzimy, że ten klucz obcy 'CustomerID'
-- z tabeli Orders odnosi się do klucza głownego 'ID' w tabeli 'Customers'
-- (oczywiście klucze to nazwy kolumn)
 ON DELETE CASCADE -- kaskadowo usuwamy dane
 ON UPDATE CASCADE -- kaskadowo edytujemy dane
GO
 
 
SELECT * FROM Orders WHERE CustomerID = 1
SELECT * FROM Customers
SELECT * FROM Orders
 
-- Teraz usuwanie się uda -> kaskadowo usuniemy zamówienie z tabeli 'Order', dla której ten
-- CustomerID jest FK odnośnie do tabeli 'Customer', z której poprzez powiązanie Kaskadowe
-- również usuwamy zawartość ID=1, powiązanego z kluczem głownym.


DELETE FROM Customers WHERE ID = 1 -- to nie wyrzuci błedu, ale tak de facto ten ID=1 został
-- usunięty kaskadowo - powyżej

SELECT * FROM Orders
SELECT * FROM Customers
 
 
 
-- ON UPDATE SET NULL
ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Customers_ID
 
ALTER TABLE Orders 
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID)
REFERENCES Customers ([ID])
 ON DELETE SET NULL -- podczas usuwania ustawiaj mi tą wartość na Null, co polega na tym, że
-- zgodnie z komendą poniżej 'DELETE FROM Customers WHERE ID = 2' usunie nam ID=2 z tabeli
-- 'Customer', a te wartości 2, które były w tabeli 'Customers' i kolumnie 'CustomerID'
-- zmienią się w nulle, bo wiadomo, że ID=2, zostało usunięte z powiązanej tabli 'Customers'
 ON UPDATE SET NULL -- podczas edytowania ustawiaj mi tą wartość na Null
GO
 
 
SELECT * FROM Orders
SELECT * FROM Customers
 
-- Teraz ustawimy wartość null
DELETE FROM Customers WHERE ID = 2

-- Widzimy ordery z wartością null
SELECT * FROM Orders
SELECT * FROM Customers
 
 
 
---------------------------------------
---------------------------------------
-- Wartości domyślne (defaults)
---------------------------------------
DROP TABLE Orders
DROP TABLE Customers
 
CREATE TABLE Customers (
  ID int IDENTITY PRIMARY KEY,
  Firstname nvarchar(50),
  Lastname nvarchar(50),
  BirthDate date
)

INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('John', 'Smith', '19800105')
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('Kurt', 'Wallander', '19480105')
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('James', 'Bond', '19680413')
 
 
SELECT * FROM Customers
 
CREATE TABLE Orders (
  OrderID int IDENTITY PRIMARY KEY,
  OrderDate datetime DEFAULT GETDATE(), -- Wartość domyślna dla kolumny 'OrderDate' będzie
  -- 'GETDATE', który nam zwróci aktualną datę/czas teraz.
  CustomerID int -- CustomerID na razie nie jest kluczem obcym
)

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID) --teraz 'CustomerID' zmienia
-- się w klucz obcy, bo dodaliśmy Referencje, że ma się odnosić do tabeli 'Customers' i
-- kolumny 'ID', która to w tabeli Customers jest kluczem głównym, czyli w ten sposób te
-- 2 tabele są ze sobą powiązane
REFERENCES Customers (ID)
GO
 
-- w tabeli Orders możemy jawnie podać wartość dla kolumny z zadeklarowaną wartością
-- domyślną
INSERT INTO Orders (OrderDate, CustomerID)
VALUES ('20110812', 1) -- tu jawnie, na sztywno, tzw. HardCodowo podajemy, co ma być wpisane.
--Ale HardCoding tu nie jest najlepszy, bo jak trzeba będzie zmienić datę, to trzeba będzie
-- się wrócić do kodu i tą zmianę zrobić ręcznie. Gdzie przeciwieństwem jest rozwiązanie
-- poniżej, gdzie zgodnie z zadeklarowaną wcześniej wartością ma być 'GETDATE'-linia 719,
-- i w poniższym kodzie, ta wartość daty będzie pobierana z automatu, i za każdym razem jak
-- się zmieni w systemie (bo GETDATE pobiera dane z systemu) to po wywołaniu tabeli będzie
-- wartość aktualna.


SELECT * FROM Orders
 
-- natomiast jeżeli pominiemy kolumnę z zadeklarowaną wartością domyślną sql server
-- wstawi za nas odpowiednią wartość - wytłumaczenie powyżej - linia 736-741.
INSERT INTO Orders (CustomerID) VALUES (2)
SELECT * FROM Orders
 
-- ten sam rezultatco powyżej, ale z użyciem słowo kluczowego 'default' - ale raczej tak
-- się nie stosuje.
INSERT INTO Orders (OrderDate, CustomerID) VALUES (DEFAULT, 2)
SELECT * FROM Orders
 
 
-- drugi sposób definiowania wartości domyślnych
-- nazwanie ograniczeń zwiększa czytelność
 
DROP TABLE Orders
 
CREATE TABLE Orders (
  OrderID int IDENTITY,
  OrderDate datetime,
  CustomerID int
)
 
ALTER TABLE Orders
ADD CONSTRAINT DF_OrderDate
DEFAULT GETDATE() FOR OrderDate
 
ALTER TABLE Orders
ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID)
GO
 
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID)
REFERENCES Customers (ID)
GO

SELECT * from Orders
SELECT * from Customers

-- WAŻNE: dane które wprowadzamy, możemy wprowadzić za pomocą jednej linii, nie trzeba
-- powtarzać Inserta ileś tam razy, tak jak to jest poniżej, możemy to zrobić tak:
-- 'INSERT INTO Orders (CustomerID) VALUES (1), (1), (2), (3)'
INSERT INTO Orders (CustomerID) VALUES (1)
INSERT INTO Orders (CustomerID) VALUES (1)
INSERT INTO Orders (CustomerID) VALUES (2)
INSERT INTO Orders (CustomerID) VALUES (3)
 
DELETE FROM Orders
 
-- jak dodać więcej niż jedną wartość w jednym zapytaniu
INSERT INTO Orders (CustomerID) VALUES (1), (1), (2), (3)
 
SELECT * FROM Customers
SELECT * FROM Orders
 
 
---------------------------------------
---------------------------------------
-- Klauzula sprawdzająca check
/*
CHECK to kolejne ograniczenie (CONSTRAINTS) które można nadać na kolumny w tabeli.
Ogranicza ono zakres wartości które mogą się pojawić w kolumnie.
Ograniczenie to możemy nałożyć na jedną kolumnę, wtedy ognicza ono wartości
we wskazanej kolumnie lub nałożyć je na wiele kolumn. Ograniczenie CHECK
możemy nadać w momencie tworzenia nowej tabeli (Create 'new table'.. lub na już istniejącej
tabeli (z użyciem polecenia ALTER).
  - Ponizej przykład uzycia check, przy tworzeniu nowej tabeli:
CREATE TABLE Pracownicy
(
ID_pracownik int NOT NULL CHECK (ID_pracownik >0)
,Imie varchar(20)
,Nazwisko varchar(50)
,Adres varchar(50)
,Email varchar(30)
,Telefon int
)

  - Ponizej przykład uzycia check, przy edycji już istniejącej tabeli:
ALTER TABLE Pracownicy
ADD CHECK (ID_pracownik > 0)
*/

---------------------------------------
 
DROP TABLE Orders -- usuwamy sobie dane z tabeli Orders, co by zrobić nowe porównania
DROP TABLE Customers -- usuwamy sobie dane z tabeli Customers, co by zrobić nowe porównania
 
CREATE TABLE Customers ( --tworzymy tabele Customes z nowymi kolumnami
  ID int IDENTITY,
  Firstname nvarchar(50),
  Lastname nvarchar(50),
  BirthDate date
)
 
ALTER TABLE Customers --edytujemy(ALterujemy) tabele Customers, żeby wprowadzić PK
ADD CONSTRAINT PK_Customers PRIMARY KEY (ID)
GO
 
-- wstawienie wiersza z niepoprawną datą urodzenia (przyszła data) skończyła się
-- sukcesem, bo nie mamy żadnego sprawdzenia. Poniżej takie sprawdzenie wprowadzimy, za pomocą
-- klauzulu 'CHECK'.
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('John', 'Smith', '21000105')
 
SELECT * FROM Customers
 
-- pomaga klauzula CHECK...
 
-- niepowodzenie
ALTER TABLE Customers -- WITH NOCHECK
ADD CONSTRAINT CK_BirthDate CHECK (BirthDate < GETDATE())
 
-- usuwamy niepoprawne dane
DELETE FROM Customers --tu usuwamy dane poprzednie, gdzie był rok 2100, żeby ten CHECK mógł
-- zadziałać, bo jak tego 2100 nie usunę, to CHECK nie zadziała, bo wartość powyżej
-- GETDATE jest dostępna
 
-- (powtórnie) sukces -- teraz
ALTER TABLE Customers
ADD CONSTRAINT CK_BirthDate CHECK (BirthDate < GETDATE())
 
-- (powtórnie)  wstawienie wiersza z niepoprawną datą urodzenia (przyszła data)) skonczy się
-- niepowodzeniem, bo wstawiliśmy ograniczenie 'CHECK', które pozwala wstawić tylko te daty,
-- które są poniżej obecnej daty, bo przecież nie da się urodzić po obecnej dacie.. ;)
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('John', 'Smith', '21000105')
 
-- sukces - bo dana poniżej obecnej daty
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('John', 'Smith', '19800105')

select * from Customers;
 
GO
 
CREATE TABLE Orders (
  OrderID int IDENTITY,
  OrderDate datetime,
  CustomerID int
)
GO
 
---------------------------------------
---------------------------------------
-- Widoki (views) - to są pomocnicze tabele, ale tego na razie nie będę używał
---------------------------------------
 
CREATE VIEW vNamesOfCustomers
AS
SELECT c.Firstname, c.Lastname
FROM Customers AS c
 
 
SELECT * FROM vNamesOfCustomers
 
 
CREATE VIEW vOrders
AS
SELECT o.OrderID, o.OrderDate, o.CustomerID, c.Firstname, c.Lastname
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.ID
GO
 
SELECT * FROM vOrders
GO
 
ALTER VIEW vOrders
AS
SELECT o.OrderID, o.OrderDate, o.CustomerID, c.Firstname + ' ' + c.Lastname AS FullName
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.ID
GO
 
SELECT * FROM vOrders
GO
 
DROP VIEW vOrders
GO
 
 
CREATE VIEW vNoOfOrders
AS
SELECT c.ID, c.Firstname, c.Lastname, COUNT(*) AS NoOfOrders
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.ID
GROUP BY c.ID, c.Firstname, c.Lastname
GO
 
SELECT * FROM vNoOfOrders ORDER BY NoOfOrders DESC