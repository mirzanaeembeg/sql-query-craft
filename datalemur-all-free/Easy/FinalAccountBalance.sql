-- Problem Link: https://datalemur.com/questions/final-account-balance

SELECT 
  account_id,
  SUM(amount) FILTER(WHERE transaction_type = 'Deposit') -
  SUM(amount) FILTER(WHERE transaction_type = 'Withdrawal') AS final_balance
FROM transactions
GROUP BY account_id;