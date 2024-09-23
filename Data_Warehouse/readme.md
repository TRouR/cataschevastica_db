## Stage 2: Data Warehouse and BI Pipeline

This stage involves building a Data Warehouse (DW) for analytical processing, using ETL processes and integrating with Azure Blob storage, Databricks, and Power BI.

### Process Overview:
1. **Staging Area**:
   - Data is extracted from the OLTP database and loaded into a **Staging Database** for cleansing and transformations.
   
2. **Data Warehouse**:
   - Designed with a **constellation schema** with fact and dimension tables.
   - Facts are loaded incrementally using the **rowversion column**, while dimensions implement **SCD Type 2** to preserve historical data.
   
3. **ETL Process**:
   - SQL scripts handle data extraction from the OLTP database, transformation in the staging area, and loading into the Data Warehouse.

4. **Data Lake**:
   - Data is uploaded to **Azure Blob Storage** for further processing and analysis.
   - **Azure Blob Storage JSON**:
     ```json
     {
         "sku": { "name": "Standard_LRS", "tier": "Standard" },
         "kind": "StorageV2",
         "location": "eastus2",
         "properties": {
             "dnsEndpointType": "Standard",
             "primaryEndpoints": {
                 "blob": "https://catascevasticasa.blob.core.windows.net/"
             },
             "creationTime": "2024-06-18T09:52:15.2120033Z"
         }
     }
     ```

5. **Databricks and Apache Spark**:
   - Data is processed in **Databricks** using **Apache Spark**.
   - Transformed into **Parquet files** and analyzed using **Spark SQL** queries.

6. **Power BI Dashboard**:
   - The **Power BI** dashboard is built to visualize the data from the Data Warehouse for business insights.

### Files:
- **SQL Scripts**:
  - `Create_Data_Warehouse.sql`: Creates the DW.
  - `Create_Staging.sql`: Creates the staging area.
  - `DimCustomer_Scd_Type_2.sql`: Implements SCD Type 2 for Customer dimension.
  - Scripts implementing **incremental loading** for fact tables and **SCD Type 2** for dimensions tables.
  
- **Azure Data Lake**:
  - Files in **Parquet format** for efficient querying and storage.
  
- **Power BI**:
  - Interactive dashboard for visualizing DW data and deriving actionable insights.
