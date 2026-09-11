-- 197. Rising Temperature
-- Write your PostgreSQL query statement below
SELECT w2.id AS Id
FROM Weather w1
JOIN Weather w2
ON w2.recordDate = w1.recordDate + INTERVAL '1 day'
WHERE w2.temperature > w1.temperature;