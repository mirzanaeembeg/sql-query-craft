-- 185. Department Top Three Salaries
-- Write your PostgreSQL query statement below
WITH ranked_salary AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS dense_rank 
    FROM Department d
    INNER JOIN Employee e
    ON d.id = e.departmentId
)
SELECT
    Department,
    Employee,
    Salary
FROM ranked_salary
WHERE dense_rank <= 3;