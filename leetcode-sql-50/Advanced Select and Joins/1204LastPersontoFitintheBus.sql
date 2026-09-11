-- 1204. Last Person to Fit in the Bus
-- Write your PostgreSQL query statement below
WITH cumulative_sum_weight AS
    (SELECT
        turn,
        person_id,
        person_name,
        weight,
        SUM(weight) OVER(ORDER BY turn 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_weight
    FROM Queue),
weight_ranked AS
    (SELECT
        *,
        ROW_NUMBER() OVER(ORDER BY total_weight DESC) AS row_rank
    FROM cumulative_sum_weight
    WHERE total_weight <= 1000)
SELECT
    person_name
FROM weight_ranked
WHERE row_rank = 1;