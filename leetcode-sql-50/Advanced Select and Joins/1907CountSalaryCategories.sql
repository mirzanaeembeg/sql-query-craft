-- 1907. Count Salary Categories
-- Write your PostgreSQL query statement below
-- Drops Categories with 0 Accounts
-- SELECT
--     category,
--     COUNT(*) AS accounts_count 
-- FROM (SELECT
--     account_id,
--     income,
--     CASE
--         WHEN income < 20000 THEN 'Low Salary'
--         WHEN income > 50000 THEN 'High Salary'
--         ELSE 'Average Salary'
--         -- WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
--     END AS category
-- FROM Accounts)
-- GROUP BY category;
SELECT 
  'Low Salary' AS category,
  COUNT(account_id) AS accounts_count
FROM Accounts
WHERE income < 20000

UNION ALL

SELECT 
  'Average Salary' AS category,
  COUNT(account_id) AS accounts_count
FROM Accounts
WHERE income BETWEEN 20000 AND 50000

UNION ALL

SELECT 
  'High Salary' AS category,
  COUNT(account_id) AS accounts_count
FROM Accounts
WHERE income > 50000;