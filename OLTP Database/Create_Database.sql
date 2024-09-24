CREATE DATABASE CATASCHEVASTICA 

USE CATASCHEVASTICA 


-- Create Product Table
CREATE TABLE Product
(
  Product_ID INT NOT NULL,
  Name NVARCHAR(50),
  SKU NVARCHAR(50) UNIQUE,
  Color NVARCHAR(50) NOT NULL,
  SurfaceFinish NVARCHAR(50) NOT NULL,
  Compliance NVARCHAR(20) NOT NULL,
  CostPerUnit DECIMAL(10,2) NOT NULL,
  PricePerUnit DECIMAL(10,2) NOT NULL,
  ConstructionTime_Days SMALLINT NOT NULL,
  Quantity INT NOT NULL,
  Category NVARCHAR(100) NOT NULL,
  Description NVARCHAR(100),
  Length DECIMAL(10,2) NOT NULL,
  Width DECIMAL(10,2) NOT NULL,
  Thickness DECIMAL(10,2) NOT NULL,
  Weight DECIMAL(10,2) NOT NULL,
  EventTimestamp TIMESTAMP NOT NULL,
  PRIMARY KEY (Product_ID)
);

-- Create Supplier Table
CREATE TABLE Supplier
(
  Supplier_ID INT NOT NULL,
  Name NVARCHAR(50) NOT NULL,
  Phone NVARCHAR(30) NOT NULL,
  Email NVARCHAR(50) NOT NULL,
  Street NVARCHAR(50) NOT NULL,
  Number INT NOT NULL,
  City NVARCHAR(50) NOT NULL,
  EventTimestamp TIMESTAMP NOT NULL,
  PRIMARY KEY (Supplier_ID)
);

-- Create Customer Table
CREATE TABLE Customer
(
  Customer_ID INT NOT NULL IDENTITY(1,1),
  FName NVARCHAR(50) NOT NULL,
  LName NVARCHAR(50) NOT NULL,
  Phone NVARCHAR(40)  NOT NULL,
  Email NVARCHAR(50) NOT NULL,
  Street NVARCHAR(50) NOT NULL,
  Number INT NOT NULL,
  City NVARCHAR(50) NOT NULL,
  EventTimestamp TIMESTAMP NOT NULL,
  PRIMARY KEY (Customer_ID)
);

-- Create ProductionTeamMember Table
CREATE TABLE ProductionTeamMember
(
  Member_ID INT NOT NULL,
  FName NVARCHAR(50) NOT NULL,
  LName NVARCHAR(50) NOT NULL,
  Phone NVARCHAR(40) NOT NULL,
  Email NVARCHAR(50) NOT NULL,
  Street NVARCHAR(50) NOT NULL,
  Number INT NOT NULL,
  City NVARCHAR(50) NOT NULL,
  EventTimestamp TIMESTAMP NOT NULL,
  PRIMARY KEY (Member_ID)
);

-- Create LogisticsPartner Table
CREATE TABLE LogisticsPartner
(
  LogisticsPartner_ID INT NOT NULL,
  FName NVARCHAR(50) NOT NULL,
  LName NVARCHAR(50) NOT NULL,
  Phone NVARCHAR(50) NOT NULL,
  Email NVARCHAR(50) NOT NULL,
  Street NVARCHAR(50) NOT NULL,
  Number INT NOT NULL,
  City NVARCHAR(50) NOT NULL,
  EventTimestamp TIMESTAMP NOT NULL,
  PRIMARY KEY (LogisticsPartner_ID)
);

-- Create RawMaterial Table
CREATE TABLE RawMaterial
(
  RawMatelial_ID INT NOT NULL,
  Name NVARCHAR(50) NOT NULL,
  CostPerUnit DECIMAL(10,2) NOT NULL,
  EventTimestamp TIMESTAMP NOT NULL,
  Supplier_ID INT NOT NULL,
  PRIMARY KEY (RawMatelial_ID),
  FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID)
);

-- Create ProductRawMaterial Table
CREATE TABLE ProductRawMaterial
(
  Product_ID INT NOT NULL,
  RawMatelial_ID INT NOT NULL,
  PRIMARY KEY (Product_ID, RawMatelial_ID),
  FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
  FOREIGN KEY (RawMatelial_ID) REFERENCES RawMaterial(RawMatelial_ID)
);

-- Create Delivery Table
CREATE TABLE Delivery
(
  Delivery_ID INT NOT NULL IDENTITY(1,1),
  DeliveryStartDate DATETIME NULL,
  DeliveryStatus NVARCHAR(50) NOT NULL,
  EventTimestamp TIMESTAMP NOT NULL,
  DeliveryEndDate DATETIME NULL,
  LogisticsPartner_ID INT NOT NULL,
  Member_ID INT NOT NULL,
  PRIMARY KEY (Delivery_ID),
  FOREIGN KEY (LogisticsPartner_ID) REFERENCES LogisticsPartner(LogisticsPartner_ID),
  FOREIGN KEY (Member_ID) REFERENCES ProductionTeamMember(Member_ID)
);


-- Create Order Table
CREATE TABLE Orders
(
  Order_ID INT NOT NULL IDENTITY(1,1),
  OrderDate DATETIME NOT NULL,
  Status NVARCHAR(50) NOT NULL,
  EventTimestamp TIMESTAMP NOT NULL,
  CancelledDate DATETIME NULL,
  Customer_ID INT NOT NULL,
  Delivery_ID INT NULL,
  PRIMARY KEY (Order_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
  FOREIGN KEY (Delivery_ID) REFERENCES Delivery(Delivery_ID)
);

-- Create ProductionRecord Table
CREATE TABLE ProductionRecord
(
  Production_ID INT NOT NULL,
  ProductionStatus NVARCHAR(50) NULL,
  Order_ID INT NOT NULL,
  Member_ID INT NOT NULL,
  EventTimestamp TIMESTAMP NOT NULL,
  PRIMARY KEY (Production_ID),
  FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
  FOREIGN KEY (Member_ID) REFERENCES ProductionTeamMember(Member_ID)
);

-- Create OrderProduct Table
CREATE TABLE OrderProduct
(
  Units SMALLINT NOT NULL,
  Order_ID INT NOT NULL,
  Product_ID INT NOT NULL,
  PRIMARY KEY (Order_ID, Product_ID),
  FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
  FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);
