-- Problem Link: https://datalemur.com/questions/reactivated-users

SELECT
  mth,
  COUNT(user_id) AS reactivated_users
FROM (SELECT
  user_id,
  EXTRACT(MONTH FROM login_date) AS mth,
  LAG(EXTRACT(MONTH FROM login_date)) OVER(PARTITION BY user_id ORDER BY login_date) AS prv_mth,
  login_date
FROM user_logins) t
WHERE prv_mth IS NULL OR mth - prv_mth >= 2
GROUP BY mth
ORDER BY 1;


