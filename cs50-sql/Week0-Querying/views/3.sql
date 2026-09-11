SELECT COUNT(*) AS prints_by_Hokusai_include_Fuji
FROM views
WHERE artist = 'Hokusai' AND english_title LIKE '%Fuji%';
