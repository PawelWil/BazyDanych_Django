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

SELECT  sod.OrderQty,
        sod.ProductID,
        sum(sod.OrderQty) as WholeOrdersAmountbyAWworkerPerProduct,
        soh.SalesPersonID
from Sales.SalesOrderDetail as sod

    LEFT JOIN Sales.SalesOrderHeader as soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY  sod.OrderQty, soh.SalesPersonID, sod.ProductID
order by SalesPersonID



SELECT *
from Sales.SalesOrderHeader

SELECT *
from Sales.SalesOrderDetail



-- 4. Jaka jest łączna ilość zamówień (LineTotal) dla każdej kategorii produktów Adventure Works?
-- [Sales.SalesOrderDetail] [Production.Product]

SELECT  sod.LineTotal,
        sum(sod.LineTotal) as WholeOrdersAmount,
        p.Name as ProductsCategory
From Sales.SalesOrderDetail as sod

    LEFT JOIN Production.Product as p ON sod.ProductID = p.ProductID

GROUP BY p.Name, sod.LineTotal


SELECT *
from Sales.SalesOrderDetail

SELECT *
from Production.Product

-- 5 (??). Znajdź średnią wartość zamówienia dla każdego klienta w 2012 roku [Sales.Customer]
-- [Sales.SalesOrderHeader]

SELECT  soh.SubTotal as WholeSumOfOrders,
        avg(soh.SubTotal) as AverageSumOfOrders,
        soh.OrderDate,
        YEAR(soh.OrderDate) AS Order2012Date,
        c.CustomerID
    FROM Sales.SalesOrderHeader as soh

    LEFT JOIN Sales.Customer as c ON soh.CustomerID = c.CustomerID
WHERE OrderDate = '2012'
GROUP BY soh.SubTotal, soh.OrderDate, c.CustomerID


Select *
from Sales.Customer

SELECT *
from Sales.SalesOrderHeader



-- 6. Znajdź trzy najlepiej sprzedające się produkty (w największej ilości orderqty) w 2016 (???-użyłem 2012,
-- bo danych na 2016 rok nie ma..).
-- [Production.Product] [Sales.SalesOrderDetail] [Sales.SalesOrderHeader]

SELECT  p.Name as ProductName,
        p.SellEndDate,
        YEAR(p.SellEndDate) AS Order2012Date,
--         sod.OrderQty,
        MAX(sod.OrderQty) as MAXOrderQuantity
FROM Production.Product as p

    LEFT JOIN Sales.SalesOrderDetail as sod ON p.ProductID = sod.ProductID
WHERE SellEndDate >= '20120101' AND SellEndDate <= '20121231'
GROUP BY p.Name, p.SellEndDate, YEAR(p.SellEndDate), sod.OrderQty
ORDER BY sod.OrderQty desc

SELECT *
from Production.Product

SELECT *
from Sales.SalesOrderDetail

SELECT *
from Sales.SalesOrderHeader





-- 7. Znajdź średnią wartość zamówienia dla każdego kraju. Weź pod uwagę tylko klientów którzy
-- dokonali co najmniej 10 zamówień (subquery) [Sales.Customer] [Sales.SalesOrderHeader]

SELECT  st.Name as Country_Region,
        st.SalesYTD,
--         avg(st.SalesYTD) as AverageSumOfOrders,
        sod.OrderQty,
        c.CustomerID as Clients
From Sales.SalesTerritory as st

    left join Sales.Customer as c ON st.TerritoryID = c.TerritoryID
    left join Sales.SalesOrderHeader as soh ON st.TerritoryID = soh.TerritoryID
    left join Sales.SalesOrderDetail as sod ON soh.SalesOrderID = sod.SalesOrderID

WHERE sod.OrderQty >= 10
GROUP BY st.Name, st.SalesYTD, sod.OrderQty, c.CustomerID
-- HAVING count(st.SalesYTD)
order by sod.OrderQty




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
-- 9. Napisz zapytanie, aby znaleźć 5 najlepszych sprzedawców z najwyższą średnią kwotą
-- sprzedaży na zamówienie, i uwzględnij ich Imię, Nazwisko i średnią kwotę sprzedaży na
-- zamówienie. Uporządkuj wyniki według średniej wielkości sprzedaży na zamówienie w
-- kolejności malejącej [Sales.SalesPerson] [Sales.SalesOrderHeader] [Sales.SalesOrderDetail]
-- 10. Napisz zapytanie, aby znaleźć 10 najlepszych produktów o najwyższej łącznej wartości
-- sprzedaży i podaj nazwę produktu, kategoria produktu i łączna kwota sprzedaży. Posortuj
-- wyniki według łącznej kwoty sprzedaży w kolejności malejącej [Production.Product]
-- [Production.ProductSubcategory] [Sales.SalesOrderDetail]