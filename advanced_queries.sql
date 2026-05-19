-- Superstore Advanced SQL Analysis
-- Author: papitheanalyst
-- Tool: SQLite / DB Browser

-- Advanced Query 1: State Performance Rating
WITH state_performance AS (
    SELECT 
    State,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin
    FROM Superstore
    GROUP BY State
)
SELECT State, total_sales, total_profit, profit_margin,
CASE
    WHEN profit_margin > 15 THEN 'Excellent'
    WHEN profit_margin > 10 THEN 'Good'
    WHEN profit_margin > 0 THEN 'Poor'
    ELSE 'Loss Making'
END AS performance
FROM state_performance
ORDER BY profit_margin DESC;

-- Advanced Query 2: Product Profitability Segmentation
WITH product_performance AS (
    SELECT
    [Product Name],
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin
    FROM Superstore
    GROUP BY [Product Name], Category
)
SELECT Category,
CASE
    WHEN profit_margin > 20 THEN 'High Margin'
    WHEN profit_margin > 0 THEN 'Low Margin'
    ELSE 'Loss Making'
END AS product_segment,
COUNT(*) AS total_products,
ROUND(AVG(total_sales), 2) AS avg_sales
FROM product_performance
GROUP BY Category, product_segment
ORDER BY Category, avg_sales DESC;

-- Advanced Query 3: Customer Retention Analysis
WITH customer_orders AS (
    SELECT
    [Customer Name],
    COUNT(DISTINCT [Order ID]) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_spent,
    ROUND(AVG(Sales), 2) AS avg_order_value
    FROM Superstore
    GROUP BY [Customer Name]
)
SELECT
CASE
    WHEN total_orders >= 10 THEN 'Loyal Customer'
    WHEN total_orders >= 5 THEN 'Returning Customer'
    ELSE 'One Time Customer'
END AS customer_type,
COUNT(*) AS total_customers,
ROUND(AVG(total_spent), 2) AS avg_lifetime_value,
ROUND(AVG(avg_order_value), 2) AS avg_order_value
FROM customer_orders
GROUP BY customer_type
ORDER BY avg_lifetime_value DESC;
