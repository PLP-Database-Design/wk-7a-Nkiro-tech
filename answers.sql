

✅ Example for SQL Server (using STRING_SPLIT):
sql
Copy
Edit
SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM 
    ProductDetail
CROSS APPLY 
    STRING_SPLIT(Products, ',');
✅ Example for PostgreSQL (using unnest and string_to_array):
sql
Copy
Edit
SELECT 
    OrderID,
    CustomerName,
    TRIM(product) AS Product
FROM 
    ProductDetail,
    unnest(string_to_array(Products, ',')) AS product;
✅ Example for MySQL 8.0+ (using JSON_TABLE):
sql
Copy
Edit
SELECT 
    OrderID,
    CustomerName,
    TRIM(product) AS Product
FROM 
    ProductDetail,
    JSON_TABLE(
        CONCAT('["', REPLACE(Products, ', ', '","'), '"]'),
        '$[*]' COLUMNS (product VARCHAR(100) PATH '$')
    ) AS jt;
Each of these queries will return:

OrderID	CustomerName	Product
101	John Doe	Laptop
101	John Doe	Mouse
102	Jane Smith	Tablet
102	Jane Smith	Keyboard
102	Jane Smith	Mouse
103	Emily Clark	Phone
