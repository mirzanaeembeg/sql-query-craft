-- 1484. Group Sold Products By The Date
-- Write your PostgreSQL query statement below
-- SELECT
--     sell_date,
--     COUNT(DISTINCT product) AS num_sold 
-- FROM Activities
-- GROUP BY sell_date
-- ORDER BY sell_date 
SELECT
  sell_date,
  COUNT(DISTINCT product) AS num_sold,
  STRING_AGG(DISTINCT product, ',' ORDER BY product) AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;