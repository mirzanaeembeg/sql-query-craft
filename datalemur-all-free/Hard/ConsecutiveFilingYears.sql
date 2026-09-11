-- Problem Link: https://datalemur.com/questions/consecutive-filing-years

WITH rnk_lead_tax AS
  (SELECT
    *,
    LEAD(filing_date) OVER(PARTITION BY user_id) AS nxt_yr,
    LEAD(filing_date, 2) OVER(PARTITION BY user_id) AS nxt_2yr
  FROM filed_taxes
  WHERE product LIKE 'TurboTax%')

SELECT
  DISTINCT user_id
FROM rnk_lead_tax
WHERE EXTRACT(YEAR FROM nxt_2yr) - EXTRACT(YEAR FROM nxt_yr) 
  = EXTRACT(YEAR FROM nxt_yr) - EXTRACT(YEAR FROM filing_date)
ORDER BY user_id;