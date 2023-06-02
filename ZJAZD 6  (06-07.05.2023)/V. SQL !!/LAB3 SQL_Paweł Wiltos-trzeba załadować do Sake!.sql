-- Składnia SQL – GROUP BY
USE AdventureWorks2014


-- 1. Jakie są średnie roczne zarobki pracowników [HumanResources.Employee] Adventure Works
-- według stanowisk? [humanresources.employeepayhistory]

SELECT e.JobTitle, -- jak już zaliasuje, to wszędzie te Aliasy dawać
       AVG(Rate) AS Srednia
from HumanResources.Employee as e

         left join HumanResources.EmployeePayHistory as eph on e.BusinessEntityID = eph.BusinessEntityID
group by JobTitle


select *
from humanresources.employee

select *
from humanresources.EmployeePayHistory


-- 2. Jakie jest łączne zamówienie dla każdego klienta, który kupił produkty Adventure Works w
-- 2013 roku? [Sales.SalesOrderHeader]

select *
from Sales.SalesOrderHeader


select Sales.SalesOrderHeader.CustomerID,
       sum(Sales.SalesOrderHeader.SubTotal) as WholeOrder,
       YEAR (Sales.salesorderheader.OrderDate) as OrderYear

from Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '20130101' AND '20131230'
group by CustomerID, OrderDate

-- poniżej z aliasami
select soh.CustomerID,
       sum(soh.SubTotal) as WholeOrder,
       YEAR (soh.OrderDate) as OrderYear

from Sales.SalesOrderHeader as soh
WHERE OrderDate BETWEEN '20130101' AND '20131230'
group by CustomerID, OrderDate

-- 3. Ile zamówień zostało złożonych przez każdego pracownika Adventure Works?
-- [Sales.SalesOrderHeader]

SELECT  SalesPersonID,
        count(soh.SalesPersonID) as SumOfOrders,
        p.FirstName + ' ' + lastname
from Sales.SalesOrderDetail as sod

    LEFT JOIN Sales.SalesOrderHeader as soh ON sod.SalesOrderID = soh.SalesOrderID
    Left Join Person.Person as p ON p.BusinessEntityID = soh.SalesPersonID
GROUP BY  SalesPersonID, p.FirstName + ' ' + lastname
order by SalesPersonID



SELECT count(*), SalesPersonID
from Sales.SalesOrderHeader
GROUP BY SalesPersonID

SELECT *
from Sales.SalesOrderDetail

SELECT *
from Sales.SalesOrderHeader

SELECT *
from Person.Person


-- 4. Jaka jest łączna ilość zamówień (LineTotal) dla każdej kategorii produktów Adventure Works?
-- [Sales.SalesOrderDetail] [Production.Product]

SELECT
        sum(sod.LineTotal) as WholeOrdersAmount,
        pc.Name as ProductsCategory
From Sales.SalesOrderDetail as sod

    LEFT JOIN Production.Product as p ON sod.ProductID = p.ProductID
    LEFT JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    left join production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID

GROUP BY pc.Name


SELECT *
from Sales.SalesOrderDetail

SELECT *
from Production.Product

SELECT *
from Production.ProductCategory

SELECT *
from Production.ProductSubcategory

-- 5. Znajdź średnią wartość zamówienia dla każdego klienta w 2012 roku [Sales.Customer]
-- [Sales.SalesOrderHeader]

SELECT
        avg(soh.SubTotal) as AverageSumOfOrders,
        YEAR(soh.OrderDate) AS Order2012Date,
        count(soh.SalesOrderID) AS HowManyOrders,
        c.CustomerID
    FROM Sales.SalesOrderHeader as soh

    RIGHT JOIN Sales.Customer as c ON c.CustomerID =  soh.CustomerID
WHERE OrderDate between '20120101' and '20121231'
GROUP BY c.CustomerID, YEAR(soh.OrderDate)


Select *
from Sales.Customer

SELECT *
from Sales.SalesOrderHeader



-- 6. Znajdź trzy najlepiej sprzedające się produkty (w największej ilości orderqty) w 2016 (???-użyłem 2012,
-- bo danych na 2016 rok nie ma..).
-- [Production.Product] [Sales.SalesOrderDetail] [Sales.SalesOrderHeader]

SELECT  top 3 p.Name as ProductName,
--         p.SellEndDate,
        YEAR(p.SellEndDate) AS Order2012Date,
--         sod.OrderQty,
        sum(sod.OrderQty) as SumOfQuantity
FROM Production.Product as p

    LEFT JOIN Sales.SalesOrderDetail as sod ON p.ProductID = sod.ProductID
WHERE SellEndDate >= '20120101' AND SellEndDate <= '20121231'
GROUP BY p.Name, YEAR(p.SellEndDate)
ORDER BY Sum(OrderQty) desc

