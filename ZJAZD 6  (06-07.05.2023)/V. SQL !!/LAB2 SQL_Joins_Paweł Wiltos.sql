--pdf ze szczegółami do bazy danych AdventureWorks2014:
-- https://www.sqldatadictionary.com/AdventureWorks2014.pdf --
-- !!!Zeby uruchomić kod, zaznaczam go --> daję ctr+ent -->
-- SELECT Product.Name --> tu z tabeli 'Produkt', kolumnę 'Name'
-- from Production.Product --> z bazy danych AdventureWorks2014(ten schemat jest uruchomiony powyzej),
-- ze schematu 'Production', tabeli 'Product'. Ale jak nie ma schematów, to od razu Production jest Bazą Danych.
-- tu tak jest bo ta baza jest mega rozbudowana i zanim dojdziemy do tabeli musimy wejsć w DB, a potem w schemat


-------- Składnia SQL – JOINs
USE AdventureWorks2014

-- 1. Wybierz nazwę produktu i cenę katalogową dla wszystkich produktów w tabeli
-- [Production.Product] i dołącz nazwę kategorii produktów [Production.ProductCategory]
select p.Name as ProductName, p.ListPrice, pc.Name as CategoryName
FROM Production.Product as p
         JOIN Production.ProductSubcategory as psc ON psc.ProductCategoryID = p.ProductSubCategoryID
         JOIN Production.ProductCategory as pc ON pc.ProductCategoryID = psc.ProductCategoryID


-- 2. Wybierz imię, nazwisko i adres e-mail dla wszystkich pracowników w
-- [HumanResources.Employee] i podaj nazwy działu z tabeli [HumanResources.Department]
select p.FirstName, p.LastName, d.Name
FROM HumanResources.Employee e
         JOIN Person.Person p on e.BusinessEntityID = p.BusinessEntityID
         JOIN Person.EmailAddress ea on ea.BusinessEntityID = p.BusinessEntityID
         JOIN HumanResources.EmployeeDepartmentHistory dh on dh.BusinessEntityID = e.BusinessEntityID
         JOIN HumanResources.Department d on d.DepartmentID = dh.DepartmentID


-- 3. Wybierz datę zamówienia, nazwa klienta (Imię + Nazwisko) i sumę należności dla wszystkich
-- zamówień w tabeli [Sales.SalesOrderHeader], i podaj nazwę obszaru sprzedaży z tabeli
-- [Sales.SalesTerrit14551szory]

-- SELECT * from Sales.SalesOrderHeader

SELECT soh.OrderDate,
       p.FirstName + ' ' + LastName as Client, -- Tu robimy konkatenację
       soh.TotalDue,
       st.[Group]                   as TerritoryName
FROM Sales.SalesOrderHeader as soh

         JOIN sales.SalesTerritory as st on soh.TerritoryID = st.TerritoryID

         JOIN Sales.Customer as c on c.CustomerID = soh.CustomerID -- SalesCustomer to tabela pośrednia

         JOIN Person.Person as p on c.PersonID = p.BusinessEntityID


Select *
from Sales.SalesOrderHeader

SELECT *
from Sales.SalesTerritory
-- Territory ID - klucz, po którym się połącze z soh

SELECT *
from Person.Person
-- 'BusinessEntityID' ten klucz będzie nam potrzebny = i jest on tożsamy z 'PersonID'

SELECT *
from Sales.Customer
-- tu mamy personID, który jest tożsamy z BusinessEntityID


-- 4. Pobierz listę wszystkich klientów i odpowiadające im zamówienia sprzedaży [Sales.Customer]
-- [Sales.SalesOrderHeader]

SELECT c.CustomerID,
       soh.SalesOrderID
from sales.Customer as c -- teraz poprzez c aliasuje tabelę

         LEFT JOIN Sales.SalesOrderHeader as soh on c.CustomerID = soh.CustomerID

SELECT *
from Sales.Customer

SELECT *
from Sales.SalesOrderHeader


-- 5. Wybierz Imię i Nazwisko wszystkich klientów [Sales.Customer] wraz z ich adresami e-mail
-- [Person.EmailAddress]

