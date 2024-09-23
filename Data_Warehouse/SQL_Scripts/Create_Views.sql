USE CATASCHEVASTICA_DW;


---------------------------------------------------------------------
---------------------------------------------------------------------
-- CREATE CategoriesMart

CREATE VIEW CategoriesMart AS
SELECT ProductCategory, COUNT(DISTINCT OrderID) AS CountOfOrders, SUM(ProductQuantity) AS SumOfQuantity, AVG(Profit) AvgProfit
FROM FactSales
INNER JOIN DimProduct
ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ProductCategory;

SELECT * FROM CategoriesMart
DROP VIEW CategoriesMart
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------

-- CREATE SalesMart

CREATE VIEW SalesMart AS
SELECT
    f.OrderID,
    f.OrderStatus,
    f.OrderDate,
    f.CancelledDate,
    f.Units AS Quantity,
	f.Profit AS SoldAmount,
    c.ContactName AS CustomerName,
    c.CustomerCity,
	c.CustomerPhone,
	c.CustomerEmail,
    p.ProductName,
	p.ProductCategory,
	p.ProductCostPerUnit,
	p.ProductPricePerUnit,
	p.ProductQuantity,
    p.ProductDimensions,
	dd.DeliveryStartDate,
	dd.DeliveryEndDate,
	dd.DeliveryStatus,
	dd.Logistics_Partner_Name,
	s.SupplierName,
    d.*
FROM FactSales f
INNER JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
INNER JOIN DimProduct p ON f.ProductKey = p.ProductKey
INNER JOIN DimDate d ON d.DateKey = f.OrderDateKey
LEFT JOIN DimDelivery dd ON f.DeliveryKey = dd.DeliveryKey
LEFT JOIN DimSupplier s ON p.ProductKey = s.SupplierKey;


SELECT * FROM SalesMart
DROP VIEW SalesMart

---------------------------------------------------------------------

---------------------------------------------------------------------

-- CREATE CustomerMart

CREATE VIEW CustomerMart AS
SELECT
    c.ContactName AS CustomerName,
    c.CustomerPhone,
    c.CustomerEmail,
    c.CustomerCity,
    c.CustomerStreet,
    COUNT(DISTINCT f.OrderID) AS TotalOrders,
    SUM(f.Profit) AS TotalSpent,
    AVG(f.Profit) AS AvgOrderValue
FROM FactSales f
INNER JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.ContactName, c.CustomerPhone, c.CustomerEmail, c.CustomerCity, c.CustomerStreet;

SELECT * FROM CustomerMart;
DROP VIEW CustomerMart;
---------------------------------------------------------------------


---------------------------------------------------------------------

-- CREATE SupplierPerformanceMart

CREATE VIEW SupplierPerformanceMart AS
SELECT
    s.SupplierName,
    s.RawMaterialName,
    COUNT(DISTINCT fp.OrderID) AS OrdersFulfilled,
    SUM(fp.CostPerUnit * fp.Quantity) AS TotalCost
FROM FactProduction fp
INNER JOIN DimSupplier s ON fp.SupplierKey = s.SupplierKey
GROUP BY s.SupplierName, s.RawMaterialName;

SELECT * FROM SupplierPerformanceMart;
DROP VIEW SupplierPerformanceMart;
---------------------------------------------------------------------


---------------------------------------------------------------------

-- CREATE DeliveryStatusMart

CREATE VIEW DeliveryStatusMart AS
SELECT
    d.DeliveryStatus,
    COUNT(DISTINCT d.DeliveryID) AS NumberOfDeliveries,
    AVG(DATEDIFF(day, d.DeliveryStartDate, d.DeliveryEndDate)) AS AvgDeliveryTime
FROM DimDelivery d
GROUP BY d.DeliveryStatus;

SELECT * FROM DeliveryStatusMart;
DROP VIEW DeliveryStatusMart;
---------------------------------------------------------------------

---------------------------------------------------------------------

-- CREATE ProductSalesMart

CREATE VIEW ProductSalesMart AS
SELECT
    p.ProductCategory,
    p.ProductName,
    SUM(f.Units) AS TotalQuantitySold,
    SUM(f.Profit) AS TotalRevenue
FROM FactSales f
INNER JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.ProductCategory, p.ProductName;

SELECT * FROM ProductSalesMart;
---------------------------------------------------------------------


---------------------------------------------------------------------

-- CREATE ProductionMart 

CREATE VIEW ProductionMart AS
SELECT
    p.OrderID,
	p.Production_ID,
	p.ProductionStatus,
	p.CostPerUnit,
	p.PricePerUnit,
	p.Quantity,
	p.Product_ID,
	p.ProductName,
	pr.ProductCategory,
	s.SupplierID,
	s.SupplierName,
	s.RawMaterialName,
	s.RawMaterialCostPerUnit,
    d.*
FROM FactProduction p
INNER JOIN DimSupplier s ON s.SupplierKey = p.SupplierKey
INNER JOIN DimProduct pr ON p.ProductKey = p.ProductKey
INNER JOIN DimDate d ON d.DateKey = p.OrderDateKey



SELECT * FROM ProductionMart
DROP VIEW ProductionMart
---------------------------------------------------------------------

---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------

-- Create a new role
CREATE ROLE SalesDataAnalyst;

-- Grant SELECT permission on the views to the role
GRANT SELECT ON SalesMart TO SalesDataAnalyst;
GRANT SELECT ON CustomerMart TO SalesDataAnalyst;
GRANT SELECT ON SupplierPerformanceMart TO SalesDataAnalyst;
GRANT SELECT ON DeliveryStatusMart TO SalesDataAnalyst;
GRANT SELECT ON ProductSalesMart TO SalesDataAnalyst;

-- Add a user to the role
EXEC sp_addrolemember 'SalesDataAnalyst', 'UserName';
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
