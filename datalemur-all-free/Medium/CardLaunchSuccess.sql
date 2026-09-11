-- Problem Link: https://datalemur.com/questions/card-launch-success

WITH rnk_card_cte AS
(SELECT card_name, issued_amount,
RANK() OVER(PARTITION BY card_name ORDER BY issue_year ASC, issue_month ASC) AS rnk_card
FROM monthly_cards_issued)

SELECT card_name, issued_amount
FROM rnk_card_cte
WHERE rnk_card = 1
ORDER BY issued_amount DESC;