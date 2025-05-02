

 Example for SQL Server (using STRING_SPLIT):
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
 Example for PostgreSQL (using unnest and string_to_array):
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
 Example for MySQL 8.0+ (using JSON_TABLE):
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
question 2
SQL Transformation

1. Create Orders table:
sql
Copy
Edit
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
2. Create OrderItems table:
sql
Copy
Edit
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
3. Insert data into Orders:
sql
Copy
Edit
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;
4. Insert data into OrderItems:
sql
Copy
Edit
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
