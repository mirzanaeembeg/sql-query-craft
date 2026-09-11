-- 550. Game Play Analysis IV
-- Write your PostgreSQL query statement below
--1.
-- WITH nxt_day AS
--     (SELECT
--         COUNT(*) AS count_nxt_day
--     FROM Activity a1
--     INNER JOIN Activity a2
--     ON a1.player_id = a2.player_id 
--         AND a1.event_date + INTERVAL '1 Day' = a2.event_date)
-- SELECT
--     ROUND((SELECT count_nxt_day FROM nxt_day)::DECIMAL/(SELECT COUNT(DISTINCT player_id)FROM Activity), 2) AS fraction;

--2.
-- WITH nxt_day_cte AS
-- (SELECT
--     *,
--     LEAD(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS nxt_day
-- FROM Activity)

-- SELECT 
--     ROUND(COUNT(player_id)*1.0/(SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction  
-- FROM nxt_day_cte
-- WHERE nxt_day = event_date + INTERVAL '1 day';

-- **Both 1 & 2 missed the first login constrain**

WITH first_logins AS (
  SELECT 
    player_id,
    MIN(event_date) AS first_login
  FROM Activity
  GROUP BY player_id
)

SELECT 
  ROUND(
    COUNT(a.player_id)::DECIMAL / (SELECT COUNT(*) FROM first_logins), 
    2
  ) AS fraction
FROM first_logins f
JOIN Activity a
  ON f.player_id = a.player_id
 AND a.event_date = f.first_login + INTERVAL '1 day';
