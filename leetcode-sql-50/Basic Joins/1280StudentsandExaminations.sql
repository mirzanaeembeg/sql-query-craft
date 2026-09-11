-- 1280. Students and Examinations
-- Write your PostgreSQL query statement below
-- SELECT
--     s.student_id,
--     s.student_name,
--     sb.subject_name,
--     COALESCE(e.attended_exams, 0) AS attended_exams
-- FROM Subjects sb
-- LEFT JOIN (SELECT
--     student_id,
--     subject_name,
--     COUNT(subject_name) AS attended_exams 
-- FROM Examinations 
-- GROUP BY student_id, subject_name) e
-- ON sb.subject_name = e.subject_name
-- FULL JOIN Students s
-- ON e.student_id = s.student_id
-- ORDER BY e.student_id, s.student_name, attended_exams DESC;

SELECT
  s.student_id,
  s.student_name,
  sub.subject_name,
  COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
  ON s.student_id = e.student_id
 AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;