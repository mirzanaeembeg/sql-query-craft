-- 570. Managers with at Least 5 Direct Reports
-- Write your PostgreSQL query statement below
SELECT 
    name
FROM (SELECT
    e2.name,
    COUNT(e2.id) AS direct_reports
FROM Employee e1
INNER JOIN Employee e2
ON e1.managerId = e2.id
GROUP BY e2.name, e2.id) t
WHERE direct_reports >= 5;