-- Problem Link: https://datalemur.com/questions/total-utilization-time

WITH running_sessions AS (
  SELECT
    server_id,
    session_status,
    status_time AS start_time,
    LEAD(status_time) OVER (
      PARTITION BY server_id 
      ORDER BY status_time
    ) AS stop_time
  FROM server_utilization
)
SELECT
  FLOOR(
    SUM(EXTRACT(EPOCH FROM (stop_time - start_time))) / 86400
  ) AS total_uptime_days
FROM running_sessions
WHERE session_status = 'start';