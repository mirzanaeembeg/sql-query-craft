-- Problem Link: https://datalemur.com/questions/uncategorized-calls-percentage

-- SELECT
--   COUNT(case_id) FILTER(WHERE call_category IN ('n/a', '') OR call_category IS NULL)
-- FROM callers;

SELECT
  ROUND(COUNT(case_id) FILTER(WHERE call_category IN ('n/a', '') OR call_category IS NULL)::DECIMAL/
  COUNT(case_id)*100.0, 1) AS uncategorised_call_pct
FROM callers;
