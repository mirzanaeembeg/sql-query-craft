-- Problem Link: https://datalemur.com/questions/sql-second-highest-salary

WITH rnk_salary_cte AS
  (SELECT 
    *,
    RANK() OVER(ORDER BY salary DESC) AS rank
  FROM employee)

SELECT
  salary AS second_highest_salary
FROM rnk_salary_cte
WHERE rank = 2;