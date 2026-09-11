-- Problem Link: https://datalemur.com/questions/alibaba-compressed-mode

SELECT
  item_count AS mode
FROM (SELECT 
        item_count,
        order_occurrences,
        RANK() OVER(ORDER BY order_occurrences DESC) AS rank
      FROM items_per_order
      ORDER BY item_count) t
WHERE rank = 1;