SELECT p.FirstName + ' ' + LastName as Client,
       ea.EmailAddress -- tu nawet jak email adress nie pochodzi z sales.Customer, ale on jest powiązany z ea
-- to jest w porządku wtedy
from Sales.Customer as c

         LEFT JOIN person.Person as p on c.PersonID = p.BusinessEntityID
         LEFT JOIN Person.EmailAddress as ea on c.PersonID = ea.BusinessEntityID


SELECT *
from Sales.Customer

SELECT *
from Person.EmailAddress

SELECT *
from Person.Person

-- tak jak powyżej wemy, że PersonID jest tożsame z BusinessEntityID, czyli na ich bazie mogę te tabele połączyć


-- 6. Pobierz listę wszystkich zamówień sprzedaży [Sales.SalesOrderHeader] oraz odpowiadających
-- im klientów [Sales.Customer] do wyniku załącz adresy [Person.Address] --> zostawić na koniec

SELECT soh.SalesOrderNumber                as ListOfAllOrders,
       c.CustomerID                        as ClientNumber,
       a.PostalCode + ' - ' + AddressLine1 as ClientAdress
from Sales.SalesOrderHeader as soh

         Left Join Sales.Customer as c ON soh.CustomerID = c.CustomerID
         LEFT JOIN Person.Address as a ON soh.ShipToAddressID = a.AddressID


SELECT *
from Sales.SalesOrderHeader

SELECT *
from Sales.Customer
--CustomerID(c) = CustomerID(soh)

SELECT *
from Person.Address
-- AdressID(a) = ShiptoAdressID(soh)


-- 7. Wybierz wszystkich pracowników [HumanResources.Employee] wraz z nazwami
-- departamentów. [humanresources.department]. Posortuj dane po Nazwisku malejąco i Sart
-- Date rosnąco


SELECT e.JobTitle    as AllWorkers,
       d.Name        as WorkerDepartment,
       edh.StartDate as Date
From HumanResources.Employee as e

         LEFT JOIN HumanResources.EmployeeDepartmentHistory as edh ON e.BusinessEntityID = edh.BusinessEntityID
         LEFT JOIN HumanResources.Department as d ON d.DepartmentID = edh.DepartmentID
order by JobTitle desc, StartDate Asc


SELECT *
from HumanResources.Employee

SELECT *
from HumanResources.Department
--DepartmentID(d) = DepartmentID(edh)

SELECT *
from HumanResources.EmployeeDepartmentHistory
--BusinessEntity(edh) = BusinessEntity(e)


-- 8. Wybierz wszystkie nazwy produktów [Production.Product] wraz z ich dostawcami (tylko
-- nazwa) [Purchasing.Vendor]

SELECT p.Name as ProductName,
       v.Name as PurchasingVendorName
from Production.Product as p

         LEFT JOIN Purchasing.PurchaseOrderDetail as pod ON p.ProductID = pod.ProductID
         Left JOIN Purchasing.PurchaseOrderHeader as poh ON poh.PurchaseOrderID = pod.PurchaseOrderID
         Left Join Purchasing.Vendor as v ON poh.VendorID = v.BusinessEntityID


Select *
from Production.Product

Select *
from Purchasing.Vendor

SELECT *
from Purchasing.PurchaseOrderHeader

SELECT *
from HumanResources.EmployeeDepartmentHistory

SELECT *
from Purchasing.PurchaseOrderDetail


-- 9. Wybierz wszystkie zamówienia pracowników [humanresources.employee] o imieniu
-- zaczynającym się na 'E' oraz metodzie dostawy zawierającej 'OVER' [purchasing.shipmethod]

SELECT poh.PurchaseOrderID          as AllOrders,
       p.FirstName + ' ' + LastName as Client,
       sm.Name                      as MethodOfShipmentWithOver
From Purchasing.PurchaseOrderHeader as poh


        LEFT JOIN Person.Person as p ON p.BusinessEntityID = poh.PurchaseOrderID
        LEFT JOIN Purchasing.ShipMethod as sm ON poh.ShipMethodID = sm.ShipMethodID
