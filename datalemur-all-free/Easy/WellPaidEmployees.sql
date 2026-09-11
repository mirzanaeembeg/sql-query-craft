-- Problem Link: https://datalemur.com/questions/sql-well-paid-employees

SELECT e1.employee_id, e1.name
FROM employee e1
JOIN employee e2
ON e1.manager_id = e2.employee_id
AND e1.salary > e2.salary;