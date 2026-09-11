-- 1321. Restaurant Growth
-- Write your PostgreSQL query statement below
WITH daily_totals AS (
    SELECT
        visited_on,
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),
moving_sum_avg AS
    (SELECT
        visited_on,
        SUM(daily_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(AVG(daily_amount) 
            OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount
    FROM daily_totals
)
SELECT
    *
FROM moving_sum_avg
WHERE visited_on >= (SELECT MIN(visited_on) FROM Customer) + INTERVAL '6 days'
ORDER BY visited_on;