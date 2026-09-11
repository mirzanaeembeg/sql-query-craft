-- 626. Exchange Seats
-- Write your PostgreSQL query statement below
SELECT
  CASE
    WHEN id % 2 != 0 AND id = (SELECT COUNT(*) FROM Seat) THEN id
    WHEN id % 2 != 0 THEN id + 1
    ELSE id - 1
  END AS id,
  student
FROM Seat
ORDER BY id;

-- SELECT
--   id,
--   CASE
--     WHEN id % 2 != 0 THEN COALESCE(LEAD(student) OVER (ORDER BY id), student)
--     ELSE LAG(student) OVER (ORDER BY id)
--   END AS student
-- FROM Seat
-- ORDER BY id;