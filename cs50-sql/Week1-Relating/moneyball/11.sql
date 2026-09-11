SELECT p.first_name,
       p.last_name,
       (s.salary * 1.0 / pr.H) AS "dollars per hit"
FROM players p
JOIN salaries s ON p.id = s.player_id
JOIN performances pr ON p.id = pr.player_id
WHERE s.year = 2001
  AND pr.year = 2001
  AND pr.H > 0
ORDER BY "dollars per hit" ASC, p.first_name ASC, p.last_name ASC
LIMIT 10;
