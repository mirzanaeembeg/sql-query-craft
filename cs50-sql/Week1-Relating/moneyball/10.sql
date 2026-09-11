SELECT p.first_name, p.last_name, s.salary, pr.year, pr.HR FROM salaries s
JOIN players p ON s.player_id = p.id
JOIN performances pr ON pr.player_id = p.id
WHERE s.year = pr.year
ORDER BY p.id, pr.year DESC, pr.HR DESC, s.salary DESC;
