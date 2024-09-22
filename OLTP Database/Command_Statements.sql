USE CATASCHEVASTICA

--A. Create an order

INSERT INTO Orders (OrderDate, Status, CancelledDate, Customer_ID, Delivery_ID)
VALUES ('', '' )


--B. Finalise production

UPDATE Orders
SET Status = 'In Delivery'
WHERE Order_ID =  1;

UPDATE ProductionRecord
SET ProductionStatus = 'Complete'
WHERE Production_ID = 801;

UPDATE Delivery
SET DeliveryStatus = 'In Process'
WHERE Delivery_ID = 1;


--C. Finalise an order and delivery

UPDATE Orders
SET Status = 'Complete'
WHERE Order_ID =  1

UPDATE Delivery
SET DeliveryStatus = 'Complete'
WHERE Delivery_ID = 1;
