USE CATASCHEVASTICA_DW

-- run each load: detect and load new rows
SELECT s.Supplier_ID, s.Name AS SupplierName, s.EventTimestamp, r.RawMatelial_ID, r.Name as RawMaterialName, r.CostPerUnit AS RawMaterialCostPerUnit
INTO SCDType2SupplierStagingNew 
FROM CATASCHEVASTICA.dbo.Supplier s
LEFT JOIN CATASCHEVASTICA.dbo.RawMaterial r ON s.Supplier_ID = r.Supplier_ID
LEFT JOIN DimSupplier ds ON s.Supplier_ID = ds.SupplierID -- LEFT join in order to make sure all rows from the source are retained
WHERE ds.SupplierID IS NULL; -- Only rows that do not exist in the target

SELECT * FROM SCDType2SupplierStagingNew; -- New rows from OLTP that do not exist in DW

-- run each load: detect and load updated rows
SELECT s.Supplier_ID, s.Name AS SupplierName, s.EventTimestamp, r.RawMatelial_ID, r.Name as RawMaterialName, r.CostPerUnit AS RawMaterialCostPerUnit
INTO SCDType2SupplierStagingUpdated
FROM CATASCHEVASTICA.dbo.Supplier s
LEFT JOIN CATASCHEVASTICA.dbo.RawMaterial r ON s.Supplier_ID = r.Supplier_ID
INNER JOIN DimSupplier ds ON s.Supplier_ID = ds.SupplierID-- Only keep common rows between OLTP and DW
WHERE ds.RowIsCurrent = 1 -- We are only interested in comparison of values witht the current rows
AND
(
    (s.Name != ds.SupplierName) OR (r.Name != ds.RawMaterialName) OR (r.CostPerUnit != ds.RawMaterialCostPerUnit) -- Detect changed rows
);

SELECT * FROM SCDType2SupplierStagingUpdated;

-- Run each load: Update to mark historic rows
UPDATE DimSupplier
SET RowIsCurrent = 0, RowEndDate = SYSDATETIME()
FROM DimSupplier ds
INNER JOIN SCDType2SupplierStagingUpdated s
    ON ds.SupplierID = s.Supplier_ID
WHERE ds.RowIsCurrent = 1;

-- Run each load: Load new and updates rows from staging
INSERT INTO DimSupplier(SupplierID, SupplierName, RawMaterial_ID, RawMaterialName, RawMaterialCostPerUnit, 
[Version], RowIsCurrent, RowStartDate, RowEndDate)
SELECT Supplier_ID, SupplierName, RawMatelial_ID, RawMaterialName, RawMaterialCostPerUnit, 
CAST(EventTimestamp AS BIGINT), 1, SYSDATETIME(), '9999-12-31'
FROM SCDType2SupplierStagingNew
UNION
SELECT Supplier_ID, SupplierName, RawMatelial_ID, RawMaterialName, RawMaterialCostPerUnit, 
CAST(EventTimestamp AS BIGINT), 1, SYSDATETIME(), '9999-12-31'
FROM SCDType2SupplierStagingUpdated;

-- Run each time: Drop staging tables
DROP TABLE SCDType2SupplierStagingNew;
DROP TABLE SCDType2SupplierStagingUpdated;