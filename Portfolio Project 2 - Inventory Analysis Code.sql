-- Inventory Analysis Project --

-- Data Cleaning

-- Viewing Customers Table
SELECT *
FROM customers;

-- I noticed customer names with odd spelling, I will correct them with an update statement.
SELECT customer_name
FROM customers
WHERE customer_id = "CR-12580";
UPDATE customers
SET customer_name = "Clay Rozendal"
WHERE customer_id = "CR-12580";
UPDATE customers
SET customer_name = "Linda Cazamias"
WHERE customer_id = "LC-16930";
UPDATE customers
SET customer_name = "Michelle Ellison"
WHERE customer_id = "ME-18010";
UPDATE customers
SET customer_name = "Micheal Grace"
WHERE customer_id = "MG-17875";

-- Viewing Products Table
SELECT * 
FROM products;

-- Viewing Locations Table
SELECT *
FROM locations;

-- Viewing Order table with a limit for performance
SELECT *
FROM orders
LIMIT 100;

-- Viewing NULLs within Products table
SELECT *
FROM products
WHERE Product_ID IS NULL;

-- Removing NULLs from Products Table
DELETE FROM products 
WHERE Product_ID IS NULL;


-- Order Date conversion to MySQL date format
SELECT 
	Order_date,
    STR_TO_DATE(order_date, '%m/%d/%Y') AS string_date,
    DATE(STR_TO_DATE(order_date, '%m/%d/%Y')) AS formatted_date
FROM orders
LIMIT 10;

-- After a test check of my conversion, I will now implement the changes
UPDATE orders
SET order_date =  DATE(STR_TO_DATE(order_date, '%m/%d/%Y'));

-- Column data type was VARCHAR(50). After making the date format conversion, I will also update the column data type
ALTER TABLE orders
MODIFY COLUMN order_date DATE;

-- Repeated date format and data type conversion for ship_date
SELECT 
	ship_date,
    STR_TO_DATE(ship_date, '%m/%d/%Y') AS string_date,
    DATE(STR_TO_DATE(ship_date, '%m/%d/%Y')) AS formatted_date
FROM orders
LIMIT 10;

UPDATE orders
SET ship_date =  DATE(STR_TO_DATE(ship_date, '%m/%d/%Y'));

ALTER TABLE orders
MODIFY COLUMN ship_date DATE;

-- Viewing date changes to Orders table
SELECT *
FROM orders
LIMIT 10;

-- Exploratory Data Analysis -- 

-- Total Number of customers
SELECT COUNT(customer_id)
FROM customers;

-- Total number of unique cities and states
SELECT COUNT(DISTINCT City)
FROM locations;
SELECT COUNT(DISTINCT State)
FROM locations;

-- Top 10 Products by Sales
SELECT 
	prod.category AS product_category,
    prod.sub_category AS sub_category,
	prod.product_name AS product,
    SUM(ord.sales) AS total_sales
FROM products AS prod
LEFT JOIN orders AS ord
	ON prod.product_id = ord.product_id
GROUP BY prod.Category,prod.Sub_Category,prod.Product_Name
ORDER BY SUM(ord.sales) DESC
LIMIT 10;

-- Bottom 10 Products by Sales
SELECT 
	prod.category AS product_category,
    prod.sub_category AS sub_category,
	prod.product_name AS product,
    SUM(ord.sales) AS total_sales
FROM products AS prod
LEFT JOIN orders AS ord
	ON prod.product_id = ord.product_id
GROUP BY prod.Category,prod.Sub_Category,prod.Product_Name
ORDER BY SUM(ord.sales) ASC
LIMIT 10;

-- Top Products by Category and Sales
SELECT
	prod.category AS category,
    SUM(ord.sales) AS total_sales
FROM products AS prod
LEFT JOIN orders AS ord
	ON prod.Product_ID=ord.Product_ID
GROUP BY prod.category
ORDER BY total_sales DESC;


-- Top 3 products by category and sales for each year
WITH top_product_insights AS(
	SELECT
		YEAR(ord.order_date) as year,
		prod.category AS category,
		prod.product_id AS product_id,
		SUM(ord.sales) AS total_sales,
		DENSE_RANK() OVER(PARTITION BY YEAR(ord.order_date),prod.category ORDER BY SUM(ord.sales) DESC) AS product_rank
	FROM products AS prod
	LEFT JOIN orders AS ord
		ON prod.Product_ID=ord.Product_ID
	WHERE YEAR(ord.order_date) IS NOT NULL
	GROUP BY YEAR(ord.order_date), prod.category, prod.product_id
)
SELECT * 
FROM top_product_insights
WHERE product_rank < 4;

