-- 1517. Find Users With Valid E-Mails
-- Write your PostgreSQL query statement below
SELECT
  user_id,
  name,
  mail
FROM Users
WHERE mail ~ '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\.com$';