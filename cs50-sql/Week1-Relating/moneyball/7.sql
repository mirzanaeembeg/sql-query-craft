SELECT p.first_name, p.last_name
FROM salaries s
JOIN players p ON s.player_id = p.id
WHERE s.salary = (
    SELECT MAX(salary) FROM salaries
);
