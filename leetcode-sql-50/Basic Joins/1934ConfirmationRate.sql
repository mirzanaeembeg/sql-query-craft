-- 1934. Confirmation Rate
-- Write your PostgreSQL query statement below
SELECT
    s.user_id,
    CASE 
        WHEN c.user_id IS NULL THEN 0
        ELSE ROUND(COUNT(c.action) FILTER(WHERE action = 'confirmed')*1.0/COUNT(c.action), 2)
    END confirmation_rate 
FROM Signups s
LEFT JOIN  Confirmations c
ON s.user_id = c.user_id 
GROUP BY s.user_id, c.user_id;