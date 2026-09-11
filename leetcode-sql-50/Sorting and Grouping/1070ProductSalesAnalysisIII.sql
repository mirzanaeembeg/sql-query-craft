-- 1070. Product Sales Analysis III
-- Write your PostgreSQL query statement below
WITH first_yr_cte AS
    (SELECT 
        product_id,
        MIN(year) AS first_year 
    FROM Sales 
    GROUP BY product_id)
SELECT
    f.product_id,
    f.first_year,
    s.quantity,
    s.price 
FROM first_yr_cte f
INNER JOIN Sales s
ON f.product_id = s.product_id
    AND f.first_year = s.year;
