-- Problem Link: https://datalemur.com/questions/non-profitable-drugs

SELECT manufacturer, COUNT(drug) AS drug_count, SUM(cogs-total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY 3 DESC;