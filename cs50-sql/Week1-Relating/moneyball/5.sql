SELECT  DISTINCT t.name FROM teams t
JOIN performances pr ON pr.team_id = t.id
JOIN players pl ON pl.id = pr.player_id
WHERE pl.first_name = 'Satchel'
AND pl.last_name = 'Paige';
