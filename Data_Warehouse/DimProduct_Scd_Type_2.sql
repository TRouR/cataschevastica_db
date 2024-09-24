USE CATASCHEVASTICA_DW

-- run each load: detect and load new rows
SELECT p.Product_ID, Name AS ProductName, SKU, Description, CostPerUnit, PricePerUnit, Category, ConstructionTime_Days, Quantity, Color,
SurfaceFinish, Compliance, Length, Width, Thickness, Weight, EventTimestamp
INTO SCDType2ProductStagingNew 
FROM CATASCHEVASTICA.dbo.Product p
LEFT JOIN DimProduct dp ON p.Product_ID = dp.Product_ID -- LEFT join in order to make sure all rows from the source are retained
WHERE dp.Product_ID IS NULL; -- Only rows that do not exist in the target

SELECT * FROM SCDType2ProductStagingNew; -- New rows from OLTP that do not exist in DW

-- run each load: detect and load updated rows
SELECT p.Product_ID, Name AS ProductName, SKU, Description, CostPerUnit, PricePerUnit, Category, ConstructionTime_Days, Quantity, Color,
SurfaceFinish, Compliance, Length, Width, Thickness, Weight, EventTimestamp
INTO SCDType2ProductStagingUpdated 
FROM CATASCHEVASTICA.dbo.Product p
INNER JOIN DimProduct dp ON p.Product_ID = dp.Product_ID-- Only keep common rows between OLTP and DW
WHERE dp.RowIsCurrent = 1 -- We are only interested in comparison of values witht the current rows
AND
(
    (p.Name != dp.ProductName) OR (p.Description != dp.ProductDescription) OR (p.CostPerUnit != dp.ProductCostPerUnit)
	OR (p.PricePerUnit != dp.ProductPricePerUnit) OR (p.Category != dp.ProductCategory) OR (p.ConstructionTime_Days != dp.ProductConstructionDays) 
	OR (p.Quantity != dp.ProductQuantity) OR (p.Color != dp.ProductColor) OR (p.SurfaceFinish != dp.ProductSurfaceFinish) 
	OR (p.Compliance != dp.ProductCompliance) OR (CONCAT(p.Length, 'x', p.Width, 'x', p.Thickness) != dp.ProductDimensions)
	OR (p.Weight != dp.ProductWeight) -- Detect changed rows
);

SELECT * FROM SCDType2ProductStagingUpdated;

-- Run each load: Update to mark historic rows
UPDATE DimProduct
SET RowIsCurrent = 0, RowEndDate = SYSDATETIME()
FROM DimProduct dp
INNER JOIN SCDType2ProductStagingUpdated s
    ON dp.Product_ID = s.Product_ID
WHERE dp.RowIsCurrent = 1;

-- Run each load: Load new and updates rows from staging
INSERT INTO DimProduct (Product_ID, ProductName, ProductDimensions, ProductDescription, ProductCostPerUnit, ProductPricePerUnit,
ProductCategory, ProductConstructionDays, ProductQuantity, ProductColor, ProductSurfaceFinish, ProductCompliance, ProductWeight, 
[Version], RowIsCurrent, RowStartDate, RowEndDate)
SELECT Product_ID, ProductName, CONCAT(Length, 'x', Width, 'x', Thickness), [Description], CostPerUnit, PricePerUnit, Category,
ConstructionTime_Days, Quantity, Color, SurfaceFinish, Compliance, Weight, 
CAST(EventTimestamp AS BIGINT), 1, SYSDATETIME(), '9999-12-31'
FROM SCDType2ProductStagingNew
UNION
SELECT Product_ID, ProductName, CONCAT(Length, 'x', Width, 'x', Thickness), [Description], CostPerUnit, PricePerUnit, Category,
ConstructionTime_Days, Quantity, Color, SurfaceFinish, Compliance, Weight, 
CAST(EventTimestamp AS BIGINT), 1, SYSDATETIME(), '9999-12-31'
FROM SCDType2ProductStagingUpdated;

-- Run each time: Drop staging tables
DROP TABLE SCDType2ProductStagingNew;
DROP TABLE SCDType2ProductStagingUpdated;