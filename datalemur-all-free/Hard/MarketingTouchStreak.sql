-- Problem Link: https://datalemur.com/questions/marketing-touch-streak

WITH wk_number AS
  (SELECT
    mt.contact_id,
    mt.event_type,
    mt.event_date,
    cc.email,
    DATE_TRUNC('week', mt.event_date) AS cur_wk,
    LEAD(DATE_TRUNC('week', mt.event_date)) OVER(PARTITION BY mt.contact_id ORDER BY mt.event_date) AS nxt_wk,
    LEAD(DATE_TRUNC('week', mt.event_date), 2) OVER(PARTITION BY mt.contact_id ORDER BY mt.event_date) AS nxt_2wk
  FROM marketing_touches mt
  INNER JOIN crm_contacts cc
  ON mt.contact_id = cc.contact_id),

satisfied_wk AS
  (SELECT
    contact_id,
    email
  FROM wk_number
  WHERE nxt_2wk = nxt_wk + INTERVAL '1 WEEK'
  AND nxt_2wk = cur_wk + INTERVAL '2 WEEK')

SELECT
  email
FROM satisfied_wk sw
INNER JOIN marketing_touches mt
ON sw.contact_id = mt.contact_id
WHERE mt.event_type = 'trial_request';