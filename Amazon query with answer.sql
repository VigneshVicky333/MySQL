-- Question No : 1) List all customers who have made purchases of more than $80?

-- To list all customers who have made purchases of more than $80 from your Amazon database,
-- with tables Users, Products, Orders, and OrderDetails, you can follow these steps:

/*
Step 1: Understand the Table Structure
Assume the tables have the following columns:

Users:
  - user_id: Unique identifier for each user.
  - first_name: First name of the user.
  - last_name: Last name of the user.
  - email: Email address of the user.

Products:
  - product_id: Unique identifier for each product.
  - product_name: Name of the product.
  - price: Price of the product.

Orders:
  - order_id: Unique identifier for each order.
  - user_id: ID of the user who placed the order.
  - order_date: Date the order was placed.

OrderDetails:
  - order_detail_id: Unique identifier for each order detail.
  - order_id: ID of the order this detail belongs to.
  - product_id: ID of the product in the order.
  - quantity: Quantity of the product ordered.
  - price: Price of the product at the time of order.
*/

-- Step 2: Query Logic
-- Join the Users, Orders, and OrderDetails tables.
-- Calculate the total purchase amount for each user using SUM.
-- Use GROUP BY to group purchases by user_id.
-- Filter out users whose total purchase amount exceeds $80 using HAVING.



-- Explanation of the Query
-- Joins:
-- Users table is joined with Orders using user_id.
-- Orders is joined with OrderDetails using order_id.
-- Aggregation:
-- SUM(od.quantity * od.price) calculates the total amount spent per user.
-- Grouping:
-- GROUP BY u.user_id, customer_name ensures that we get totals per customer.
-- Filter:
-- HAVING total_spent > 80 filters users who spent more than $80.
-- Ordering:
-- ORDER BY total_spent DESC orders customers by the total amount spent in descending order.


SELECT 
    u.user_id,
    u.name AS customer_name,
    SUM(od.quantity * p.price) AS total_spent
FROM 
    Users u
JOIN 
    Orders o ON u.user_id = o.user_id
JOIN 
    OrderDetails od ON o.order_id = od.order_id
JOIN 
    Products p ON od.product_id = p.product_id
GROUP BY 
    u.user_id, u.name
HAVING 
    total_spent > 80
ORDER BY 
    total_spent DESC;
    
    -- Final Output:
-- user_id	customer_name	total_spent
-- 1	Alice Johnson	   149.97
-- 2	Bob Smith	       129.99

-- Use SUM(od.quantity * p.price) to calculate total spending by customers.
-- Join all the necessary tables (Users, Orders, OrderDetails, and Products).
-- Group by customer and filter those with spending above $80.
    
    DESCRIBE Users;
    
-- Expected Output: 

-- Step-by-Step Analysis:
-- Alice Johnson (user_id = 1):

-- Order 1: 2 × Echo Dot ($49.99) = $99.98.
-- Order 3: 1 × Echo Dot ($49.99) = $49.99.
-- Total Spent: $149.97.

-- Bob Smith (user_id = 2):

-- Order 2: 1 × Kindle Paperwhite ($129.99) = $129.99.
-- Total Spent: $129.99.

-- Charlie Brown (user_id = 3):

-- Order 4: 1 × Wireless Mouse ($24.99) = $24.99.
-- Total Spent: $24.99.

-- Question No:2  To retrieve all orders placed in the last 280 days along with the customer's name and email, 
-- we follow these steps:

-- Calculate the Date Range:
-- Use the DATE_SUB function to subtract 280 days from the current date (CURDATE()).
-- Filter orders where the order_date is greater than or equal to this calculated date.

-- Join Tables:
-- Join the Users and Orders tables:
-- Users contains customer details (e.g., name, email).
-- Orders contains the orders placed by users.

-- Select Required Columns:
-- Retrieve order_id, order_date from Orders, and name, email from Users.

-- Filter the Data:
-- Use the WHERE clause to filter orders based on the date range.

-- Order the Results (Optional):
-- Sort the results by order_date in descending order to display the latest orders first.



SELECT 
    o.order_id,
    o.order_date,
    u.name AS customer_name,
    u.email AS customer_email
FROM 
    Orders o
