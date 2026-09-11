-- Problem Link: https://datalemur.com/questions/second-day-confirmation

SELECT e.user_id 
FROM emails e
JOIN texts t
ON e.email_id = t.email_id
AND t.action_date = e.signup_date + INTERVAL '1 day';