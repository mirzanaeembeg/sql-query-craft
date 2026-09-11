-- 1633. Percentage of Users Attended a Contest
-- Write your PostgreSQL query statement below
WITH user_count AS
    (SELECT
        r.contest_id,
        COUNT(DISTINCT r.user_id) AS usr_cont 
    FROM Users u
    INNER JOIN Register r
    ON u.user_id = r.user_id     
    GROUP BY r.contest_id)

SELECT 
    contest_id,
    ROUND(usr_cont*1.0/(SELECT COUNT(*) FROM Users)*100, 2) AS percentage 
FROM user_count
ORDER BY percentage DESC, contest_id;