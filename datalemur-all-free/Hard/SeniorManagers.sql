-- Problem Link: https://datalemur.com/questions/senior-managers-reportees

SELECT
  e2.manager_name,
  COUNT(DISTINCT e2.emp_id) AS direct_reportees
FROM employees e1
INNER JOIN employees e2
ON e1.manager_id = e2.emp_id
INNER JOIN employees e3
ON e2.manager_id = e3.emp_id
GROUP BY e2.manager_name
ORDER BY direct_reportees DESC;