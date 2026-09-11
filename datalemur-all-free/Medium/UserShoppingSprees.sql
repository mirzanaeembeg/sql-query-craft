-- Problem Link: https://datalemur.com/questions/amazon-shopping-spree

WITH spree_uid AS
  (SELECT
    user_id,
    amount,
    transaction_date,
    LEAD(transaction_date) OVER(PARTITION BY user_id ORDER BY transaction_date) nxt_1d,
    LEAD(transaction_date, 2) OVER(PARTITION BY user_id ORDER BY transaction_date) nxt_2d
  FROM transactions)
SELECT 
  user_id
FROM spree_uid
WHERE nxt_2d IS NOT NULL
ORDER BY user_id;

