-- Problem Link: https://datalemur.com/questions/odd-even-measurements

WITH CTE_Origin AS
(SELECT date_trunc('day', measurement_time) AS measurement_day, measurement_value,
ROW_NUMBER() OVER(PARTITION BY date_trunc('day', measurement_time) ORDER BY measurement_time ASC) AS Row_Num
FROM measurements),

CTE_Even AS
(SELECT measurement_day, SUM(measurement_value) AS even_sum
FROM CTE_Origin
WHERE Row_Num % 2 = 0
GROUP BY measurement_day
),

CTE_Odd AS
(SELECT measurement_day, SUM(measurement_value) AS odd_sum
FROM CTE_Origin
WHERE Row_Num % 2 != 0
GROUP BY measurement_day
)

SELECT e.measurement_day, o.odd_sum, e.even_sum 
FROM CTE_Even e
JOIN CTE_Odd o
ON e.measurement_day = o.measurement_day
ORDER BY o.measurement_day ASC;