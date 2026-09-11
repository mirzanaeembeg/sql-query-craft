-- 610. Triangle Judgement
-- Write your PostgreSQL query statement below
SELECT
    *,
    CASE
        WHEN x+y <= z OR x+z <= y OR y+z <= x THEN 'No'
        ELSE 'Yes'
    END AS triangle 
FROM Triangle;