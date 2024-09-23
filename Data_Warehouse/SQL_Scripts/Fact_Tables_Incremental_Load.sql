USE CATASCHEVASTICA_DW


-- Incremental Load for FactSales

DECLARE @PreviousLoadMax AS BIGINT = (SELECT MAX([Version]) FROM FactSales) 
INSERT INTO FactSales (ProductKey, CustomerKey, DeliveryKey, OrderDateKey, DeliveryDateKey, 
	OrderID, OrderStatus, OrderDate, CancelledDate, Units, Profit, [Version])
SELECT dp.ProductKey, dc.CustomerKey, dd.DeliveryKey, 
	CAST(FORMAT(o.OrderDate,'yyyyMMdd') AS INT) OrderDateKey, 
	CAST(FORMAT(d.DeliveryEndDate,'yyyyMMdd') AS INT) DeliveryDateKey, 
	OrderID, Status, OrderDate, CancelledDate, Units, (ProductPricePerUnit - ProductCostPerUnit) * Units AS Profit, 
	CAST(o.EventTimestamp AS BIGINT) AS [VERSION]
FROM CATASCHEVASTICA.dbo.Orders o
LEFT JOIN CATASCHEVASTICA.dbo.Delivery d
ON o.Delivery_ID = d.Delivery_ID
LEFT JOIN CATASCHEVASTICA.dbo.OrderProduct op
ON o.Order_ID = op.Order_ID
LEFT JOIN CATASCHEVASTICA.dbo.Customer c
ON o.Customer_ID = c.Customer_ID
	LEFT JOIN DimDelivery dd ON d.Delivery_ID = dd.DeliveryID
	INNER JOIN DimProduct dp ON op.Product_ID = dp.Product_ID
	INNER JOIN DimCustomer dc ON c.Customer_ID = dc.CustomerID
WHERE CAST(o.EventTimestamp  AS BIGINT)> @PreviousLoadMax; 






-- Incremental Load for FactProduction
DECLARE @PreviousLoadMaxProduction AS BIGINT = (SELECT MAX([Version]) FROM FactProduction) 
INSERT INTO 
	FactProduction(ProductKey, SupplierKey, OrderDateKey, OrderID, Production_ID, ProductionStatus, 
	CostPerUnit, PricePerUnit, Quantity, Team_Member_ID, Product_ID, ProductName, [Version])
SELECT 
	dp.ProductKey, ds.SupplierKey, 
	CAST(FORMAT(o.OrderDate,'yyyyMMdd') AS INT) OrderDateKey, 
	o.Order_ID, Production_ID, ProductionStatus, p.CostPerUnit, PricePerUnit, Quantity, 
	tm.Member_ID, p.Product_ID, ProductName, CAST(pr.EventTimestamp AS BIGINT)
	FROM CATASCHEVASTICA.dbo.ProductionRecord pr
	LEFT JOIN CATASCHEVASTICA.dbo.ProductionTeamMember tm
	ON pr.Member_ID = tm.Member_ID
	LEFT JOIN CATASCHEVASTICA.dbo.OrderProduct op
	ON pr.Order_ID = op.Order_ID
	LEFT JOIN CATASCHEVASTICA.dbo.Orders o
	ON op.Order_ID = o.Order_ID
	LEFT JOIN CATASCHEVASTICA.dbo.Product p
	ON op.Product_ID = p.Product_ID
	LEFT JOIN CATASCHEVASTICA.dbo.ProductRawMaterial prm
	ON p.Product_ID = prm.Product_ID
	LEFT JOIN CATASCHEVASTICA.dbo.RawMaterial rm
	ON prm.RawMatelial_ID = rm.RawMatelial_ID
	INNER JOIN DimProduct dp ON p.Product_ID = dp.Product_ID
	INNER JOIN DimSupplier ds ON rm.Supplier_ID = ds.SupplierID
WHERE CAST(pr.EventTimestamp AS BIGINT) > @PreviousLoadMaxProduction; 

