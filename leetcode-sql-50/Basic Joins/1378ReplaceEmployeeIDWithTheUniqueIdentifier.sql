-- 1378. Replace Employee ID With The Unique Identifier
-- Write your PostgreSQL query statement below

SELECT u.unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI u
ON e.id = u.id;