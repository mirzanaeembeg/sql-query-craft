-- 585. Investments in 2016
-- Write your PostgreSQL query statement below
-- WITH same_tiv15_diff_location1 AS (
--     SELECT
--         i1.pid,
--         COUNT(i1.pid) AS i1_pid_cnt
--     FROM Insurance i1
--     INNER JOIN Insurance i2
--     ON i1.tiv_2015 = i2.tiv_2015
--         AND i1.lat != i2.lat 
--         AND i1.lon != i2.lon
--         AND i1.pid < i2.pid
--     GROUP BY i1.pid
-- ),
-- same_tiv15_diff_location2 AS (
--     SELECT
--         i2.pid,
--         COUNT(i2.pid) AS i2_pid_cnt
--     FROM Insurance i1
--     INNER JOIN Insurance i2
--     ON i1.tiv_2015 = i2.tiv_2015
--         AND i1.lat != i2.lat 
--         AND i1.lon != i2.lat
--         AND i1.pid < i2.pid
--     GROUP BY i2.pid
-- )

-- SELECT 
--     ROUND(SUM(tiv_2016)::DECIMAL, 2) AS tiv_2016 
-- FROM Insurance 
-- WHERE pid IN (
--     SELECT pid FROM same_tiv15_diff_location1 WHERE i1_pid_cnt >= 2
--     UNION
--     SELECT pid FROM same_tiv15_diff_location2 WHERE i2_pid_cnt >= 2
-- );

-- Actually I didn't understand this problem fully by it ambiguous problem statement
WITH policy_counts AS (
  SELECT
    tiv_2016,
    COUNT(*) OVER (PARTITION BY tiv_2015) AS tiv_2015_count,
    COUNT(*) OVER (PARTITION BY lat, lon) AS location_count
  FROM Insurance
)
SELECT 
  ROUND(SUM(tiv_2016)::DECIMAL, 2) AS tiv_2016
FROM policy_counts
WHERE tiv_2015_count > 1  
  AND location_count = 1; 