JOIN 
    Users u ON o.user_id = u.user_id
WHERE 
    o.order_date >= DATE_SUB(CURDATE(), INTERVAL 280 DAY)
ORDER BY 
    o.order_date DESC;
    
  
-- Question NO: 3. Find the average product price for each category.

SELECT 
    category,
    AVG(price) AS average_price
FROM 
    Products
GROUP BY 
    category
ORDER BY 
    category;

-- Select Relevant Columns:
-- Retrieve the category and the average of price for products in each category.

-- Use Aggregate Function:
-- Use the AVG function to calculate the average price for products in each category.

-- Group the Data:
-- Use the GROUP BY clause to group products by their category.

-- Optional Sorting:
-- Use the ORDER BY clause to sort the results by category name or average price.

-- SELECT Clause:
-- Retrieve category to identify product groups.
-- Calculate the average price for each category using AVG(price).

-- FROM Clause:
-- Use the Products table, as it contains product details, including price and category.

-- GROUP BY Clause:
-- Group the products by category to calculate the average price for each category.

-- ORDER BY Clause (Optional):
-- Sort the results alphabetically by category for readability.




-- Question No: 4. List all customers who have purchased a product from the category Electronics?

-- To retrieve customers who have purchased products from the category "Electronics," 
-- you need to join multiple tables and filter by the desired category.

-- Identify Relevant Tables:
-- Use the Users, Orders, OrderDetails, and Products tables.

-- Join Tables:
-- Join Users with Orders (via user_id) and Orders with OrderDetails (via order_id).
-- Join OrderDetails with Products (via product_id) to get the product details, including the category.

-- Filter by Category:
-- Use the WHERE clause to select only the rows where the category is "Electronics."

-- Select Required Columns:
-- Retrieve customer details (user_id, name, and email) to list all customers who meet the criteria.

-- Avoid Duplicates:
-- Use DISTINCT to ensure each customer is listed only once, even if they purchased multiple products from the category.

SELECT DISTINCT 
    u.user_id,
    u.name AS customer_name,
    u.email
FROM 
    Users u
JOIN 
    Orders o ON u.user_id = o.user_id
JOIN 
    OrderDetails od ON o.order_id = od.order_id
JOIN 
    Products p ON od.product_id = p.product_id
WHERE 
    p.category = 'Electronics';

-- Explanation
-- DISTINCT:
-- Ensures that customers appear only once, even if they made multiple purchases in the "Electronics" category.

-- SELECT Clause:
-- Retrieve user_id, name, and email from the Users table.

-- FROM Clause and Joins:
-- Users → Orders (user_id).
-- Orders → OrderDetails (order_id).
-- OrderDetails → Products (product_id).

-- WHERE Clause:
-- Filters only products with category = 'Electronics'.




-- Question No: 5. Find the total number of products sold and the total revenue generated for each product?

-- To determine the total number of products sold and the total revenue generated for each product,
-- you need to analyze the OrderDetails table and join it with the Products table.

-- Identify Relevant Tables:
-- Use the OrderDetails and Products tables.

-- Join Tables:
-- Join OrderDetails with Products using the product_id.

-- Aggregate Data:
-- Use the SUM() function to calculate the total quantity sold and the total revenue generated for each product.

-- Group by Product:
-- Group data by product_id and product name.

-- Select Required Columns:
-- Include product_id, name (product name), total quantity, and total revenue.

SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * p.price) AS total_revenue_generated
FROM 
    OrderDetails od
JOIN 
    Products p ON od.product_id = p.product_id
GROUP BY 
    p.product_id, p.name
ORDER BY 
    total_revenue_generated DESC;

-- Explanation
-- SELECT Clause:
-- p.product_id: Unique identifier of the product.
-- p.name: Product name.
-- SUM(od.quantity): Total number of units sold.
-- SUM(od.quantity * p.price): Total revenue generated by multiplying quantity with product price.

-- FROM Clause and Join:
-- The OrderDetails table contains information about quantities sold.
-- The Products table contains product details such as price.

-- GROUP BY Clause:
-- Groups the data by each product to compute aggregates.

-- ORDER BY Clause:
-- Sorts the results by total revenue in descending order to show the most profitable products first.



