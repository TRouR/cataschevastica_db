DROP DATABASE StagingCataschevastica

CREATE DATABASE StagingCataschevastica
USE StagingCataschevastica

--Staging for Customers

SELECT Customer_ID, FName, LName, Phone, Email, Street, Number, City, EventTimestamp
INTO Customers -- StagingCataschevastica.dbo.Customers
FROM CATASCHEVASTICA.dbo.Customer



--Staging for Delivery

SELECT d.Delivery_ID, d.DeliveryStartDate, d.DeliveryEndDate, d.DeliveryStatus, d.EventTimestamp, o.Order_ID, l.LogisticsPartner_ID, l.FName, l.LName, m.Member_ID
INTO Delivery -- StagingCataschevastica.dbo.Delivery
FROM CATASCHEVASTICA.dbo.Delivery d
FULL JOIN CATASCHEVASTICA.dbo.Orders o
ON d.Delivery_ID = o.Delivery_ID
LEFT JOIN CATASCHEVASTICA.dbo.LogisticsPartner l
ON d.LogisticsPartner_ID = l.LogisticsPartner_ID
LEFT JOIN CATASCHEVASTICA.dbo.ProductionTeamMember m
ON d.Member_ID = m.Member_ID



-- Staging for Product

SELECT Product_ID, Name AS ProductName, SKU, Description, CostPerUnit, PricePerUnit, Category, ConstructionTime_Days, Quantity, Color,
SurfaceFinish, Compliance, Length, Width, Thickness, Weight, EventTimestamp
INTO Product -- StagingCataschevastica.dbo.Product
FROM CATASCHEVASTICA.dbo.Product



-- Staging for Supplier
SELECT s.Supplier_ID, s.Name AS SupplierName, s.EventTimestamp, r.RawMatelial_ID, r.Name as RawMaterialName, r.CostPerUnit AS RawMaterialCostPerUnit
INTO Supplier -- StagingCataschevastica.dbo.Product
FROM CATASCHEVASTICA.dbo.Supplier s
LEFT JOIN CATASCHEVASTICA.dbo.RawMaterial r
ON s.Supplier_ID = r.Supplier_ID

-- Staging for Sales 

SELECT o.Order_ID, o.OrderDate, o.Status, o.CancelledDate, o.EventTimestamp, d.Delivery_ID, d.DeliveryStartDate, d.DeliveryEndDate, op.Product_ID, op.Units, c.Customer_ID
INTO Sales-- StagingCataschevastica.dbo.Sales
FROM CATASCHEVASTICA.dbo.Orders o
LEFT JOIN CATASCHEVASTICA.dbo.Delivery d
ON o.Delivery_ID = d.Delivery_ID
LEFT JOIN CATASCHEVASTICA.dbo.OrderProduct op
ON o.Order_ID = op.Order_ID
LEFT JOIN CATASCHEVASTICA.dbo.Customer c
ON o.Customer_ID = c.Customer_ID


--Staging for Production

SELECT pr.Order_ID, o.OrderDate, pr.Production_ID, pr.EventTimestamp, op.Product_ID, p.Name AS ProductName, pr.ProductionStatus, p.Quantity, p.CostPerUnit, p.PricePerUnit,  
tm.Member_ID AS TeamMember_ID, tm.FName AS TeamMemberFName, tm.LName AS TeamMemberLName, rm.Supplier_ID
INTO Production -- StagingCataschevastica.dbo.Production
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

SELECT * FROM Customers
SELECT * FROM Delivery
SELECT * FROM Product
SELECT * FROM Production
SELECT * FROM Sales WHERE Delivery_ID IS NOT NULL
SELECT * FROM Supplier