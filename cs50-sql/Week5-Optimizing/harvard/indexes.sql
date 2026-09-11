CREATE INDEX indx_enrollm_st_id
ON enrollments("student_id");

CREATE INDEX indx_enrollm_course_id
ON enrollments("course_id");

CREATE INDEX indx_courses_dept_sem
ON courses("department", "semester");

CREATE INDEX indx_courses_dept_num_sem
ON courses("department", "number", "semester");


CREATE INDEX indx_courses_title_sem
ON courses("title", "semester");

CREATE INDEX indx_satisfies_course_id
ON satisfies("course_id");

CREATE INDEX indx_satisfies_req_id
ON satisfies("requirement_id");

DROP INDEX indx_enrollm_st_id;
DROP INDEX indx_enrollm_course_id;
DROP INDEX indx_courses_dept_sem;
DROP INDEX indx_courses_dept_num_sem;
DROP INDEX indx_courses_title_sem;
DROP INDEX indx_satisfies_course_id;
DROP INDEX indx_satisfies_req_id;
