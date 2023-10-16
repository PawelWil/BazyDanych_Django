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
 
-- nowe zamówienie z bieżącą datą zamówienia orderDate dla nieistniejącego klienta
-- naruszona integralność referencyjna
-- zapytanie zakończone niepowodzeniem
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 10)
 
SELECT * FROM Orders
 
-- drugi sposób definiowania kluczy
-- nazwanie ograniczeń zwiększa czytelność
 
DROP TABLE Orders
 
CREATE TABLE Orders (
  OrderID int IDENTITY,
  OrderDate datetime,
  CustomerID int
)

-- DEFINIUJEMY GO JAKO STAŁĄ
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID)
REFERENCES Customers (ID)
GO

INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 10)

ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Customers_ID
GO

-- Usunęliśmy naszą stałą - znowu można zrobić insert danych niespójnych - Nie jesteśmy ACID
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 10)
 
SELECT * FROM Orders
 
/*
WITH CHECK is default option, SQL Server checks if
data that already exist in the Order table is valid
we can also use WITH NO CHECK - SQL Server does not apply
the check to existing rows and will only check the
reference in future when rows are inserted or updated.
*/
ALTER TABLE Orders WITH CHECK -- wartość domyślna
ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID)
GO
 
INSERT INTO Orders (OrderDate, CustomerID)
VALUES (GETDATE(), 10)
 
ALTER TABLE Orders  WITH NOCHECK -- !
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID)
REFERENCES Customers (ID)
GO
 
SELECT * FROM Orders
 
-- dziwna skłądnia... niepowodzenie z powodu niespójnych danych
ALTER TABLE Orders WITH CHECK CHECK CONSTRAINT FK_Orders_Customers_ID
 
-- usunięcie wszystkich wierszy...
DELETE FROM Orders
 
-- dziwna składnia...
-- sukces
ALTER TABLE Orders WITH CHECK CHECK CONSTRAINT FK_Orders_Customers_ID
 
 
 
 
 
-- Opcja CASCADE
 
 
-- wstawienie testowych danych
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
 
-- niepowodzenie ze względu na więzy integralności
-- nie możemy usunąć klienta posiadającego zamówienie
DELETE FROM Customers WHERE ID = 1
 
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
 
ALTER TABLE Orders 
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID)
REFERENCES Customers ([ID])
 ON DELETE CASCADE -- kaskadowo usuń dane
 ON UPDATE CASCADE -- kaskadowo edytuj dane
GO
 
 
 
SELECT * FROM Orders WHERE CustomerID = 1
SELECT * FROM Customers
 
-- Teraz usuwanie się uda -> kaskadowo usuniemy zamówienie z tabeli order
DELETE FROM Customers WHERE ID = 1
 
SELECT * FROM Orders
SELECT * FROM Customers
 
 
 
-- ON UPDATE SET NULL
ALTER TABLE Orders DROP CONSTRAINT FK_Orders_Customers_ID
 
ALTER TABLE Orders 
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID)
REFERENCES Customers ([ID])
 ON DELETE SET NULL
 ON UPDATE SET NULL
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
  OrderDate datetime DEFAULT GETDATE(), -- Wartość domyślna
  CustomerID int
)

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers_ID FOREIGN KEY(CustomerID)
REFERENCES Customers (ID)
GO
 
-- możemy jawnie podać wartość dla kolumny z zadeklarowaną wartością domyślną
INSERT INTO Orders (OrderDate, CustomerID) VALUES ('20110812', 1)
SELECT * FROM Orders
 
-- jeżeli pominiemy kolumnę z zadeklarowaną wartością domyślną sql server wstawi za nas odpowiednią wartość
INSERT INTO Orders (CustomerID) VALUES (2)
SELECT * FROM Orders
 
-- ten sam rezultat... słowo kluczowe default
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
 
 
-- dane testowe
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
---------------------------------------
 
DROP TABLE Orders
DROP TABLE Customers
 
CREATE TABLE Customers (
  ID int IDENTITY,
  Firstname nvarchar(50),
  Lastname nvarchar(50),
  BirthDate date
)
 
ALTER TABLE Customers
ADD CONSTRAINT PK_Customers PRIMARY KEY (ID)
GO
 
-- wstawienie wiersza z niepoprawną datą urodzenia (przyszła data)
-- sukces
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('John', 'Smith', '21000105')
 
SELECT * FROM Customers
 
-- pomaga klauzula CHECK...
 
-- niepowodzenie
ALTER TABLE Customers -- WITH NOCHECK
ADD CONSTRAINT CK_BirthDate CHECK (BirthDate < GETDATE())
 
-- usuwamy niepoprawne dane
DELETE FROM Customers
 
-- (powtórnie) sukces
ALTER TABLE Customers
ADD CONSTRAINT CK_BirthDate CHECK (BirthDate < GETDATE())
 
-- (powtórnie)  wstawienie wiersza z niepoprawną datą urodzenia (przyszła data))
-- niepowodzenie
INSERT INTO Customers (Firstname, Lastname, BirthDate)
VALUES ('John', 'Smith', '21000105')
 
-- sukces
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
-- Widoki (views)
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