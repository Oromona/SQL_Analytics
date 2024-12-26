--1.How many people in the DB do not have a middle name? Show the query.


SELECT COUNT(
 CASE 
     WHEN [MiddleName] IS NULL THEN 1 
     ELSE NULL 
 END
) AS 'NULL MIDDLE NAMES'
FROM PERSON.PERSON;

----2. How many email addresses do not end in adventure-works.com? Show the query.
SELECT COUNT(
    CASE 
        WHEN [EmailAddress] NOT LIKE '%adventure-works.com' THEN 1 
        ELSE NULL
    END
) AS 'Null adventure-works.com'
FROM [Person].[EmailAddress];

----3. A customer has concerns with market penetration and would like a report on what states
--have the most sales between 2010-2011. Provide the data that the customer would find most relevant
--and add any additional information if required.

SELECT SST.CountryRegionCode, ROUND(SUM(SalesYTD),0) AS 'TOTAL REVENUE' 
FROM SALES.SalesTerritory AS SST
JOIN [Sales].[SalesOrderHeader] AS SSOH
ON SST.TerritoryID=SSOH.TerritoryID
WHERE SSOH.ORDERDATE BETWEEN '2010-01-01' AND '2011-12-31' 
GROUP BY SST.CountryRegionCode
ORDER BY 'TOTAL REVENUE' DESC;


--4. A ticket is escalated and asks what customers got the email promotion. 
--Please provide the information.
SELECT FirstName, LastName, EmailPromotion
FROM PERSON.Person
WHERE EmailPromotion !=0
ORDER BY 'EmailPromotion' DESC;

--5. Retrieve a list of the different types of contacts and how many of them exist in the database.
--We are only interested in ContactTypes that have 100 contacts or more.

SELECT PCT.Name, COUNT(PCT.ContactTypeID) AS 'CONTACT TYPE'
FROM PERSON.ContactType AS PCT
JOIN PERSON.BusinessEntityContact AS PBEC
ON PCT.ContactTypeID=PBEC.ContactTypeID
GROUP BY PCT.Name
HAVING  COUNT(PCT.ContactTypeID) >=100 ;

--6. Retrieve a list of all contacts which are 'Purchasing Manager' and their names

SELECT FIRSTNAME, LASTNAME,PCT.Name
FROM PERSON.Person AS PP
JOIN PERSON.BusinessEntityContact AS PBEC
ON PBEC.PersonID= PP.BusinessEntityID
JOIN PERSON.ContactType AS PCT
ON PCT.ContactTypeID= PBEC.ContactTypeID
WHERE PCT.Name= 'Purchasing Manager';


--7. Show OrdeQty, the Name and the ListPrice of the order made by CustomerID 635
SELECT NAME,OrderQty,ListPrice,SCU.CustomerID
FROM SALES.Customer AS SCU
JOIN SALES.SalesOrderHeader AS SSOH
ON SCU.TerritoryID= SSOH.TerritoryID
JOIN SALES.SalesOrderDetail AS SSOD
ON SSOD.SalesOrderID=SSOH.SalesOrderID
JOIN PRODUCTION.ProductListPriceHistory AS PPLPH
ON SSOD.ProductID= PPLPH.ProductID
JOIN SALES.STORE AS SST
ON SSOH.SalesPersonID=SST.SalesPersonID
WHERE SCU.CustomerID= 635


--8. A "Single Item Order" is a customer order where only one item is ordered.
--Show the SalesOrderID and the UnitPrice for every Single Item Order.

SELECT SalesOrderID, MAX(UnitPrice) AS UnitPrice
FROM SALES.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(*) = 1;


--9. Where did the racing socks go? List the product name and the CompanyName
--for all Customers who ordered ProductModel'Racing Socks'.

SELECT PPRO.Name AS ProductName,STOR.Name AS CompanyName,SSTE.Name AS TerritoryName
FROM Sales.SalesOrderDetail AS SSOD
JOIN Sales.SalesOrderHeader AS SSOH
ON SSOD.SalesOrderID = SSOH.SalesOrderID
JOIN Sales.Customer AS SCU
ON SSOH.CustomerID = SCU.CustomerID
LEFT JOIN Sales.Store AS STOR
ON SCU.StoreID = STOR.BusinessEntityID
JOIN Sales.SalesTerritory AS SSTE
ON SCU.TerritoryID = SSTE.TerritoryID
JOIN Production.Product AS PPRO
ON SSOD.ProductID = PPRO.ProductID
JOIN Production.ProductModel AS PPM
ON PPRO.ProductModelID = PPM.ProductModelID
WHERE PPM.Name = 'RACING SOCKS';

----10. How many products in ProductCategory 'Cranksets' have been sold to an address in 'London'?

SELECT COUNT(*) AS TotalCranksetsSold
FROM PRODUCTION.ProductSubcategory AS PPSC
JOIN PRODUCTION.ProductCategory AS PPC
ON PPSC.ProductCategoryID=PPSC.ProductCategoryID
JOIN Production.Product AS PPRO
ON PPRO.ProductSubcategoryID= PPSC.ProductSubcategoryID
JOIN SALES.SalesOrderDetail AS SSOD
ON PPRO.ProductID= SSOD.ProductID
JOIN SALES.SalesOrderHeader AS SSOH
ON SSOH.SalesOrderID=SSOD.SalesOrderID
JOIN SALES.SalesTerritory AS SSTE
ON SSTE.TerritoryID= SSOH.TerritoryID
JOIN PERSON.StateProvince AS PSP
ON PSP.CountryRegionCode= SSTE.CountryRegionCode
JOIN PERSON.ADDRESS AS PAD
ON PAD.StateProvinceID= PSP.StateProvinceID
WHERE PPSC.Name ='CRANKSETS' AND PAD.City = 'LONDON'


----11. Show the best-selling item by value.
SELECT TOP 1
PPRO.Name, ROUND(SUM(SSOD.LINETOTAL),0) AS 'BEST-SELLING ITEM' 
FROM SALES.SalesOrderDetail AS SSOD
JOIN PRODUCTION.Product AS PPRO
ON PPRO.ProductID= SSOD.ProductID
GROUP BY PPRO.Name
ORDER BY 'BEST-SELLING ITEM' DESC
