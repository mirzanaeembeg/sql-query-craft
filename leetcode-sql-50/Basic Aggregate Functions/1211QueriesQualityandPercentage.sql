-- 1211. Queries Quality and Percentage
-- Write your PostgreSQL query statement below
SELECT
    query_name,
    ROUND(AVG(rating*1.0/position), 2) AS quality,
    ROUND(COUNT(rating) FILTER(WHERE rating < 3)*1.0/COUNT(rating)*100, 2) AS poor_query_percentage 
FROM Queries 
GROUP BY query_name;