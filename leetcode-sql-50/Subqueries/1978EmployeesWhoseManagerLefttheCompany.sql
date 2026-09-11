-- 1978. Employees Whose Manager Left the Company
-- Write your PostgreSQL query statement below
SELECT
    e.employee_id 
FROM (SELECT
        employee_id,
        manager_id 
    FROM Employees 
    WHERE manager_id NOT IN (SELECT employee_id FROM Employees)) t
INNER JOIN Employees e
ON e.employee_id = t.employee_id
AND e.salary < 30000
ORDER BY e.employee_id;


