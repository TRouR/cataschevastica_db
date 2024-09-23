# Cataschevastica OLTP Database, Data Warehouse and Analytics

## Overview

This project consists of two major stages developed for a fictitious manufacturing company, **Cataschevastica**, focusing on their **Online Transaction Processing (OLTP)** system and the subsequent **Data Warehouse (DW)** implementation. The project tracks the company's end-to-end manufacturing process, ensuring efficiency, customer satisfaction, and service quality. Additionally, a **Business Intelligence (BI)** dashboard is designed, supporting advanced analytical visualizations.

### Stage 1: OLTP Database

The **Cataschevastica OLTP Database** is designed to support the company’s real-time operational processes, including order intake, product manufacturing, and delivery tracking. It is **normalized to Third Normal Form (3NF)** to ensure data integrity and eliminate redundancy. It supports:

- Order placement and management
- Product inventory and production tracking
- Supplier and raw material management
- Delivery and logistics tracking

### Stage 2: Data Warehouse, Databricks and Power BI

The **Data Warehouse (DW)** was built to facilitate advanced data analysis, enabling insights into production performance, sales, and customer behaviors. The DW is designed in a **constellation schema** and is integrated into **Azure Cloud** using **Blob Storage**. Subsequently, the **Data Lake** is loaded into **Databricks** for processing, using **Apache Spark**. Finally, an interactive dashboard is generated in **Power BI Desktop**, filtering data from the Warehouse.

## Features

1. **Database Design**: ERD and Relational Schema for the OLTP system.
2. **Database Implementation**: SQL scripts to create the OLTP database and populate it with sample data.
3. **Data Queries**: Predefined queries to extract useful insights, such as order reports, production status, and delivery tracking.
4. **ETL Processes**: Extract, Transform, Load scripts to automate data warehouse creation and incremental loading.
5. **Business Intelligence**: Power BI dashboards for analyzing the company's production and sales.

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
├── Database
│   ├── Create_Database_Cataschevastica.sql
│   ├── Data_Population.sql
│   ├── Command_Statements_Cataschevastica.sql
│   ├── Queries_Cataschevastica.sql
│   ├── Data
│       ├── Customer_Table.csv
│       ├── Delivery_Table.csv
│       ├── Logistics_Partner_Table.csv
│       ├── Order_Product_Table.csv
│       ├── Orders_Table.csv
│       ├── Product_RawMaterial_Table.csv
│       ├── Product_table.csv
│       ├── Product_table_1.csv
│       ├── Production_Record_Table.csv
│       ├── Production_Team_Member_Table.csv
│       ├── raw_material_data.csv
│       └── Supplier_Table.csv
│
├── Documentation
│   ├── erd_diagram.png
│   └── relational_schema.png
│
├── Stage_2
│   ├── ETL_Scripts
│   ├── Data_Lake_Scripts
│   └── PowerBI_Reports
│
└── README.md
```

## Setup Instructions

### Prerequisites

- **MS SQL Server** (for running OLTP database scripts)
- **Python / Spark** (for ETL and Data Lake operations)
- **Power BI Desktop** (for viewing and creating reports)

### Stage 1: OLTP Database Setup

1. **Create the OLTP Database**:
   - Run the `Create_Database_Cataschevastica.sql` script located in the `Database/` folder.

2. **Populate the Database**:
   - Execute the `Data_Population.sql` script to insert sample data into the tables.

3. **Run Command Statements**:
   - Use the `Command_Statements_Cataschevastica.sql` to simulate operations such as placing orders, completing production, and marking deliveries.

4. **Extract Information**:
   - Run the queries in the `Queries_Cataschevastica.sql` file to generate reports, such as order status, production, and delivery insights.

### Stage 2: Data Warehouse & BI Setup

1. **ETL Processes**:
   - Use the provided ETL scripts (in the `Stage_2/ETL_Scripts` folder) to extract, transform, and load data into the data warehouse.

2. **Data Lake**:
   - The Spark scripts (to be uploaded in `Stage_2/Data_Lake_Scripts`) will be used for managing and processing data in the Databricks Delta Lake.

3. **Power BI Reports**:
   - Open the `PowerBI_Reports/` folder to access `.pbix` files that generate visualizations directly from the Data Warehouse.

## Usage

- **Placing Orders**: Insert a new order via the command script, and track its status across production and delivery stages.
- **Running Reports**: Use predefined SQL queries to extract insights on production, delivery, and customer orders.
- **Data Warehouse**: Perform advanced analysis using the ETL pipelines and visualizations via Power BI.


