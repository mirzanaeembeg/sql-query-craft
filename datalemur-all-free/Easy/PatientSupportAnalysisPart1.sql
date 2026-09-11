-- Problem Link: https://datalemur.com/questions/frequent-callers

WITH  no_policy_holder AS
  (SELECT 
    policy_holder_id,
    COUNT(case_id) AS call_count
  FROM callers
  GROUP BY policy_holder_id
  ORDER BY 2 DESC)

SELECT
  COUNT(policy_holder_id) FILTER(WHERE call_count >= 3) AS policy_holder_count
FROM no_policy_holder;