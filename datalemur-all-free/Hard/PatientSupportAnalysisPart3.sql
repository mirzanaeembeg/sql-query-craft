-- Problem Link: https://datalemur.com/questions/patient-call-history

WITH nxt_date AS
  (SELECT 
    policy_holder_id,
    call_date,
    LEAD(call_date) OVER(PARTITION BY policy_holder_id ORDER BY call_date) AS nxt_date
  FROM callers)

SELECT
  COUNT(DISTINCT policy_holder_id) AS policy_holder_count
FROM nxt_date
WHERE nxt_date - call_date <= INTERVAL '7 DAYS';