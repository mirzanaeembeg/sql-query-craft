-- Problem Link: https://datalemur.com/questions/user-retention

WITH date_rank AS
  (SELECT
    user_id,
    event_id,
    event_type,
    event_date,
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY event_date) AS date_rank
  FROM user_actions
  WHERE event_date >= '2022-06-01 00:00:00' 
    AND event_date < '2022-08-01 00:00:00')

SELECT
  7 AS month,
  COUNT(DISTINCT user_id) AS monthly_active_users
FROM date_rank
WHERE EXTRACT(MONTH FROM event_date) = 6;