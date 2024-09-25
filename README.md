# Cataschevastica OLTP Database, Data Warehouse and Analytics
![Webp net-resizeimage](https://github.com/user-attachments/assets/e3533cff-33cf-44b9-ad35-f3e2b8f6eb74)

## Overview

This project consists of two major stages developed for a fictitious manufacturing company, **Cataschevastica**, focusing on their **Online Transaction Processing (OLTP)** system and the subsequent **Data Warehouse (DW)** implementation. The project tracks the company's end-to-end manufacturing process, ensuring efficiency, customer satisfaction, and service quality. 

### `Stage 1: OLTP Database`

The **Cataschevastica OLTP Database** is designed to support the company’s real-time operational processes, including order intake, product manufacturing, and delivery tracking. It is **normalized to Third Normal Form (3NF)** to ensure data integrity and eliminate redundancy. It supports:

- Order placement and management
- Product inventory and production tracking
- Supplier and raw material management
- Delivery and logistics tracking

### `Stage 2: Data Warehouse, Databricks and Power BI`

The **Data Warehouse (DW)** was built to facilitate advanced data analysis, enabling insights into production performance, sales, and customer behaviors. The DW is designed in a **constellation schema** and is integrated into **Azure Cloud** using **Blob Storage**. Subsequently, the **Data Lake** is loaded into **Databricks** for processing, using **Apache Spark**. Finally, an interactive dashboard is generated in **Power BI Desktop**, filtering data from the Warehouse and supporting advanced visualizations.


## Features

1. **Database Design**: ERD and Relational Schema for the OLTP system.
2. **Database Implementation**: SQL scripts to create the OLTP database and populate it with sample data.
3. **Data Queries**: Predefined queries to extract useful insights, such as order reports, production status, and delivery tracking.
4. **ETL Processes**: Extract, Transform, Load scripts for data warehouse creation and automated update.
5. **Data Lake Integration**: Data from the Data Warehouse is loaded into Azure Blob Storage, creating a cloud-based Data Lake for further processing.
6. **Cloud Processing with Databricks**: Data in the Data Lake is loaded into Databricks with Apache Spark for further transformation and analysis workflows.
7. **Business Intelligence**: Power BI dashboard for analyzing the company's key compoments, such as production and sales.

## Project Files

- **`OLTP Database/`**: All files for implementating the Cataschevastica OLTP database.
  - **Blueprint**: Database design.
    - `erd_diagram.png`: Entity-Relationship Diagram (ERD) of the OLTP system.
    - `relational_schema.png`: Logical Relational Schema for the database.
  - **Data Files** (CSV format, under `OLTP Database/Data/`): Used to populate tables in the OLTP database.
    - `Customer_Table.csv`: Customer data.
    - `Delivery_Table.csv`: Delivery data related to orders and logistics.
    - `Logistics_Partner_Table.csv`: Information about logistics partners.
    - `Order_Product_Table.csv`: Order details associated with products.
    - `Orders_Table.csv`: Table for customer orders.
    - `Product_RawMaterial_Table.csv`: Links products to the raw materials used.
    - `Product_Table.csv`: Product details.
    - `Production_Record_Table.csv`: Tracks production status and team assignments.
    - `Production_Team_Member_Table.csv`: Information about production team members.
    - `Raw_Material_Table.csv`: Details of raw materials.
    - `Supplier_Table.csv`: Data on suppliers providing materials
  - **SQL Scripts**: 
    - `Create_Database.sql`: Creates the OLTP database.
    - `Data_Population.sql`: Populates the OLTP database.
    - `Command_Statements.sql`: Statements to simulate operations.
    - `Queries.sql`: Queries for generating reports.
- **`Data_Warehouse/`**: All files for implementating the Data Warehouse, integrating with Azure Blob Storage, processing in Databricks and BI dashboard.
  - **Data Files** (CSV format, under `Data_Warehouse/Data/`): Data stored in the Data Lake.
    - `dw_dim_customers.csv`: Data for the customer dimension in the DW.
    - `dw_dim_date.csv`: Time-related data.
    - `dw_dim_delivery.csv`: Delivery data dimension for tracking shipments.
    - `dw_dim_product.csv`: Product data into the DW.
    - `dw_dim_supplier.csv`: Supplier information.
    - `dw_fact_production.csv`: Production facts.
    - `dw_fact_sales.csv`: Sales facts.
  - **Databricks**: Documentation on importing data from Azure Blob Storage into Databricks for further processing.
    - `Import_from_Azure_Blob_Storage.html`
    - `Import_from_Azure_Blob_Storage.ipynb`
  - **PowerBI**: Power BI dashboard for visualizing DW data.
    - `Cataschevastica_PowerBI.pbix`
  - **SQL Scripts**: 
    - `Create_Data_Warehouse.sql`: Creates the DW.
    - `Create_DimDate.sql`: Creates the Date dimension.
    - `Create_Staging.sql`: Creates the staging area.
    - `Create_Views.sql`: Creates views in the DW.
    - `DimCustomer_Scd_Type_2.sql`: Implemention of SCD Type 2 for dimensions.
    - `DimDelivery_Scd_Type_2.sql`
    - `DimProduct_Scd_Type_2.sql`
    - `DimSupplier_Scd_type_2.sql`
    - `Fact_Tables_Incremental_Load.sql`: Implemention incremental loading for fact tables.
    - `Load_Data_Warehouse.sql`: Loading data into the DW from the staging area.

## Prerequisites

- **MS SQL Server**
- **Azure Blob Storage**
- **Databricks/Apache Spark**
- **Power BI Desktop**

