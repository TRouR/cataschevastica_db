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
4. **ETL Processes**: Extract, Transform, Load scripts to automate data warehouse creation and update.
5. **Data Lake Integration**: Data from the Data Warehouse is loaded into Azure Blob Storage, creating a cloud-based Data Lake for further processing.
6. **Cloud Processing with Databricks**: Data in the Data Lake is loaded into Databricks with Apache Spark for further transformation and analysis workflows.
7. **Business Intelligence**: Power BI dashboard for analyzing the company's key compoments, such as production and sales.

## Project Files

- **`Database/`**: Contains all SQL scripts and data files.
  - **SQL Scripts**:
    - `Create_Database_Cataschevastica.sql`
    - `Data_Population.sql`
    - `Command_Statements_Cataschevastica.sql`
    - `Queries_Cataschevastica.sql`
  - **Data Files** (under `Database/Data/`):
    - `Customer_Table.csv`
    - `Delivery_Table.csv`
    - `Logistics_Partner_Table.csv`
    - `Order_Product_Table.csv`
    - `Orders_Table.csv`
    - `Product_RawMaterial_Table.csv`
    - `Product_table.csv`
    - `Product_table_1.csv`
    - `Production_Record_Table.csv`
    - `Production_Team_Member_Table.csv`
    - `raw_material_data.csv`
    - `Supplier_Table.csv`

- **`Documentation/`**: ERD diagram and Relational Schema for the database design.
  - `erd_diagram.png`
  - `relational_schema.png`

- **`Stage_2/`**: Placeholder for files related to Data Warehouse and BI (ETL scripts, Power BI dashboards).

## Folder Structure
```
├── OLTP Database
│   ├── Blueprint
│       ├── erd_diagram.png
│       ├── relational_schema.png
        └── README.md
│   ├── Data
│       ├── Customer_Table.csv
│       ├── Delivery_Table.csv
│       ├── Logistics_Partner_Table.csv
│       ├── Order_Product_Table.csv
│       ├── Orders_Table.csv
│       ├── Product_RawMaterial_Table.csv
│       ├── Product_Table.csv
│       ├── Production_Record_Table.csv
│       ├── Production_Team_Member_Table.csv
│       ├── Raw_Material_Table.csv
│       └── Supplier_Table.csv
│   ├── Create_Database_Cataschevastica.sql
│   ├── Data_Population.sql
│   ├── Command_Statements_Cataschevastica.sql
│   ├── Queries_Cataschevastica.sql
│   └── README.md
│
├── Data_Warehouse
│   ├── Data
│       ├── dw_dim_customers.csv
│       ├── dw_dim_date.csv
│       ├── dw_dim_delivery.csv
│       ├── dw_dim_product.csv
│       ├── dw_dim_supplier.csv
│       ├── dw_fact_production.csv
│       └── dw_fact_sales.csv
│   ├── Databricks
│       ├── Import_from_Azure_Blob_Storage.ipynb
│       └── Import_from_Azure_Blob_Storage.html
│   ├── PowerBI
│       └── Cataschevastica_PowerBI.pbix       
│   ├── Create_Data_Warehouse.sql
│   ├── Create_DimDate.sql
│   ├── Create_Staging.sql
│   ├── Load_Data_Warehouse.sql
│   ├── Create_Views.sql
│   ├── DimCustomer_Scd_Type_2.sql
│   ├── DimDelivery_Scd_Type_2.sql
│   ├── DimProduct_Scd_Type_2.sql
│   ├── DimSupplier_Scd_Type_2.sql
│   ├── Fact_Tables_Incremental_Load.sql
│   └── README.md
└── README.md
```

## Setup Instructions

### Prerequisites

- **MS SQL Server**
- **Azure Blob Storage**
- **Databricks/Apache Spark**
- **Power BI Desktop**

## Usage

- **Placing Orders**: Insert a new order via the command script, and track its status across production and delivery stages.
- **Running Reports**: Use predefined SQL queries to extract insights on production, delivery, and customer orders.
- **Data Warehouse**: Perform advanced analysis using the ETL pipelines and visualizations via Power BI.


