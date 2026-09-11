SELECT t.name, ROUND(AVG(s.salary), 2) AS 'average salary'
FROM teams t
JOIN salaries s ON t.id = s.team_id
GROUP BY s.salary
ORDER BY s.salary
LIMIT 5;
