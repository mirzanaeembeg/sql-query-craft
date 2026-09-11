-- Problem Link: https://datalemur.com/questions/completed-trades

SELECT u.city, COUNT(t.status) AS total_orders
FROM trades t
JOIN users u
ON u.user_id = t.user_id
WHERE t.status = 'Completed'
GROUP BY t.status, u.city
ORDER BY 2 DESC
LIMIT 3;