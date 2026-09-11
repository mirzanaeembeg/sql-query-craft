SELECT p.first_name, p.last_name, s.salary
FROM salaries s
JOIN players p ON s.player_id = p.id
ORDER BY s.salary ASC, p.first_name, p.last_name, p.id
LIMIT 50;
