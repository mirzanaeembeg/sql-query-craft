-- 1141. User Activity for the Past 30 Days I
-- Write your PostgreSQL query statement below
SELECT
    activity_date AS day,        
    COUNT(DISTINCT user_id) AS active_users 
FROM Activity
WHERE activity_date BETWEEN  '2019-07-27'::DATE - INTERVAL '29 Days' AND '2019-07-27'
GROUP BY activity_date;