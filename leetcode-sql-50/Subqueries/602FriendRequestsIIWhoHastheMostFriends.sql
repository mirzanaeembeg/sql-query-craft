-- 602. Friend Requests II: Who Has the Most Friends
-- Write your PostgreSQL query statement below
-- WITH acpt_cnt_cte AS
--     (SELECT
--         accepter_id,
--         COUNT(accepter_id) AS acpt_cnt
--     FROM RequestAccepted 
--     GROUP BY accepter_id),
-- rqst_cnt_cte AS
--     (SELECT
--         requester_id,
--         COUNT(requester_id) AS rqst_cnt
--     FROM RequestAccepted 
--     GROUP BY requester_id),
-- ranked_f AS
--     (SELECT
--         a.accepter_id AS id,
--         a.acpt_cnt + COALESCE(r.rqst_cnt, 0) AS num,
--         ROW_NUMBER() OVER(ORDER BY a.acpt_cnt + COALESCE(r.rqst_cnt, 0) DESC) AS row_rank
--     FROM acpt_cnt_cte a
--     LEFT JOIN rqst_cnt_cte r
--     ON a.accepter_id = r.requester_id)
--corrected:
-- ranked_f AS (
--     SELECT
--         COALESCE(a.accepter_id, r.requester_id) AS id,
--         COALESCE(a.acpt_cnt, 0) + COALESCE(r.rqst_cnt, 0) AS num,
--         ROW_NUMBER() OVER (
--             ORDER BY COALESCE(a.acpt_cnt, 0) + COALESCE(r.rqst_cnt, 0) DESC
--         ) AS row_rank
--     FROM acpt_cnt_cte a
--     FULL JOIN rqst_cnt_cte r
--       ON a.accepter_id = r.requester_id
-- )
-- SELECT
--     id,
--     num
-- FROM ranked_f
-- WHERE row_rank = 1;


WITH all_friends AS (
  SELECT requester_id AS id FROM RequestAccepted
  UNION ALL
  SELECT accepter_id AS id FROM RequestAccepted
)
SELECT 
  id,
  COUNT(*) AS num
FROM all_friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;