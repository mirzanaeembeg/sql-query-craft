SELECT city, COUNT(*) AS num_school FROM schools
WHERE type = 'Public School'
GROUP BY city
HAVING num_school <= 3
ORDER BY num_school DESC, city ASC;
