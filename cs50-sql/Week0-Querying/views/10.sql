SELECT COUNT(*) AS "prints by Hokusai"
FROM views
WHERE english_title LIKE '%Fuji%'
ORDER BY english_title DESC;
