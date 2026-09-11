-- 1667. Fix Names in a Table
-- Write your PostgreSQL query statement below
SELECT
    user_id,
    UPPER(LEFT(name, 1)) || LOWER(SUBSTRING(name FROM 2)) AS name  
FROM Users 
ORDER BY user_id;