-- Question No:6. Update the price of all products in the Books category, increasing it by 10% Query. 

SET SQL_SAFE_UPDATES = 0;

-- SET SQL_SAFE_UPDATES = 0;: This command temporarily disables safe update mode for your session.
-- In MySQL, safe updates prevent potentially risky UPDATE or DELETE operations without a WHERE clause or a LIMIT clause that could affect all rows in the table.
-- By setting SQL_SAFE_UPDATES to 0, you're telling MySQL to allow the update query to run without checking if it could affect too many rows. 
-- If safe updates are enabled (i.e., SET SQL_SAFE_UPDATES = 1), MySQL would require more cautious conditions like a LIMIT clause or a proper key in the WHERE clause.

-- Next, the main UPDATE statement:
UPDATE Products
SET price = price * 1.10
WHERE category = 'Books';

-- The warning 1265 Data truncated for column 'price' at row 2 indicates that the value you're trying to assign to the price column after multiplying by 1.10 is too large or doesn't fit the defined data type of the price column. This is likely because the column is not defined with sufficient precision to accommodate decimal values or large numbers.

-- Steps to solve the issue:
-- 1. Check the datatype of the price column:
-- You should first inspect the datatype of the price column to ensure it can handle fractional values and larger numbers. Typically, DECIMAL or FLOAT are good choices for price columns.

-- To check the column definition, run the following query:
DESCRIBE Products;

UPDATE Products
SET price = price * 1.10
WHERE category = 'Books';

-- If the price column is already of type DECIMAL(10, 2) and you're still encountering the 1265 Data truncated for column 'price' at row 2 warning, it likely means that the result of the calculation (price * 1.10) is exceeding the allowed precision for a DECIMAL(10, 2) column. This type can store numbers with up to 10 digits in total, including 2 digits after the decimal point (e.g., the maximum value is 99999999.99).

-- Steps to Resolve:
-- 1. Identify the problematic row:
-- Run a query to find the maximum price in the Books category before the update:

SELECT MAX(price) AS max_price
FROM Products
WHERE category = 'Books';

-- If the maximum price in the "Books" category is 190.32 and you're still encountering the truncation warning when multiplying by 1.10, the issue is likely due to one of the following:

-- A corrupted or invalid value in the price column for some rows, even though the maximum value appears correct in your query.
-- A data inconsistency or mismatch between the defined column type and the actual stored values.
-- Here’s how you can investigate and resolve the issue:

-- 1. Check for any unexpected values in the price column:
-- Run a query to look for values that might not fit into the DECIMAL(10, 2) range or have anomalies (e.g., non-numeric or overly precise values):

SELECT *
FROM Products
WHERE category = 'Books'
  AND (price < 0 OR price > 99999999.99 OR price IS NULL);
  
  -- Additionally, check for precision issues that might not fit the DECIMAL(10, 2) format:
  
  SELECT *
FROM Products
WHERE category = 'Books'
  AND price != ROUND(price, 2);

--  If both queries return NULL for the columns product_id, name, price, category, and stock, this indicates that there might be unexpected issues with your data. Let's troubleshoot step by step:
-- 1. Check for NULL values in the price column:
-- There may be rows where the price column itself is NULL, which would cause issues during the update. Run this query to check:

SELECT *
FROM Products
WHERE category = 'Books' AND price IS NULL;

-- If there are rows with NULL prices, they will cause the price * 1.10 operation to fail because arithmetic operations with NULL result in NULL.

-- How to handle NULL prices:
-- If you find rows with NULL in the price column, you can replace them with a default value (e.g., 0) before performing the update:

UPDATE Products
SET price = 0
WHERE category = 'Books' AND price IS NULL;

-- Then re-run your original UPDATE query.

UPDATE Products
SET price = price * 1.10
WHERE category = 'Books';

-- 2. Check for NULL or blank categories:
-- It's possible that some rows in the Products table have a blank or NULL category. This would prevent the WHERE category = 'Books' clause from matching those rows. Check for such rows:

SELECT *
FROM Products
WHERE category IS NULL OR category = '';

-- 1. Check the Total Rows in the Table
-- Verify if the table contains any valid data using this query:

SELECT COUNT(*) AS total_rows
FROM Products;

