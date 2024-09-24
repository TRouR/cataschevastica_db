USE CATASCHEVASTICA_DW

-- run each load: detect and load new rows
SELECT c.Customer_ID, c.FName, c.LName, c.Phone, c.Email, c.Street, c.Number, c.City, c.EventTimestamp
INTO SCDType2StagingNew 
FROM CATASCHEVASTICA.dbo.Customer c
LEFT JOIN DimCustomer dc ON c.Customer_ID = dc.CustomerID
WHERE dc.CustomerID IS NULL; -- Only rows that do not exist in the target

SELECT * FROM SCDType2StagingNew; -- New rows from OLTP that do not exist in DW

-- run each load: detect and load updated rows
SELECT c.Customer_ID, c.FName, c.LName, c.Phone, c.Email, c.Street, c.Number, c.City, c.EventTimestamp
INTO SCDType2StagingUpdated
FROM CATASCHEVASTICA.dbo.Customer c
INNER JOIN DimCustomer dc ON c.Customer_ID = dc.CustomerID -- Only keep common rows between OLTP and DW
WHERE dc.RowIsCurrent = 1 -- We are only interested in comparison of values witht the current rows
AND
(
    (CONCAT(c.FName, ' ',c.LName) != dc.ContactName) OR (c.Phone != dc.CustomerPhone) OR (c.Email != dc.CustomerEmail)
	OR (c.Street != dc.CustomerStreet) OR (c.Number != dc.CustomerNumber) OR (c.City != dc.CustomerCity) 
	OR (c.Phone != dc.CustomerPhone) -- Detect changed rows
);

SELECT * FROM SCDType2StagingUpdated;

-- Run each load: Update to mark historic rows
UPDATE DimCustomer
SET RowIsCurrent = 0, RowEndDate = SYSDATETIME()
FROM DimCustomer dc
INNER JOIN SCDType2StagingUpdated s
    ON dc.CustomerID = s.Customer_ID
WHERE dc.RowIsCurrent = 1;

-- Run each load: Load new and updates rows from staging
INSERT INTO DimCustomer (CustomerID, ContactName, CustomerPhone, CustomerEmail, CustomerCity, CustomerStreet,
CustomerNumber, [Version], RowIsCurrent, RowStartDate, RowEndDate)
SELECT Customer_ID, CONCAT(FName,' ',LName), Phone, Email, City, Street, Number, CAST(EventTimestamp AS BIGINT), 1, SYSDATETIME(), '9999-12-31'
FROM SCDType2StagingNew
UNION
SELECT Customer_ID, CONCAT(FName,' ',LName), Phone, Email, City, Street, Number, CAST(EventTimestamp AS BIGINT), 1, SYSDATETIME(), '9999-12-31'
FROM SCDType2StagingUpdated;

-- Run each time: Drop staging tables
DROP TABLE SCDType2StagingNew;
DROP TABLE SCDType2StagingUpdated;