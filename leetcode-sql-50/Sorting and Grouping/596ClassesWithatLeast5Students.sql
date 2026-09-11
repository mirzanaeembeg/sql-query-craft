-- 596. Classes With at Least 5 Students
-- Write your PostgreSQL query statement below
SELECT
    class
FROM (SELECT
    class,    
    COUNT(student) AS student_cnt
FROM Courses 
GROUP BY class) t
WHERE student_cnt >= 5;