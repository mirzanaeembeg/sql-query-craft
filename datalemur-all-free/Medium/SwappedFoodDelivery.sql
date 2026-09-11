-- Problem Link: https://datalemur.com/questions/sql-swapped-food-delivery

WITH order_counts AS (
  SELECT order_id, COUNT(order_id) OVER() AS total_orders 
  FROM orders)

SELECT
  CASE
    WHEN orders.order_id % 2 != 0 AND orders.order_id != total_orders THEN orders.order_id + 1
    WHEN orders.order_id % 2 != 0 AND orders.order_id = total_orders THEN orders.order_id
    ELSE orders.order_id - 1
  END AS corrected_order_id,
  item
FROM orders
JOIN order_counts
ON orders.order_id = order_counts.order_id
ORDER BY corrected_order_id;