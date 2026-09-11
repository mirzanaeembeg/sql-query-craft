-- Problem Link: https://datalemur.com/questions/repeated-payments
-- This question was asked me in the virtual screen interview by Athelas Hiring Team

SELECT 
    COUNT(*) AS payment_count
FROM transactions t1
JOIN transactions t2
ON t1.transaction_id != t2.transaction_id -- I made mistake by using =
    AND t1.merchant_id = t2.merchant_id 
    AND t1.amount = t2.amount -- Completely missed this constrain
    AND t2.transaction_timestamp > t1.transaction_timestamp -- -- Also missed this constrain which was not come in my mind then
WHERE t2.transaction_timestamp - t1.transaction_timestamp <= INTERVAL '10 minutes'; -- Used a SQL server DATEDIFF function with - between parameters