-- If the result is 0, your table might be empty.
-- If the result is greater than 0, there could be rows with corrupted or invalid data.

-- We are getting result as --> 5

-- 1. Check for Rows with Corrupted Data
-- Run the following query to identify rows with all NULL values:

SELECT *
FROM Products
WHERE product_id IS NULL
  AND name IS NULL
  AND price IS NULL
  AND category IS NULL
  AND stock IS NULL;

--   --  -- 


-- Question No: 7. Remove all orders that were placed before 2020

-- To remove all orders placed before 2020, follow these steps:

-- 1. Analyze the Table Structure
-- Before proceeding, ensure you understand the structure of your Orders table. Run this query to inspect the table:

DESCRIBE Orders;

-- 2. Check Orders Before 2020
-- Preview the rows that will be affected by the deletion:

SELECT *
FROM Orders
WHERE order_date < '2020-01-01';



-- If the result contains all NULL values for the Orders table, it suggests data corruption or invalid data in the table, similar to the issue you encountered with the Products table. Here's how you can proceed to diagnose and resolve the issue:

-- 1. Check Total Rows in the Table
-- Verify how many rows are present in the Orders table using:

SELECT COUNT(*) AS total_rows
FROM Orders;


-- If 0, the table is empty.
-- If greater than 0, it confirms the table has rows, but they may be corrupted.
-- Here,it gives the result as 4

-- 2. Check for Rows with All NULL Values
-- Run the following query to identify rows where all columns are NULL:

SELECT *
FROM Orders
WHERE order_id IS NULL
  AND user_id IS NULL
  AND order_date IS NULL
  AND total_amount IS NULL;
  
 --  Yes, that's right. If the result shows that there are rows in the Orders table but the values are all NULL, it could indicate corruption or an issue with how the data is being retrieved or stored. Here are the next steps to troubleshoot:

-- Check for Data Integrity
-- Run the following query to check if there is any non-null data in the table:

DESCRIBE Orders;

DELETE FROM 
    Orders
WHERE 
    order_date < '2020-01-01';
    
    
    
    
-- Question 8: Write a query to fetch the order details, including customer name, product name, and
    -- quantity, for orders placed on 2024-05-01. 8
    -- To fetch the order details, including customer name, product name, and quantity for orders placed on 2024-05-01, you need to join the Orders, Users, OrderDetails, and Products tables. Here's the SQL query to do that:


    
    SELECT 
    O.order_id, 
    U.name AS customer_name, 
    P.name AS product_name, 
    OD.quantity
FROM 
    Orders O
JOIN 
    Users U ON O.user_id = U.user_id
JOIN 
    OrderDetails OD ON O.order_id = OD.order_id
JOIN 
    Products P ON OD.product_id = P.product_id
WHERE 
    O.order_date = '2024-5-01';
    

-- Question No: 9. Fetch all customers and the total number of orders they have placed.

-- To fetch all customers and the total number of orders they have placed, you can use a JOIN between the Users and Orders tables, and then use the COUNT() function to count the number of orders for each customer


SELECT 
    U.name AS customer_name, 
    U.email, 
    COUNT(O.order_id) AS total_orders
FROM 
    Users U
LEFT JOIN 
    Orders O ON U.user_id = O.user_id
GROUP BY 
    U.user_id;


-- 1. SELECT Clause:
-- This part of the query specifies the columns that will be included in the result:
-- 
-- U.name AS customer_name: Retrieves the name of the customer from the Users table (aliased as U) and labels it as customer_name in the output.
-- U.email: Retrieves the email of the customer from the Users table.
-- COUNT(O.order_id) AS total_orders: Uses the COUNT() function to count the number of orders placed by each customer. It counts the order_id from the Orders table (aliased as O) and labels the result as total_orders. If a customer has no orders, the count will be 0 due to the LEFT JOIN.

-- 2. FROM Clause:
-- The query starts from the Users table, which contains the customer information. The Users table is aliased as U for easier reference.

-- 3. LEFT JOIN Clause:
-- LEFT JOIN Orders O ON U.user_id = O.user_id: This LEFT JOIN combines the Users table with the Orders table based on the user_id. The LEFT JOIN ensures that all users are included in the result, even if they don't have any orders.
-- If a customer has placed no orders, the COUNT() function will count 0 because there are no matching rows in the Orders table.
-- If a customer has one or more orders, the COUNT() function will count how many order_id records exist for that customer.

