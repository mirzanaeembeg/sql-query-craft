-- 1174. Immediate Food Delivery II
-- Write your PostgreSQL query statement below
WITH rnk_order AS
    (SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS rank
    FROM Delivery)

SELECT
    ROUND(COUNT(delivery_id) FILTER(WHERE order_date = customer_pref_delivery_date AND rank = 1)::DECIMAL/COUNT(DISTINCT customer_id )*100, 2) AS immediate_percentage 
FROM rnk_order;
