SELECT pr.year, pr.HR
FROM players pl
JOIN performances pr ON pr.player_id = pl.id
WHERE pl.first_name = 'Ken'
AND pl.last_name = 'Griffey'
AND pl.birth_year = 1969
ORDER BY pr.year DESC;
