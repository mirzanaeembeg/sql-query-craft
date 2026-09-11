-- 1731. The Number of Employees Which Report to Each Employee
-- Write your PostgreSQL query statement below
SELECT
    e2.employee_id,
    e2.name,
    COUNT(*) AS reports_count,
    ROUND(AVG(e1.age)) AS average_age 
FROM Employees e1
INNER JOIN Employees e2
ON e1.reports_to = e2.employee_id
GROUP BY e2.employee_id, e2.name
ORDER BY e2.employee_id;