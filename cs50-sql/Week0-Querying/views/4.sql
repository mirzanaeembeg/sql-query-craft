SELECT COUNT(*) AS prints_by_Hiroshige
FROM views
WHERE artist = 'Hiroshige' AND english_title LIKE '%Eastern Capital%';
