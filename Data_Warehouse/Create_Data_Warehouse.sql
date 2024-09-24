CREATE DATABASE CATASCHEVASTICA_DW

USE CATASCHEVASTICA_DW


-- Create DimCustomer
CREATE TABLE DimCustomer(
	CustomerKey INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
	CustomerID INT NOT NULL, -- Natural/Business Key
	ContactName NVARCHAR(80) NOT NULL,
	CustomerPhone NVARCHAR(30) NOT NULL,
	CustomerEmail NVARCHAR(80) NOT NULL,
	CustomerCity NVARCHAR(25) NOT NULL,
	CustomerStreet NVARCHAR(25) DEFAULT 'N/A' NOT NULL,
	CustomerNumber NVARCHAR(40) NOT NULL, 
	[Version] BIGINT, 
	RowIsCurrent BIT DEFAULT 1 NOT NULL,
	RowStartDate DATETIME2 DEFAULT SYSDATETIME(),
	RowEndDate DATETIME2 DEFAULT('9999-12-31'),
	RowChangeReason VARCHAR(200)
);

-- Create DimProduct
CREATE TABLE DimProduct(
	ProductKey INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
	Product_ID INT NOT NULL, -- Natural/Business Key
	ProductName NVARCHAR(80) NOT NULL,
	ProductDimensions NVARCHAR(80) NOT NULL,
	ProductDescription NVARCHAR(100),
	ProductCostPerUnit DECIMAL(10,2) NOT NULL,
	ProductPricePerUnit DECIMAL(10,2) NOT NULL,
	ProductCategory NVARCHAR(100) NOT NULL,
	ProductConstructionDays SMALLINT NOT NULL,
	ProductQuantity INT NOT NULL, 
	ProductColor NVARCHAR(50) NOT NULL,
	ProductSurfaceFinish NVARCHAR(50) NOT NULL,
	ProductCompliance BIT NOT NULL,
	ProductWeight DECIMAL(10,2) NOT NULL,
	[Version] BIGINT, 
	RowIsCurrent BIT DEFAULT 1 NOT NULL,
	RowStartDate DATETIME2 DEFAULT SYSDATETIME(),
	RowEndDate DATETIME2 DEFAULT('9999-12-31'),
	RowChangeReason VARCHAR(200)
);

-- Create DimDelivery
CREATE TABLE DimDelivery(
	DeliveryKey INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
	DeliveryID INT NULL, -- Natural Key / Business Key
	DeliveryStartDate DATETIME ,
	DeliveryEndDate DATETIME , 
	DeliveryStatus NVARCHAR(80) ,
	Logistics_Partner_ID INT , 
	Logistics_Partner_Name NVARCHAR(80) ,
	Team_Member_ID INT ,
	[Version] BIGINT, 
	OrderID INT NOT NULL,
	RowIsCurrent BIT DEFAULT 1 NOT NULL,
	RowStartDate DATETIME2 DEFAULT SYSDATETIME(),
	RowEndDate DATETIME2 DEFAULT('9999-12-31'),
	RowChangeReason VARCHAR(200)
);

-- Create DimSupplier
CREATE TABLE DimSupplier(
	SupplierKey INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
	SupplierID INT NOT NULL, -- Natural Key / Business Key
	SupplierName NVARCHAR(50) NOT NULL,
	RawMaterial_ID INT NOT NULL,
	RawMaterialName NVARCHAR(50) NOT NULL,
	RawMaterialCostPerUnit DECIMAL(10,2) NOT NULL,
	[Version] BIGINT, 
	RowIsCurrent BIT DEFAULT 1 NOT NULL,
	RowStartDate DATETIME2 DEFAULT SYSDATETIME(),
	RowEndDate DATETIME2 DEFAULT('9999-12-31'),
	RowChangeReason VARCHAR(200)
);

-- Create Fact Table
CREATE TABLE FactSales( 
	CustomerKey INT NOT NULL,
	ProductKey INT NOT NULL,
	DeliveryKey INT  NULL,     
	OrderDateKey INT  NULL,
	DeliveryDateKey INT,
	OrderID INT NOT NULL,
	OrderStatus NVARCHAR(80)  NULL, 
	OrderDate DATETIME  NULL,
	CancelledDate DATETIME NULL, 
	Units SMALLINT NOT NULL,
	Profit FLOAT NOT NULL,
	[Version] BIGINT, 
);

-- Create Fact Table
CREATE TABLE FactProduction( 
--	ProductionKey INT IDENTITY(1,1) PRIMARY KEY,
	ProductKey INT NOT NULL,
	SupplierKey INT NOT NULL, 
	OrderDateKey INT NOT NULL,
	OrderID INT NOT NULL,
	Production_ID INT NOT NULL,
	ProductionStatus NVARCHAR(50) NULL,
	CostPerUnit DECIMAL(10,2) NOT NULL,
	PricePerUnit DECIMAL(10,2) NOT NULL,
	Quantity INT NOT NULL, 
	Team_Member_ID INT NOT NULL,
	Product_ID INT NOT NULL, 
	ProductName NVARCHAR(50) NOT NULL,
	[Version] BIGINT, 
);
