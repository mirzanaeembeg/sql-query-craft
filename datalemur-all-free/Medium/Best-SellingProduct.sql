-- Problem Link: https://datalemur.com/questions/best-selling-products

WITH ranked_product AS
  (SELECT
    p.category_name,
    p.product_name,
    ROW_NUMBER() OVER(PARTITION BY p.category_name ORDER BY ps.sales_quantity DESC, ps.rating DESC) AS rank
  FROM products p
  JOIN product_sales ps
  ON p.product_id = ps.product_id)

SELECT 
  category_name,
  product_name
FROM ranked_product
WHERE rank = 1;