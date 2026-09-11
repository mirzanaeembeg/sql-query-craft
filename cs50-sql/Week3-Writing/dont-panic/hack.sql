-- 1
UPDATE "users" SET "password" = '982c0381c279d139fd221fce974916e7' WHERE "username" = 'admin';
-- SELECT password FROM users WHERE username = 'admin';

-- 2
DELETE FROM "user_logs" WHERE "new_password" = '982c0381c279d139fd221fce974916e7';

-- 3
-- SELECT password FROM users WHERE username = 'emily33';
-- UPDATE users SET password = '44bf025d27eea66336e5c1133c3827f7' WHERE username = 'admin';
INSERT INTO user_logs ("type", "old_username", "new_username", "old_password", "new_password")
VALUES ('update', 'admin', 'admin', '982c0381c279d139fd221fce974916e7', '44bf025d27eea66336e5c1133c3827f7')
