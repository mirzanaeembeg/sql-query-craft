-- Problem Link: https://datalemur.com/questions/sql-third-transaction

WITH rnk_trnx_cte AS
  (SELECT 
    user_id,
    spend,
    transaction_date,
    RANK() OVER(PARTITION BY user_id ORDER BY transaction_date) rank
  FROM transactions)

SELECT
  user_id,
    spend,
    transaction_date
FROM rnk_trnx_cte
WHERE rank = 3;
