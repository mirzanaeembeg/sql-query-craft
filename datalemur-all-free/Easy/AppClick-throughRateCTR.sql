-- Problem Link: https://datalemur.com/questions/click-through-rate

SELECT 
  app_id,
  ROUND(COUNT(event_type) FILTER(WHERE event_type = 'click')*100.0 /
  COUNT(event_type) FILTER(WHERE event_type = 'impression'), 2) AS ctr
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = '2022'
GROUP BY app_id;