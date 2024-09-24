USE CATASCHEVASTICA_DW

-- run each load: detect and load new rows
SELECT d.Delivery_ID, d.DeliveryStartDate, d.DeliveryEndDate, d.DeliveryStatus, d.EventTimestamp, l.LogisticsPartner_ID, l.FName, l.LName, m.Member_ID
INTO SCDType2DeliveryStagingNew 
FROM CATASCHEVASTICA.dbo.Delivery d
LEFT JOIN CATASCHEVASTICA.dbo.LogisticsPartner l
ON d.LogisticsPartner_ID = l.LogisticsPartner_ID
LEFT JOIN CATASCHEVASTICA.dbo.ProductionTeamMember m
ON d.Member_ID = m.Member_ID
LEFT JOIN DimDelivery dl ON d.Delivery_ID = dl.DeliveryID -- LEFT join in order to make sure all rows from the source are retained
WHERE dl.DeliveryID IS NULL; -- Only rows that do not exist in the target

SELECT * FROM SCDType2DeliveryStagingNew; -- New rows from OLTP that do not exist in DW

-- run each load: detect and load updated rows
SELECT d.Delivery_ID, d.DeliveryStartDate, d.DeliveryEndDate, d.DeliveryStatus, d.EventTimestamp, l.LogisticsPartner_ID, l.FName, l.LName, m.Member_ID
INTO SCDType2DeliveryStagingUpdated
FROM CATASCHEVASTICA.dbo.Delivery d
LEFT JOIN CATASCHEVASTICA.dbo.LogisticsPartner l
ON d.LogisticsPartner_ID = l.LogisticsPartner_ID
LEFT JOIN CATASCHEVASTICA.dbo.ProductionTeamMember m
ON d.Member_ID = m.Member_ID
INNER JOIN DimDelivery dl ON d.Delivery_ID = dl.DeliveryID -- Only keep common rows between OLTP and DW
WHERE dl.RowIsCurrent = 1 -- We are only interested in comparison of values witht the current rows
AND
(
    (d.DeliveryStatus != dl.DeliveryStatus) OR (CONCAT(l.FName, ' ',l.LName) != dl.Logistics_Partner_Name) -- Detect changed rows
);

SELECT * FROM SCDType2DeliveryStagingUpdated;

-- Run each load: Update to mark historic rows
UPDATE DimDelivery
SET RowIsCurrent = 0, RowEndDate = SYSDATETIME()
FROM DimDelivery dl
INNER JOIN SCDType2DeliveryStagingUpdated s
    ON dl.DeliveryID = s.Delivery_ID
WHERE dl.RowIsCurrent = 1;

-- Run each load: Load new and updates rows from staging
INSERT INTO DimDelivery (DeliveryID, DeliveryStartDate, DeliveryEndDate, DeliveryStatus, Logistics_Partner_ID, Logistics_Partner_Name,
Team_Member_ID, [Version], RowIsCurrent, RowStartDate, RowEndDate)
SELECT Delivery_ID, DeliveryStartDate, DeliveryEndDate, DeliveryStatus, LogisticsPartner_ID, CONCAT(FName,' ',LName), Member_ID, CAST(EventTimestamp AS BIGINT),
 1, SYSDATETIME(), '9999-12-31'
FROM SCDType2DeliveryStagingNew
UNION
SELECT Delivery_ID, DeliveryStartDate, DeliveryEndDate, DeliveryStatus, LogisticsPartner_ID, CONCAT(FName,' ',LName), Member_ID, CAST(EventTimestamp AS BIGINT),
 1, SYSDATETIME(), '9999-12-31'
FROM SCDType2DeliveryStagingUpdated;

-- Run each time: Drop staging tables
DROP TABLE SCDType2DeliveryStagingNew;
DROP TABLE SCDType2DeliveryStagingUpdated;