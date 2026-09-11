-- 619. Biggest Single Number
-- Write your PostgreSQL query statement below
SELECT
    MAX(num) AS num 
FROM (SELECT
    num,
    COUNT(num) AS num_cnt
FROM MyNumbers
GROUP BY num)
WHERE num_cnt = 1;