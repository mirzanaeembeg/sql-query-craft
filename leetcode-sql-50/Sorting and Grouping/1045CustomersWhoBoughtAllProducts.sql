-- 1045. Customers Who Bought All Products
-- Write your PostgreSQL query statement below
SELECT
    customer_id 
FROM (SELECT
    c.customer_id,
    COUNT(DISTINCT p.product_key) AS product_cnt
FROM Product p
LEFT JOIN Customer c
ON p.product_key = c.product_key
GROUP BY c.customer_id)
WHERE product_cnt = (SELECT COUNT(*) FROM Product);