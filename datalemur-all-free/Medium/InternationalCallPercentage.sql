-- Problem Link: https://datalemur.com/questions/international-call-percentage

WITH rcv_country AS
  (SELECT
    c.caller_id,
    c.receiver_id,
    i.country_id AS rcv_country
  FROM phone_calls c
  JOIN phone_info i
  ON c.receiver_id = i.caller_id),
clr_country AS  
  (SELECT
    c.caller_id,
    c.receiver_id,
    i.country_id AS clr_country
  FROM phone_calls c
  JOIN phone_info i
  ON c.caller_id = i.caller_id)

SELECT
  ROUND(COUNT(CASE WHEN r.rcv_country <> cl.clr_country THEN 1 END)::DECIMAL/(SELECT
  COUNT(caller_id)
FROM phone_calls)*100.0, 1) AS international_calls_pct
FROM rcv_country r
JOIN clr_country cl
ON r.caller_id = cl.caller_id
AND r.receiver_id = cl.receiver_id;