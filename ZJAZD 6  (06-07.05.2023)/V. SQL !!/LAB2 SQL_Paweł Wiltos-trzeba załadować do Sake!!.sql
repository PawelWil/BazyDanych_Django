--pdf ze szczegółami do bazy danych AdventureWorks2014:
-- https://www.sqldatadictionary.com/AdventureWorks2014.pdf --

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
select p.FirstName, p.LastName, d.Name FROM HumanResources.Employee e
    JOIN Person.Person p on e.BusinessEntityID = p.BusinessEntityID
    JOIN Person.EmailAddress ea on ea.BusinessEntityID = p.BusinessEntityID
    JOIN HumanResources.EmployeeDepartmentHistory dh on dh.BusinessEntityID = e.BusinessEntityID
    JOIN HumanResources.Department d on d.DepartmentID = dh.DepartmentID



-- 3. Wybierz datę zamówienia, nazwa klienta (Imię + Nazwisko) i sumę należności dla wszystkich
-- zamówień w tabeli [Sales.SalesOrderHeader], i podaj nazwę obszaru sprzedaży z tabeli
-- [Sales.SalesTerrit14551szory]

-- SELECT * from Sales.SalesOrderHeader

SELECT soh.OrderDate, soh.TotalDue, person.person.FirstName, person.person.LastName, sales.SalesTerritory.Group
FROM Sales.SalesOrderHeader as soh
         JOIN sales.SalesTerritory as st on soh.TerritoryID = st.TerritoryID
         join HumanResources.Employee as e on Person.Person.BusinessEntityID = e.BusinessEntityID




-- 4. Pobierz listę wszystkich klientów i odpowiadające im zamówienia sprzedaży [Sales.Customer]
-- [Sales.SalesOrderHeader]
-- 5. Wybierz Imię i Nazwisko wszystkich klientów [Sales.Customer] wraz z ich adresami e-mail
-- [Person.EmailAddress]
-- 6. Pobierz listę wszystkich zamówień sprzedaży [Sales.SalesOrderHeader] oraz odpowiadających
-- im klientów [Sales.Customer] do wyniku załącz adresy [Person.Address]
-- 7. Wybierz wszystkich pracowników [HumanResources.Employee] wraz z nazwami
-- departamentów. [humanresources.department]. Posortuj dane po Nazwisku malejąco i Sart
-- Date rosnąco
-- 8. Wybierz wszystkie nazwy produktów [Production.Product] wraz z ich dostawcami (tylko
-- nazwa) [Purchasing.Vendor]
-- 9. Wybierz wszystkie zamówienia pracowników [humanresources.employee] o imieniu
-- zaczynającym się na 'E' oraz metodzie dostawy zawierającej 'OVER' [purchasing.shipmethod]
-- 10. Wybierz wszystkie zamówienia [Sales.SalesOrderHeader] wraz z danymi o pracownikach
-- odpowiedzialnych za ich obsługę [HumanResources.Employee]
-- 11. Wybierz wszystkie produkty [Production.Product] z kategorii "Clothing"
-- [production.productcategory] wraz z danymi o dostawcach[Purchasing.Vendor]
-- 12. Wybierz wszystkie zamówienia złożone w 2008 roku wraz z danymi o klientach.
-- [Sales.SalesOrderHeader] [Sales.Customer]
-- 13. Wybierz wszystkie produkty [Production.Product] z ceną detaliczną (ListPrice) większą niż 25
-- dolarów wraz z danymi o dostawcach [Purchasing.Vendor]. Posortuj wyniki po cenie malejąco