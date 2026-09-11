-- Problem Link: https://datalemur.com/questions/updated-status

WITH Origin_cte AS
  (SELECT 
    COALESCE(a.user_id, dp.user_id) AS user_id, 
    a.status AS status, 
    dp.paid AS paid
  FROM advertiser a
  FULL JOIN daily_pay dp
  ON a.user_id = dp.user_id)
SELECT user_id,
  CASE 
    WHEN paid IS NULL THEN 'CHURN'
    WHEN status IS NULL THEN 'NEW'
    WHEN status = 'CHURN' THEN 'RESURRECT'
    WHEN status IN ('NEW', 'EXISTING', 'RESURRECT') THEN 'EXISTING'
  END AS new_status
  FROM Origin_cte
  ORDER BY user_id;