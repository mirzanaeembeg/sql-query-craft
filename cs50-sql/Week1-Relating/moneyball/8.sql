SELECT s.salary FROM salaries s
JOIN players p ON s.player_id = p.id
JOIN performances pr ON pr.player_id = p.id
WHERE s.year = 2001
AND pr.HR = (
    SELECT MAX(HR) FROM performances
);
