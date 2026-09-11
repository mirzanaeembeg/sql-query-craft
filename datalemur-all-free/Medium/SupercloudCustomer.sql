-- Problem Link: https://datalemur.com/questions/supercloud-customer

WITH supercloud_cust AS
  (SELECT 
    customers.customer_id, 
    COUNT(DISTINCT products.product_category) AS product_cat_count
  FROM customer_contracts AS customers
  INNER JOIN products 
    ON customers.product_id = products.product_id
  GROUP BY customers.customer_id)
  
  SELECT customer_id
  FROM supercloud_cust
  WHERE product_cat_count = (SELECT MAX(product_cat_count) FROM supercloud_cust);