-- Problem Link: https://datalemur.com/questions/time-spent-snaps

WITH open_spend AS
  (SELECT
    ab.age_bucket,
    SUM(a.time_spent) AS total_open_time
  FROM activities a
  JOIN age_breakdown ab
  ON a.user_id = ab.user_id
  AND a.activity_type = 'open'
  GROUP BY ab.age_bucket),

send_spend AS
  (SELECT
    ab.age_bucket,
    SUM(a.time_spent) AS total_send_time
  FROM activities a
  JOIN age_breakdown ab
  ON a.user_id = ab.user_id
  AND a.activity_type = 'send'
  GROUP BY ab.age_bucket)

SELECT 
  o.age_bucket,
  ROUND(s.total_send_time/(o.total_open_time + s.total_send_time)*100.0, 2) AS send_perc,
  ROUND(o.total_open_time/(o.total_open_time + s.total_send_time)*100.0, 2) AS open_perc
  FROM open_spend o
  JOIN send_spend s
ON o.age_bucket = s.age_bucket;