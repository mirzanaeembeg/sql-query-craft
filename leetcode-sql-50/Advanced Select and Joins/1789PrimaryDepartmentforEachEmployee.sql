-- 1789. Primary Department for Each Employee
-- Write your PostgreSQL query statement below
-- 1. Fails When 'Y' is the Last Row or When There Are >3 Departments
-- SELECT
--     employee_id,
--     department_id 
-- FROM(SELECT
--     *,
--     LAG(primary_flag) OVER(PARTITION BY employee_id ORDER BY department_id) AS prv_flag,
--     LEAD(primary_flag) OVER(PARTITION BY employee_id ORDER BY department_id) AS nxt_flag
-- FROM Employee)
-- WHERE primary_flag = 'N' AND prv_flag IS NULL AND nxt_flag IS NULL 
--     OR (primary_flag = 'Y' AND prv_flag IS NULL AND nxt_flag = 'N')
--     OR (primary_flag = 'Y' AND prv_flag = 'N' AND nxt_flag = 'N');

WITH dept_counts AS (
  SELECT
    employee_id,
    department_id,
    primary_flag,
    COUNT(*) OVER (PARTITION BY employee_id) AS dept_count
  FROM Employee
)
SELECT
  employee_id,
  department_id
FROM dept_counts
WHERE primary_flag = 'Y' 
   OR dept_count = 1;