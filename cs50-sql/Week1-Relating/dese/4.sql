SELECT city, COUNT(*) AS num_school FROM schools
WHERE type = 'Public School'
GROUP BY city
ORDER BY num_school DESC, city ASC
LIMIT 10;
