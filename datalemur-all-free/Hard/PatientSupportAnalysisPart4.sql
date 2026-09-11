-- Problem Link: https://datalemur.com/questions/long-calls-growth

WITH yr_mth_call AS
  (SELECT
    EXTRACT(YEAR FROM call_date) AS yr,
    EXTRACT(MONTH FROM call_date) AS mth,
    COUNT(EXTRACT(MONTH FROM call_date)) OVER(PARTITION BY EXTRACT(YEAR FROM call_date), EXTRACT(MONTH FROM call_date)) AS call_by_mth_count,
    call_duration_secs
  FROM callers
  WHERE call_duration_secs > 300),

call_count_by_mth AS
  (SELECT
    yr,
    mth,
    call_by_mth_count
  FROM yr_mth_call
  GROUP BY yr, mth, call_by_mth_count
  ORDER BY 1, 2)

SELECT
  yr,
  mth,
  ROUND((call_by_mth_count-LAG(call_by_mth_count) OVER())::DECIMAL/LAG(call_by_mth_count) OVER()*100.0, 1) AS long_calls_growth_pct
FROM call_count_by_mth;