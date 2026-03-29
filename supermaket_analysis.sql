
USE supermarket_analysis;

CREATE TABLE sales (
invoice_id VARCHAR(30),
branch VARCHAR(5),
city VARCHAR(30),
customer_type VARCHAR(30),
gender VARCHAR(10),
product_line VARCHAR(100),
unit_price DECIMAL(10,2),
quantity INT,
tax DECIMAL(10,2),
total DECIMAL(10,2),
date VARCHAR(20),
time VARCHAR(20),
payment VARCHAR(30),
cogs DECIMAL(10,2),
gross_margin_percentage DECIMAL(5,2),
gross_income DECIMAL(10,2),
rating DECIMAL(3,1)
);

SELECT *
FROM sales
LIMIT 10;

-- 1. Total Revenue
SELECT SUM(total) AS total_revenue
FROM sales;

-- 2. Total Transactions
SELECT COUNT(*) AS total_transactions
FROM sales;

-- 3.Average order value
SELECT AVG(total) as avg_order_value
FROM sales;

-- 4. Product Demand by City
SELECT city, 
product_line,
SUM(total) AS revenue
FROM sales
GROUP BY city, product_line
ORDER BY city;

-- 5. Revenue Contribution % by Product line
SELECT product_line, SUM(total) AS revenue, ROUND(SUM(total)/(SELECT SUM(total)FROM sales)*100,2) as revenue_percent
FROM sales
group by product_line
ORDER BY revenue_percent DESC;

-- 6. Customer Behaviour Analysis
SELECT customer_type, 
COUNT(*) transactions,
SUM(total) AS revenue,
AVG(total) avg_spending
FROM sales
GROUP BY customer_type;

-- 7. Revenue by gender
SELECT gender, SUM(total) AS revenue
FROM sales
GROUP BY gender
ORDER BY revenue DESC;

-- 8. Payment Method Usage
SELECT payment, COUNT(*) AS usage_count
FROM sales
GROUP BY payment
ORDER BY usage_count DESC;

-- 9. AVG Rating Per Product type
SELECT product_line, AVG(rating) AS avg_rating
FROM sales
Group BY product_line
ORDER BY avg_rating DESC;

-- 10. High Value Transactions
SELECT *
FROM sales
WHERE total > (
SELECT AVG(total)
FROM sales
);

-- 11. Which branch performed best in terms of avg_rating and total revenue ?
SELECT 
branch, 
SUM(total) revenue,
AVG(rating) avg_rating
FROM sales
GROUP BY branch
ORDER BY revenue DESC;

-- 12. Which product is popular and ratings of that product ?
SELECT 
product_line,
SUM(quantity) units_sold,
AVG(rating) rating
FROM sales
GROUP BY product_line
ORDER BY units_sold DESC;