WHERE Name LIKE '%over%'
  And FirstName LIKE 'e%'


SELECT *
from purchasing.ShipMethod

SELECT *
from Purchasing.PurchaseOrderHeader

SELECT *
from Person.Person

SELECT *
from HumanResources.Employee

-- 10. Wybierz wszystkie zamówienia [Sales.SalesOrderHeader] wraz z danymi o pracownikach
-- odpowiedzialnych za ich obsługę [HumanResources.Employee]

SELECT soh.SalesOrderNumber as AllOrders,
       e.JobTitle           as WorkersData
From Sales.SalesOrderHeader as soh


         LEFT JOIN Purchasing.ShipMethod as sm ON soh.ShipMethodID = sm.ShipMethodID
         LEFT JOIN Purchasing.PurchaseOrderHeader as poh ON sm.ShipMethodID = poh.ShipMethodID
         LEFT JOIN HumanResources.Employee as e ON poh.PurchaseOrderID = e.BusinessEntityID

SELECT *
from Sales.SalesOrderHeader

SELECT *
from HumanResources.Employee

SELECT *
from Person.Person

SELECT *
from Purchasing.PurchaseOrderHeader

SELECT *
from purchasing.ShipMethod


-- 11. Wybierz wszystkie produkty [Production.Product] z kategorii "Clothing"
-- [production.productcategory] wraz z danymi o dostawcach[Purchasing.Vendor]

SELECT p.Name  as AllProducts,
       pc.Name as ClothingCategoryProducts,
       v.Name  as SuppliersName
from Production.Product as p

        LEFT JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
        LEFT JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
        Left Join Purchasing.ProductVendor as pv ON p.ProductID = pv.ProductID
        Left Join Purchasing.Vendor as v ON pv.BusinessEntityID = v.BusinessEntityID


WHERE pc.Name = 'Clothing'


SELECT *
from Production.Product

SELECT *
from Production.ProductCategory

SELECT *
from Purchasing.Vendor

SELECT *
from Purchasing.ProductVendor

SELECT *
from Purchasing.PurchaseOrderHeader

SELECT *
from Production.ProductSubcategory

-- SELECT *
-- from  purchasing.ShipMethod

SELECT *
from Purchasing.PurchaseOrderHeader

-- 12. Wybierz wszystkie zamówienia złożone w 2008 roku wraz z danymi o klientach.
-- [Sales.SalesOrderHeader] [Sales.Customer] --> bład w dacie, minimum od 2011.

SELECT soh.OrderDate as OrderDATES,
       c.CustomerID  as ClientsID
from Sales.SalesOrderHeader as soh

         left join Sales.Customer as c ON soh.CustomerID = c.CustomerID
WHERE soh.OrderDate between '20080101' and '20081230'
-- nie ma dat poniżej 2011, więc dlatego się nic nie wyświetla
-- w kolumnie OrderDates




SELECT soh.OrderDate as OrderDATES,
       c.CustomerID  as ClientsID
from Sales.SalesOrderHeader as soh

         left join Sales.Customer as c ON soh.CustomerID = c.CustomerID
WHERE soh.OrderDate between '20120101' and '20121231'
-- teraz jest data np. 2012

SELECT *
from Sales.SalesOrderHeader

SELECT *
from Sales.Customer


-- 13. Wybierz wszystkie produkty [Production.Product] z ceną detaliczną (ListPrice) większą niż 25
-- dolarów wraz z danymi o dostawcach [Purchasing.Vendor]. Posortuj wyniki po cenie malejąco

SELECT p.ListPrice as DetalPriceBiggerThan25$,
       p.Name,
       v.Name      as SupplierName
From Production.Product as p
         LEFT JOIN Purchasing.ProductVendor as pv ON p.ProductID = pv.ProductID
         LEFT JOIN Purchasing.Vendor as v ON v.BusinessEntityID = pv.BusinessEntityID

WHERE p.ListPrice > 25
ORDER BY p.ListPrice desc


SELECT *
from Production.Product

SELECT *
from Purchasing.Vendor

SELECT *
from Purchasing.ProductVendor





