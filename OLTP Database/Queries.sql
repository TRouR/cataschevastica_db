USE CATASCHEVASTICA 

---A.List of all products ordered yesterday 

SELECT O.Order_ID, P.Name, OP.Units, p.Product_ID
FROM Orders O
JOIN OrderProduct OP ON O.Order_ID = OP.Order_ID
JOIN Product P ON OP.Product_ID = P.Product_ID
WHERE cast(O.OrderDate AS DATE) = '2024-05-20';



---B.List of all finished orders ready to deliver

SELECT *
FROM Orders
WHERE Status = 'In Delivery'


---C.List of all orders per customer, completed, pending, cancelled

SELECT o.Order_ID,
       o.OrderDate,
       o.Status AS OrderStatus,
       c.Customer_ID,
       c.FName AS FirstName,
       c.LName AS LastName
FROM Orders o
JOIN Customer c ON o.Customer_ID = c.Customer_ID
ORDER BY C.FName, o.Status


 ---D. List of all products with quantities, ordered and delivered, ordered and pending, cancelled
 
SELECT o.Status,
       p.Quantity AS AvailableQuantity,
       p.Product_ID,
       p.Name AS ProductName
FROM Product p
LEFT JOIN OrderProduct op ON p.Product_ID = op.Product_ID
LEFT JOIN Orders o ON op.Order_ID = o.Order_ID
GROUP BY  p.Quantity, o.Status, p.Product_ID, p.Name 


 ----E .List of orders per production team employee, completed, pending, cancelled
 
 SELECT o.Order_ID,
        o.Status,
        ptm.Member_ID,
        ptm.FName,
        ptm.LName
FROM ProductionTeamMember ptm
JOIN ProductionRecord pr ON ptm.Member_ID = pr.Member_ID
JOIN Orders o ON pr.Order_ID = o.Order_ID
GROUP BY ptm.Member_ID,o.Order_ID, o.Status, ptm.FName, ptm.LName


----F. Daily order and production report:

SELECT o.Order_ID, 
       pr.ProductionStatus 
FROM Orders o
LEFT JOIN ProductionRecord pr ON o.Order_ID = pr.Order_ID
WHERE cast(o.OrderDate AS DATE) = '2024-05-20' --you can also use CURRENT_DATE  
GROUP BY o.Order_ID, pr.ProductionStatus


--G.List of new orders per week and month:

SELECT 
    YEAR(o.OrderDate) AS OrderYear, 
    MONTH(o.OrderDate) AS OrderMonth,
    DATEPART(WEEK, o.OrderDate) AS OrderWeek,
    COUNT(o.Order_ID) AS NewOrders
FROM Orders o
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate), DATEPART(WEEK, o.OrderDate)


---H. List of completed orders per week and month:

SELECT 
    YEAR(o.OrderDate) AS OrderYear, 
    MONTH(o.OrderDate) AS OrderMonth,
    DATEPART(WEEK, o.OrderDate) AS OrderWeek,
    COUNT(o.Order_ID) AS CompletedOrders
FROM Orders o
WHERE o.Status = 'Complete'
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate), DATEPART(WEEK, o.OrderDate)


