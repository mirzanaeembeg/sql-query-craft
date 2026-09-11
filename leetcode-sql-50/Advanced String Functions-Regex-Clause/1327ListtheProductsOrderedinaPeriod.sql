-- 1327. List the Products Ordered in a Period
-- Write your PostgreSQL query statement below
WITH feb20_total_unit AS
    (SELECT
        product_id,
        SUM(unit) AS total_unit
    FROM Orders 
    WHERE order_date BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY product_id
)
SELECT
    p.product_name,
    t.total_unit AS unit
FROM feb20_total_unit t
INNER JOIN Products p
ON t.product_id = p.product_id
    AND t.total_unit >= 100;
 