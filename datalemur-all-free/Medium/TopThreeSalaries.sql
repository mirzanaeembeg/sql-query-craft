-- Problem Link: https://datalemur.com/questions/sql-top-three-salaries

WITH ranked_salary AS
  (SELECT 
    d.department_name,
    e.name,
    e.salary,
    DENSE_RANK() OVER(PARTITION BY d.department_name ORDER BY d.department_name ASC, e.salary DESC) AS rank
  FROM employee e
  JOIN department d
  ON e.department_id = d.department_id)

SELECT 
  department_name,
  name,
  salary
FROM ranked_salary
WHERE rank <= 3
ORDER BY department_name ASC, salary DESC, name ASC;