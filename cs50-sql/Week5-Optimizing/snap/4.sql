SELECT username
FROM users
WHERE id = (
    SELECT to_user_id
    FROM messages
    GROUP BY to_user_id
    ORDER BY count(*) DESC
    LIMIT 1
);
