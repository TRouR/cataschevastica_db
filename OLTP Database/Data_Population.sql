USE CATASCHEVASTICA 

---Product Table:
BULK INSERT Product
FROM "C:\Users\alex1\Desktop\project 2\Product_table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO


---Supplier Table:
BULK INSERT Supplier
FROM "C:\Users\alex1\Desktop\project 2\Supplier_Table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO



---Customer Table:
BULK INSERT Customer
FROM "C:\Users\alex1\Desktop\project 2\Customer_Table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO



---ProductionTeamMember Table:

BULK INSERT ProductionTeamMember
FROM "C:\Users\alex1\Desktop\project 2\Production_Team_Member_Table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO



---LogisticsPartner Table:
BULK INSERT LogisticsPartner
FROM "C:\Users\alex1\Desktop\project 2\Logistics_Partner_Table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO


---RawMaterial Table:
BULK INSERT RawMaterial
FROM "C:\Users\alex1\Desktop\project 2\raw_material_data.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO

---ProductRawMaterial Table:
BULK INSERT ProductRawMaterial
FROM "C:\Users\alex1\Desktop\project 2\Product_RawMaterial_Table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO


----Delivery Table:

BULK INSERT Delivery
FROM "C:\Users\alex1\Desktop\project 2\Delivery_Table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO



---Orders Table:

BULK INSERT Orders
FROM "C:\Users\alex1\Desktop\project 2\Orders_Table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO



---- ProductionRecord Table

BULK INSERT ProductionRecord
FROM "C:\Users\alex1\Desktop\project 2\Production_Record_Table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO

---OrderProduct Table:

BULK INSERT OrderProduct
FROM "C:\Users\alex1\Desktop\project 2\Order_Product_Table.csv"
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO



select * from product
select * from supplier
select * from customer
select * from ProductionTeamMember
select * from LogisticsPartner
select * from RawMaterial
select * from productrawmaterial
select * from Delivery
select * from orders
select * from ProductionRecord
select * from OrderProduct