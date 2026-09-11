-- Problem Link: https://datalemur.com/questions/top-profitable-drugs

SELECT drug, (total_sales - cogs) AS total_profit 
FROM pharmacy_sales
ORDER BY 2 DESC
LIMIT 3;