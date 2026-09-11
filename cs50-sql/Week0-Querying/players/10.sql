SELECT first_name, last_name, height AS "Height(inch)"
FROM players
WHERE birth_year > 1990
ORDER BY height DESC;
