SELECT d.type, e.pupils, se.proficient
FROM districts d
JOIN staff_evaluations se ON d.id = se.district_id
JOIN expenditures e ON d.id = e.district_id
WHERE e.per_pupil_expenditure < (
    SELECT MAX(per_pupil_expenditure) FROM expenditures
)
AND se.proficient < (
    SELECT MAX(proficient) FROM staff_evaluations
)
ORDER BY se.proficient DESC, e.pupils;
