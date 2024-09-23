USE CATASCHEVASTICA_DW

-- Customer load

INSERT INTO DimCustomer(CustomerID, ContactName, CustomerPhone, CustomerEmail, CustomerCity, CustomerStreet, CustomerNumber, [Version])
SELECT Customer_ID, CONCAT(FName, ' ', LName), Phone, Email, City, Street, Number, EventTimestamp
FROM StagingCataschevastica.dbo.Customers;

SELECT * FROM DimCustomer;

-- Delivery load

INSERT INTO DimDelivery(DeliveryID, DeliveryStartDate, DeliveryEndDate, DeliveryStatus, Logistics_Partner_ID, Logistics_Partner_Name, Team_Member_ID, [Version], OrderID)
SELECT Delivery_ID, DeliveryStartDate, DeliveryEndDate, DeliveryStatus, LogisticsPartner_ID, CONCAT(FName, ' ', LName), Member_ID, EventTimeStamp, Order_ID
FROM StagingCataschevastica.dbo.Delivery;

SELECT * FROM DimDelivery;

-- Product load

INSERT INTO DimProduct(Product_ID, ProductName, ProductDimensions, ProductDescription, ProductCostPerUnit, ProductPricePerUnit, ProductCategory,
ProductConstructionDays, ProductQuantity, ProductColor, ProductSurfaceFinish, ProductCompliance, ProductWeight, [Version])
SELECT Product_ID, ProductName, CONCAT(Length, 'x', Width, 'x', Thickness), Description, CostPerUnit, PricePerUnit, Category,
ConstructionTime_Days, Quantity, Color, SurfaceFinish, Compliance, Weight, EventTimestamp
FROM StagingCataschevastica.dbo.Product;

SELECT * FROM DimProduct;


-- Supplier load

INSERT INTO DimSupplier(SupplierID, SupplierName, RawMaterial_ID, RawMaterialName, RawMaterialCostPerUnit, [Version])
SELECT Supplier_ID, SupplierName, RawMatelial_ID, RawMaterialName, RawMaterialCostPerUnit, EventTimestamp
FROM StagingCataschevastica.dbo.Supplier;

SELECT * FROM DimSupplier;



-- Create Constraints For Fact Sales

ALTER TABLE FactSales ADD FOREIGN KEY (CustomerKey)
REFERENCES DimCustomer(CustomerKey);

ALTER TABLE FactSales ADD FOREIGN KEY (ProductKey)
REFERENCES DimProduct(ProductKey);

ALTER TABLE FactSales ADD FOREIGN KEY (DeliveryKey)
REFERENCES DimDelivery (DeliveryKey);

ALTER TABLE FactSales ADD FOREIGN KEY (OrderDateKey)
REFERENCES DimDate(DateKey);

ALTER TABLE FactSales ADD FOREIGN KEY (DeliveryDateKey)
REFERENCES DimDate(DateKey);

--ALTER TABLE FactSales 
--ADD CONSTRAINT PK_FactSales PRIMARY KEY (OrderID, ProductKey);


-- Fact Sales load
INSERT INTO 
	FactSales(ProductKey, CustomerKey, DeliveryKey, OrderDateKey, DeliveryDateKey, 
	OrderID, OrderStatus, OrderDate, CancelledDate, Units, Profit, [Version])
SELECT 
	p.ProductKey, c.CustomerKey, d.DeliveryKey, 
	CAST(FORMAT(s.OrderDate,'yyyyMMdd') AS INT) OrderDateKey, 
	CAST(FORMAT(s.DeliveryEndDate,'yyyyMMdd') AS INT) DeliveryDateKey, 
	Order_ID, Status, OrderDate, CancelledDate, Units, (ProductPricePerUnit - ProductCostPerUnit) * Units AS Profit, 
	CAST(EventTimestamp AS BIGINT) AS [Version]
FROM StagingCataschevastica.dbo.Sales s
	LEFT JOIN DimDelivery d ON s.Delivery_ID = d.DeliveryID
	INNER JOIN DimProduct p ON s.Product_ID = p.Product_ID
	INNER JOIN DimCustomer c ON s.Customer_ID = c.CustomerID
WHERE p.RowIsCurrent = 1 AND c.RowIsCurrent = 1 AND (d.RowIsCurrent = 1 OR d.RowIsCurrent IS NULL);


SELECT * FROM FactSales


-- Create Constraints For Fact Production
ALTER TABLE FactProduction ADD FOREIGN KEY  (ProductKey)
REFERENCES DimProduct(ProductKey);

ALTER TABLE FactProduction ADD FOREIGN KEY (SupplierKey)
REFERENCES DimSupplier(SupplierKey);

ALTER TABLE FactProduction ADD FOREIGN KEY (OrderDateKey)
REFERENCES DimDate(DateKey);


-- Fact Production load
INSERT INTO 
	FactProduction(ProductKey, SupplierKey, OrderDateKey, OrderID, Production_ID, ProductionStatus, 
	CostPerUnit, PricePerUnit, Quantity, Team_Member_ID, Product_ID, ProductName, [Version])
SELECT 
	p.ProductKey, s.SupplierKey, 
	CAST(FORMAT(pr.OrderDate,'yyyyMMdd') AS INT) OrderDateKey, 
	Order_ID, Production_ID, ProductionStatus, CostPerUnit, PricePerUnit, Quantity, 
	TeamMember_ID, pr.Product_ID, pr.ProductName, EventTimestamp
FROM StagingCataschevastica.dbo.Production pr
	INNER JOIN DimProduct p ON pr.Product_ID = p.Product_ID
	INNER JOIN DimSupplier s ON pr.Supplier_ID = s.SupplierID
WHERE p.RowIsCurrent = 1 AND s.RowIsCurrent = 1;

SELECT * FROM FactProduction
