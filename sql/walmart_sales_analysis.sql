-- Walmart Sales Analytics: SQL-style analysis queries
-- These queries describe the business questions used in the analysis.

-- 1. Total weekly sales by store
SELECT
    Store,
    ROUND(SUM(Weekly_Sales), 2) AS total_sales
FROM walmart_sales
GROUP BY Store
ORDER BY total_sales DESC;

-- 2. Yearly sales trend
SELECT
    EXTRACT(YEAR FROM Date) AS sales_year,
    ROUND(SUM(Weekly_Sales), 2) AS total_sales
FROM walmart_sales
GROUP BY EXTRACT(YEAR FROM Date)
ORDER BY sales_year;

-- 3. Holiday vs non-holiday sales comparison
SELECT
    CASE WHEN Holiday_Flag = 1 THEN 'Holiday week' ELSE 'Non-holiday week' END AS week_type,
    COUNT(*) AS week_count,
    ROUND(AVG(Weekly_Sales), 2) AS average_weekly_sales,
    ROUND(SUM(Weekly_Sales), 2) AS total_sales
FROM walmart_sales
GROUP BY Holiday_Flag;

-- 4. Store-level sales and economic context
SELECT
    Store,
    ROUND(AVG(Weekly_Sales), 2) AS average_weekly_sales,
    ROUND(AVG(Temperature), 2) AS average_temperature,
    ROUND(AVG(Fuel_Price), 2) AS average_fuel_price,
    ROUND(AVG(CPI), 2) AS average_cpi,
    ROUND(AVG(Unemployment), 2) AS average_unemployment
FROM walmart_sales
GROUP BY Store
ORDER BY average_weekly_sales DESC;
