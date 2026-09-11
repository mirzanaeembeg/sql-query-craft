-- 1164. Product Price at a Given Date
-- Write your PostgreSQL query statement below
-- MAX(change_date) OVER (PARTITION BY product_id) evaluates the maximum date across all rows, including price changes that occurred after '2019-08-16'.
-- WITH last_price_date AS
--     (SELECT
--         *,
--         MAX(change_date) OVER(PARTITION BY product_id) AS last_change
--     FROM Products),

-- product_update_price AS
--     (SELECT
--         product_id,
--         new_price AS price
--     FROM last_price_date
--     WHERE last_change = change_date
--         AND change_date <= '2019-08-16'

--     UNION

--     SELECT
--         product_id,
--         10 AS price
--     FROM last_price_date
--     WHERE last_change > '2019-08-16')

-- SELECT
--     *
-- FROM product_update_price
-- ORDER BY product_id;
SELECT 
    DISTINCT p.product_id,
    COALESCE(lp.new_price, 10) AS price
FROM Products p
LEFT JOIN (
  SELECT 
    product_id,
    new_price,
    ROW_NUMBER() OVER (
      PARTITION BY product_id 
      ORDER BY change_date DESC
    ) AS rn
  FROM Products
  WHERE change_date <= '2019-08-16'
) lp 
  ON p.product_id = lp.product_id 
 AND lp.rn = 1;