-- 4. GROUP BY Clause:
-- GROUP BY U.user_id: This groups the results by each customer's unique user_id. Each customer will have one row in the output, and the COUNT(O.order_id) will give the total number of orders for that specific customer.

-- Result:
-- The result of this query will show a list of customers, their emails, and the total number of orders they have placed:
-- 
-- customer_name: The name of the customer.
-- email: The email of the customer.
-- total_orders: The total number of orders the customer has placed (0 if they haven't placed any orders).



-- Question No: 10. Retrieve the average rating for all products in the Electronics category

-- To retrieve the average rating for all products in the "Electronics" category, you would typically need a Ratings table where the ratings of each product are stored. 
-- However, based on the tables you have provided (Users, Products, Orders, and OrderDetails), there is no Ratings table. 
-- If a Ratings table were available, the query would look something like this:

-- Example Ratings Table Structure:

-- Ratings:
-- - rating_id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- - product_id (INT, FOREIGN KEY REFERENCES Products(product_id))
-- - rating (DECIMAL(3, 2)) -- e.g., rating values from 0 to 5

-- Assuming you have a Ratings table, here's how you would fetch the average rating for all products in the "Electronics" category:

SELECT 
    P.name AS product_name,
    AVG(R.rating) AS average_rating
FROM 
    Products P
JOIN 
    Ratings R ON P.product_id = R.product_id
WHERE 
    P.category = 'Electronics'
GROUP BY 
    P.product_id;

-- Here, for us no rating table exist, just for reference, the above code.




-- Question No :11 List all customers who purchased more than 1 units of any product, including the product
-- name and total quantity purchased.

-- To list all customers who purchased more than 1 unit of any product, 
-- including the product name and total quantity purchased, you need to join the Users, Orders, OrderDetails, and Products tables. 
-- Then, you can filter the results based on the condition that the total quantity purchased is greater than 1.

SELECT 
    U.name AS customer_name,
    P.name AS product_name,
    SUM(OD.quantity) AS total_quantity_purchased
FROM 
    Users U
JOIN 
    Orders O ON U.user_id = O.user_id
JOIN 
    OrderDetails OD ON O.order_id = OD.order_id
JOIN 
    Products P ON OD.product_id = P.product_id
GROUP BY 
    U.user_id, P.product_id
HAVING 
    SUM(OD.quantity) > 1;
    
    
    
    
    -- Question No: 12. Find the total revenue generated by each category along with the category name.

-- To find the total revenue generated by each category along with the category name, 
-- you'll need to join the Products, OrderDetails, and Orders tables. 
-- By multiplying the product price with the quantity ordered, you can calculate the revenue for each product. 
-- Then, you can group the results by category to get the total revenue for each category.

SELECT 
    P.category AS category_name,
    SUM(P.price * OD.quantity) AS total_revenue
FROM 
    Products P
JOIN 
    OrderDetails OD ON P.product_id = OD.product_id
JOIN 
    Orders O ON OD.order_id = O.order_id
GROUP BY 
    P.category;


-- Explanation:
-- SELECT Clause:
-- P.category AS category_name: Retrieves the category of the product from the Products table and labels it as category_name.
-- SUM(P.price * OD.quantity) AS total_revenue: Calculates the total revenue by multiplying the price of the product (P.price) with the quantity purchased (OD.quantity) for each order. The SUM() function aggregates the total revenue for each category.

-- FROM Clause:
-- We're starting with the Products table (aliased as P) because you need to access the category and price information.

-- JOIN Clauses:
-- JOIN OrderDetails OD ON P.product_id = OD.product_id: Joins the Products table with the OrderDetails table to get the quantity ordered for each product.
-- JOIN Orders O ON OD.order_id = O.order_id: Joins the OrderDetails table with the Orders table to ensure the data is linked to the orders.

-- GROUP BY Clause:
-- GROUP BY P.category: Groups the result by the product category, so you get the total revenue for each category.

-- Result:
-- This query will return the total revenue generated by each product category.
