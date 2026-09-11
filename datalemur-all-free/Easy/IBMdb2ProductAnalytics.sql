-- Problem Link: https://datalemur.com/questions/sql-ibm-db2-product-analytics

WITH end_time_cte AS
  (SELECT 
    e.employee_id, -- my mistake: q.employee_id
    q.query_id,
    q.query_starttime,
    -- q.query_starttime::TIMESTAMP + (q.execution_time * INTERVAL '1 second') AS end_time,
    e.full_name,
    e.gender
  FROM employees e
  LEFT JOIN queries q
  ON e.employee_id = q.employee_id
  AND q.query_starttime >= '2023-07-01T00:00:00Z' -- my mistake: doesn't add these and conditions
  AND q.query_starttime < '2023-10-01T00:00:00Z'),

unique_query AS
  (SELECT
    employee_id,
    COALESCE(COUNT(DISTINCT query_id), 0) AS unique_queries -- my mistake: also didn't come in my mind about COALESCE
  FROM end_time_cte ecte
  -- WHERE -- my mistake: instead of AND conditions I thought like this
  --   query_starttime >= '2023-07-01T00:00:00Z'
  --   AND
  --   end_time <= '2023-10-01T00:00:00Z'
  GROUP BY employee_id)

SELECT
    unique_queries,
    COUNT(employee_id) AS employee_count
FROM unique_query
GROUP BY 1
ORDER BY 1;
