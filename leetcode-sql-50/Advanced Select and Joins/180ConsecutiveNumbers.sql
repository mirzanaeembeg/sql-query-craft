-- 180. Consecutive Numbers
-- Write your PostgreSQL query statement below
SELECT
    DISTINCT l1.num AS ConsecutiveNums -- I called here COUNT(*) first, that's why Case 1 passed but failed in others. Then I tried by Window Function and CTE though I missed to SELECT num instead of COUNT(*) there!
FROM Logs l1
INNER JOIN Logs l2
ON l1.num = l2.num
    AND l2.id = l1.id + 1
INNER JOIN Logs l3
ON l2.num = l3.num
    AND l3.id = l2.id + 1;

-- WITH three_con_num AS
--     (SELECT
--         *,
--         LEAD(num) OVER() AS nxt_1_num,
--         LEAD(num, 2) OVER() AS nxt_2_num
--     FROM Logs)
    
-- SELECT
--     DISTINCT num AS ConsecutiveNums 
-- FROM three_con_num
-- WHERE num = nxt_1_num 
--     AND nxt_1_num = nxt_2_num;