-- Bottom 3 Products of each year by sales
WITH product_insights AS(
	SELECT
		YEAR(ord.order_date) as year,
		prod.category AS category,
		prod.product_id AS product_id,
		SUM(ord.sales) AS total_sales,
		DENSE_RANK() OVER(PARTITION BY YEAR(ord.order_date),prod.category ORDER BY SUM(ord.sales) ASC) AS product_rank
	FROM products AS prod
	LEFT JOIN orders AS ord
		ON prod.Product_ID=ord.Product_ID
	WHERE YEAR(ord.order_date) IS NOT NULL
	GROUP BY YEAR(ord.order_date), prod.category, prod.product_id
)
SELECT *
FROM product_insights
WHERE product_rank < 4;

-- Top Products by units/quantity sold with sales information
SELECT 
	prod.category AS product_category,
    prod.sub_category AS sub_category,
	prod.product_name AS product,
    SUM(ord.quantity) AS units_sold,
    SUM(ord.sales) AS total_sales
FROM products AS prod
LEFT JOIN orders as ord
	ON prod.product_id = ord.product_id
GROUP BY prod.Category,prod.Sub_Category,prod.Product_Name
ORDER BY SUM(ord.quantity) DESC
LIMIT 10;

-- Products by lowest units/quantity sold with sales information
SELECT 
	prod.category AS product_category,
    prod.sub_category AS sub_category,
	prod.product_name AS product,
    SUM(ord.quantity) AS units_sold,
    SUM(ord.sales) AS total_sales
FROM products AS prod
LEFT JOIN orders as ord
	ON prod.product_id = ord.product_id
GROUP BY prod.Category,prod.Sub_Category,prod.Product_Name
ORDER BY SUM(ord.quantity) ASC
LIMIT 10;

-- A null in this case signifies that the product has never been sold

-- Data Extraction

-- ABC Analysis

-- I will gather the necessary data for ABC analysis and finish it in Excel
SELECT 
	product_id,
    SUM(sales) AS total_sales 
FROM orders
GROUP BY product_id
ORDER BY total_sales DESC;

-- This data was exported to Excel for further analysis

-- Demand Forecasting

-- I will gather the demand / units sold each month of each year for a demand forecast for the following year 
SELECT
	YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(quantity) AS demand
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- ABC Analysis Discontinuing Product Recommendations

-- Lets gather aggregates of Profits, Sales, and Total Cost
SELECT
	SUM(Profit),
    SUM(Sales),
    SUM(profit-sales) AS cogs
FROM orders;

-- Now lets examine removing products with sales figures below 100 and see the impact
WITH discontinued_products_whatif AS(
	SELECT
		product_id,
		SUM(sales) AS total_sales,
		SUM(profit) AS total_profit,
		SUM(profit-sales) AS total_cogs
	FROM orders
	GROUP BY product_id
	HAVING SUM(sales) < 100
	ORDER BY SUM(sales) DESC
)
SELECT 
	SUM(total_profit),
	SUM(total_sales),
    SUM(total_cogs),
    ROUND(SUM(total_profit) / (SELECT SUM(profit) FROM orders),2) * 100 AS profit_total_percentage,
    ROUND(SUM(total_cogs) / (SELECT SUM(profit-sales) FROM orders),2) * 100 AS cogs_total_percentage,
    ROUND(SUM(total_sales) / (SELECT SUM(sales) FROM orders),2) * 100 AS sales_total_percentage
FROM discontinued_products_whatif;

-- If we were to discontinue all products below 100 in sales, a 2% reduction in profit, 1% reduction in sales and total cogs.
WITH discontinued_products_whatif AS(
	SELECT
		product_id,
		SUM(sales) AS total_sales,
		SUM(profit) AS total_profit,
		SUM(profit-sales) AS total_cogs
	FROM orders
	GROUP BY product_id
	HAVING SUM(sales) < 100
	ORDER BY SUM(sales) DESC
), products_over_avg AS(
	SELECT *,
		(total_cogs/total_sales) AS cost_percentage,
		AVG(total_cogs/total_sales) OVER() AS average_cost_percentage
	FROM discontinued_products_whatif
), discontinue_products_whatif2 AS(
	SELECT *
	FROM products_over_avg
	WHERE ABS(cost_percentage) > ABS(average_cost_percentage)
) 
SELECT 
	SUM(total_sales),
    SUM(total_profit),
    SUM(total_cogs),
    ROUND(SUM(total_profit) / (SELECT SUM(profit) FROM orders),3) * 100 AS profit_total_percentage,
    ROUND(SUM(total_cogs) / (SELECT SUM(profit-sales) FROM orders),3) * 100 AS cogs_total_percentage,
    ROUND(SUM(total_sales) / (SELECT SUM(sales) FROM orders),3) * 100 AS sales_total_percentage
