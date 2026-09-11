SELECT d.name
FROM districts d
JOIN expenditures e ON e.district_id = d.id
WHERE e.pupils = (
    SELECT MIN(pupils) FROM expenditures
);
