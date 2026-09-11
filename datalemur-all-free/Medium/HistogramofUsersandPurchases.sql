-- Problem Link: https://datalemur.com/questions/histogram-users-purchases

WITH rnk_cte AS
(SELECT transaction_date, user_id, product_id, 
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS rank
FROM user_transactions)

SELECT transaction_date, user_id, COUNT(product_id) AS purchase_count
FROM rnk_cte
WHERE rank = 1
GROUP BY transaction_date, user_id
ORDER BY transaction_date;
