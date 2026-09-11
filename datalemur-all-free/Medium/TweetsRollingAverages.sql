-- Problem Link: https://datalemur.com/questions/rolling-average-tweets

SELECT 
  user_id,
  tweet_date,
  ROUND(AVG(tweet_count) 
  OVER(PARTITION BY user_id ORDER BY tweet_date ROWS 2 PRECEDING)
  , 2) AS rolling_avg_3d
FROM tweets;