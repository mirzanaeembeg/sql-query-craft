-- Problem Link: https://datalemur.com/questions/signup-confirmation-rate

SELECT
  ROUND(COUNT(t.signup_action) FILTER(WHERE t.signup_action = 'Confirmed')::DECIMAL/
  COUNT(t.signup_action) FILTER(WHERE t.signup_action IN ('Confirmed', 'Not Confirmed')), 2) AS confirm_rate
FROM emails e
LEFT JOIN texts t
ON e.email_id = t.email_id;