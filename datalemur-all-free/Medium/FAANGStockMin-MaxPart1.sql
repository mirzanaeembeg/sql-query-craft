-- Problem Link: https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

WITH high_open AS
  (SELECT
    ticker,
    open,
    TO_CHAR(date , 'Mon-YYYY') AS highest_mth,
    MAX(open) OVER(PARTITION BY ticker ORDER BY open DESC) AS highest_open,
    RANK() OVER(PARTITION BY ticker ORDER BY open DESC) AS rank
  FROM stock_prices),
low_open AS
  (SELECT
    ticker,
    open,
    TO_CHAR(date , 'Mon-YYYY') AS lowest_mth,
    MIN(open) OVER(PARTITION BY ticker ORDER BY open) AS lowest_open,
    RANK() OVER(PARTITION BY ticker ORDER BY open) AS rank
  FROM stock_prices),
final_open AS
  (SELECT
    h.ticker,
    h.highest_mth,
    h.highest_open,
    l.lowest_mth,
    l.lowest_open,
    ROW_NUMBER() OVER(PARTITION BY h.ticker ORDER BY h.ticker) AS new_rnk
  FROM high_open h
  JOIN low_open l
  ON h.ticker = l.ticker
  AND h.rank = l.rank)

SELECT
  ticker,
  highest_mth,
  highest_open,
  lowest_mth,
  lowest_open
FROM final_open
WHERE new_rnk = 1;

  
