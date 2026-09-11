-- Problem Link: https://datalemur.com/questions/spotify-streaming-history

WITH song_hist AS (
  SELECT user_id, song_id, song_plays
  FROM songs_history
),
song_week AS (
  SELECT 
    user_id, 
    song_id, 
    COUNT(song_id) AS song_plays
  FROM songs_weekly
  WHERE listen_time <= '08/04/2022 23:59:59'
  GROUP BY user_id, song_id
)
-- SELECT
--   CASE 
--     WHEN w.user_id IS NULL THEN h.user_id h.song_id h.song_plays
--     WHEN h.user_id IS NULL THEN w.user_id w.song_id w.song_plays
--     ELSE h.user_id h.song_id h.song_plays + w.song_plays AS song_plays
--   END
-- FROM song_week w
-- FULL JOIN song_hist h
-- ON w.user_id = h.user_id
-- AND w.song_id = h.song_id;

SELECT
  COALESCE(h.user_id, w.user_id) AS user_id,
  COALESCE(h.song_id, w.song_id) AS song_id,
  COALESCE(h.song_plays, 0) + COALESCE(w.song_plays, 0) AS song_plays
FROM song_hist h
FULL JOIN song_week w
  ON h.user_id = w.user_id 
 AND h.song_id = w.song_id
ORDER BY song_plays DESC;