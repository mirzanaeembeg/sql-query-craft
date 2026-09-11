-- Problem Link: https://datalemur.com/questions/sql-avg-review-ratings

WITH mth_cte AS
  (SELECT 
    *,
    EXTRACT(MONTH FROM submit_date) AS mth
  FROM reviews)

SELECT
  mth,
  product_id AS product,
  ROUND(AVG(stars), 2) AS avg_stars
FROM mth_cte
GROUP BY 1, 2
ORDER BY 1, 2;