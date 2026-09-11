SELECT s.name, e.per_pupil_expenditure, gr.graduated
FROM schools s
JOIN graduation_rates gr ON s.id = gr.school_id
JOIN districts d ON d.id = s.district_id
JOIN expenditures e ON d.id = e.district_id
ORDER BY e.per_pupil_expenditure DESC, s.name;
