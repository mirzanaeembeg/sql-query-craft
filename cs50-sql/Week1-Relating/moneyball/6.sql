SELECT t.name, pr.H AS 'total hits' FROM teams t
JOIN performances pr ON pr.team_id = t.id
WHERE pr.year = 2001
ORDER BY pr.H DESC
LIMIT 5;