SELECT *
from Production.Product

SELECT *
from Sales.SalesOrderDetail

SELECT *
from Sales.SalesOrderHeader





-- 7. Znajdź średnią wartość zamówienia dla każdego kraju. Weź pod uwagę tylko klientów którzy
-- dokonali co najmniej 10 zamówień (subquery) [Sales.Customer] [Sales.SalesOrderHeader]

----z wykorzystanem subquery-----------
--Tu mamy pierwszą część subquery, zaś drugą część subquery zaczynamy od bloku 'where'
SELECT st.Name as NameOfCountry,
    avg(soh.TotalDue) as OrderAverage
    from Sales.SalesOrderHeader as soh

    left join Sales.SalesTerritory as st ON soh.TerritoryID = st.TerritoryID



WHERE soh.CustomerID IN -- I TERAZ ROBIMY PODZAPYTANIE(SUBQUERY)
            (select c.CustomerID
                 from Sales.Customer as c
                 left join Sales.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
                 left join Sales.SalesOrderDetail as sod ON soh.SalesOrderID = sod.SalesOrderID
                 group by c.CustomerID
                 having count(soh.SalesOrderID) >= 10
                 )

group by st.Name
order by OrderAverage




---------------without subquery---------------
SELECT  st.Name as Country_Region,
--         st.SalesYTD,
        avg(st.SalesYTD) as AverageSumOfOrders,
        sod.OrderQty
--         c.CustomerID as Clients
From Sales.SalesTerritory as st

    left join Sales.Customer as c ON st.TerritoryID = c.TerritoryID
    left join Sales.SalesOrderHeader as soh ON st.TerritoryID = soh.TerritoryID
    left join Sales.SalesOrderDetail as sod ON soh.SalesOrderID = sod.SalesOrderID

WHERE sod.OrderQty >= 10
GROUP BY st.Name, st.SalesYTD, sod.OrderQty
-- HAVING count(st.SalesYTD)
order by st.SalesYTD




SELECT *
from Sales.Customer

SELECT *
from Sales.SalesOrderHeader

SELECT *
from Sales.SalesTerritory

SELECT *
from Sales.SalesOrderDetail



-- 8. Znajdź 10 najlepszych klientów pod względem wartości zamówień (TotalDue)
-- [Sales.Customer] [Sales.SalesOrderHeader]

SELECT Top 10 c.CustomerID as TheBestClients_10,
        sum(soh.TotalDue) as TheHighestOrders
FROM Sales.Customer as c

    left join Sales.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
group by c.CustomerID, soh.TotalDue
order by sum(soh.TotalDue) desc


SELECT *
from Sales.Customer

SELECT *
from Sales.SalesOrderHeader







-- 9. Napisz zapytanie, aby znaleźć 5 najlepszych sprzedawców z najwyższą średnią kwotą
-- sprzedaży na zamówienie, i uwzględnij ich Imię, Nazwisko i średnią kwotę sprzedaży na
-- zamówienie. Uporządkuj wyniki według średniej wielkości sprzedaży na zamówienie w
-- kolejności malejącej [Sales.SalesPerson] [Sales.SalesOrderHeader] [Sales.SalesOrderDetail]

SELECT  top 5 p.FirstName + ' ' + LastName as SalesName,
        AVG(soh.SubTotal) as AvgSalesForTheBestSeller
FROM Sales.SalesOrderHeader as soh
LEFT JOIN Person.Person as p ON soh.SalesPersonID = p.BusinessEntityID

group by p.FirstName + ' ' + LastName
ORDER BY AVG(SubTotal) desc




SELECT *
from Sales.SalesPerson

SELECT *
from Sales.SalesOrderHeader

SELECT *
from Sales.SalesOrderDetail

SELECT *
from Person.Person


-- 10. Napisz zapytanie, aby znaleźć 10 najlepszych produktów o najwyższej łącznej wartości
-- sprzedaży i podaj nazwę produktu, kategoria produktu i łączna kwota sprzedaży. Posortuj
-- wyniki według łącznej kwoty sprzedaży w kolejności malejącej [Production.Product]
-- [Production.ProductSubcategory] [Sales.SalesOrderDetail]

SELECT   top 10 pc.Name as CategoryOfProduct,
         p.Name as NameOfProduct,
         sum(sod.LineTotal) as ProductWithTheHighestSales

From Sales.SalesOrderDetail as sod

    left join Production.Product as p ON sod.ProductID = p.ProductID
    left join Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    left join Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID

group by p.Name, pc.Name
order by sum(sod.LineTotal) desc


SELECT *
from Production.Product

SELECT *
from Production.ProductSubcategory

SELECT *
from Production.ProductCategory

SELECT *
from Sales.SalesOrderDetail

