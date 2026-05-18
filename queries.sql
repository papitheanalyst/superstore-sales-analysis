-- Superstore Sales Analysis
-- Author: papitheanalyst
-- Tool: SQLite / DB Browser

-- Q1: Total Sales by Region
SELECT Region, ROUND(SUM(Sales), 2) AS total_sales
FROM Superstore
GROUP BY Region
ORDER BY total_sales DESC;

-- Q2: Top 5 Customers by Revenue
SELECT [Customer Name], ROUND(SUM(Sales), 2) AS total_spent
FROM Superstore
GROUP BY [Customer Name]
ORDER BY total_spent DESC
LIMIT 5;

-- Q3: Most Profitable Category
SELECT Category, ROUND(SUM(Profit), 2) AS total_profit
FROM Superstore
GROUP BY Category
ORDER BY total_profit DESC;

-- Q4: Bottom 5 Sub-Categories by Profit
SELECT [Sub-Category], ROUND(SUM(Profit), 2) AS total_profit
FROM Superstore
GROUP BY [Sub-Category]
ORDER BY total_profit ASC
LIMIT 5;

-- Q5: Sales and Profit by Ship Mode
SELECT [Ship Mode], COUNT(*) AS total_orders,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM Superstore
GROUP BY [Ship Mode]
ORDER BY total_sales DESC;

-- Q6: Loss Making States
SELECT State, ROUND(SUM(Profit), 2) AS total_profit
FROM Superstore
GROUP BY State
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;

-- Q7: Yearly Sales Trend
SELECT SUBSTR([Order Date], -4) AS year,
ROUND(SUM(Sales), 2) AS yearly_sales
FROM Superstore
GROUP BY year
ORDER BY year ASC;

-- Q8: Average Discount by Category
SELECT Category, ROUND(AVG(Discount), 2) AS avg_discount
FROM Superstore
GROUP BY Category
ORDER BY avg_discount DESC;

-- Q9: Top 10 Most Profitable Products
SELECT [Product Name], ROUND(SUM(Profit), 2) AS total_profit
FROM Superstore
GROUP BY [Product Name]
ORDER BY total_profit DESC
LIMIT 10;

-- Q10: Profit Margin by Region
SELECT Region,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit,
ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM Superstore
GROUP BY Region
ORDER BY profit_margin_pct DESC;
