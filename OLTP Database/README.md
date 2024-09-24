## Stage 1: OLTP Database

The OLTP database is used to handle real-time transactional processes in the company, focusing on order intake, product manufacturing, and logistics.

### Key Features:
- **Normalized to 3NF**: The database ensures data integrity and eliminates redundancy.
- **Entities**:
  - Customer, Orders, Product, Raw Material, Supplier, Delivery, and more.
- **Queries**:
  - Sample SQL queries for retrieving data such as orders, production reports, and delivery status.

### Files:
- **SQL Scripts**:
  - `Create_Database_Cataschevastica.sql`: Script to create the OLTP database.
  - `Data_Population.sql`: Populates the OLTP database with sample data.
  - `Command_Statements_Cataschevastica.sql`: Statements to simulate operations, such as placing orders, completing production, and marking deliveries.
  - `Queries_Cataschevastica.sql`: Predefined queries for generating reports, such as order status, production, and delivery insights.

## Usage

- **Placing Orders**: Insert a new order via the command script, and track its status across production and delivery stages.
- **Running Reports**: Use predefined SQL queries to extract insights on production, delivery, and customer orders.

