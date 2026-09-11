-- 1341. Movie Rating
-- Write your PostgreSQL query statement below
WITH full_table AS
    (SELECT
        u.user_id,
        u.name,
        m.movie_id,
        m.title,
        mr.rating,
        mr.created_at     
    FROM Users u
    INNER JOIN MovieRating mr
    ON u.user_id = mr.user_id       
    INNER JOIN Movies m
    ON mr.movie_id = m.movie_id),

greatest_rated_user AS
    (SELECT
        name,
        COUNT(rating) rating_cnt,
        ROW_NUMBER() OVER(ORDER BY COUNT(rating) DESC, name ASC) AS row_number 
    FROM full_table
    GROUP BY name),

highest_avg_rated_movie AS
    (SELECT
        title,
        AVG(rating) avg_rating,
        ROW_NUMBER() OVER(ORDER BY AVG(rating) DESC, title ASC) AS row_number 
    FROM full_table
    WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY title
    )

SELECT
    name AS results      
FROM greatest_rated_user
WHERE row_number = 1

UNION ALL

SELECT
    title
FROM highest_avg_rated_movie
WHERE row_number = 1;       