FROM discontinue_products_whatif2;

-- If we were to remove products whose sales were less than 100 AND whose cost percentage is greater than the AVG cost percentage, profit would reduce by .1%, cost would reduce by .5, and sales would reduce by .4

-- Now Im going to switch the requirements to 350 in sales
WITH discontinued_products_under350 AS(
	SELECT
		product_id,
		SUM(sales) AS total_sales,
		SUM(profit) AS total_profit,
		SUM(profit-sales) AS total_cogs
	FROM orders
	GROUP BY product_id
	HAVING SUM(sales) < 350
	ORDER BY SUM(sales) DESC
)
SELECT 
	SUM(total_profit),
	SUM(total_sales),
    SUM(total_cogs),
    ROUND(SUM(total_profit) / (SELECT SUM(profit) FROM orders),2) * 100 AS profit_total_percentage,
    ROUND(SUM(total_cogs) / (SELECT SUM(profit-sales) FROM orders),2) * 100 AS cogs_total_percentage,
    ROUND(SUM(total_sales) / (SELECT SUM(sales) FROM orders),2) * 100 AS sales_total_percentage
FROM discontinued_products_under350;

-- If we were to remove all products below 350 in sales, a 10% reduction in profit would occur, 5% reduction in total cost and sales would occur

-- Now we will see if products above the average cost percentage are removed
WITH discontinued_products_under350 AS(
	SELECT
		product_id,
		SUM(sales) AS total_sales,
		SUM(profit) AS total_profit,
		SUM(profit-sales) AS total_cogs
	FROM orders
	GROUP BY product_id
	HAVING SUM(sales) < 350
	ORDER BY SUM(sales) DESC
), products_over_avg_2 AS(
	SELECT *,
		(total_cogs/total_sales) AS cost_percentage,
		AVG(total_cogs/total_sales) OVER() AS average_cost_percentage
	FROM discontinued_products_under350
), discontinue_products_over_costper AS(
	SELECT *
	FROM products_over_avg_2
	WHERE ABS(cost_percentage) > ABS(average_cost_percentage)
) 
SELECT 
	SUM(total_profit) AS total_profit,
	SUM(total_sales) AS total_sales,
    SUM(total_cogs) AS total_cost,
    ROUND(SUM(total_profit) / (SELECT SUM(profit) FROM orders),3) * 100 AS profit_total_percentage,
    ROUND(SUM(total_cogs) / (SELECT SUM(profit-sales) FROM orders),3) * 100 AS cogs_total_percentage,
    ROUND(SUM(total_sales) / (SELECT SUM(sales) FROM orders),3) * 100 AS sales_total_percentage,
    COUNT(Product_id) AS removed_products
FROM discontinue_products_over_costper;

-- Removing these products would account for a .9% reduction in profit, a 2.6% reduction in total cost, and a reduction of 2.4 in sales. This would lead to overall better cost effectiveness and improve
-- inventory holding costs associated with these products.

WITH discontinued_products_under350 AS(
	SELECT
		product_id,
		SUM(sales) AS total_sales,
		SUM(profit) AS total_profit,
		SUM(profit-sales) AS total_cogs
	FROM orders
	GROUP BY product_id
	HAVING SUM(sales) < 350
		AND SUM(profit) < 0
	ORDER BY SUM(sales) DESC
)
SELECT 
	SUM(total_sales),
    SUM(total_profit),
    SUM(total_cogs),
	ROUND(SUM(total_profit) / (SELECT SUM(profit) FROM orders),3) * 100 AS profit_total_percentage,
    ROUND(SUM(total_cogs) / (SELECT SUM(profit-sales) FROM orders),3) * 100 AS cogs_total_percentage,
    ROUND(SUM(total_sales) / (SELECT SUM(sales) FROM orders),3) * 100 AS sales_total_percentage,
    COUNT(Product_id) AS removed_products
FROM discontinued_products_under350;

-- If we remove products that make less than 350 in total sales and products with negative profits, we will see a total of 3575 dollars in negative profit removed, a .9% reduction in total cost and a .6% reduction in sales.
