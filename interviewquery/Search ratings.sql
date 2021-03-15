-- Search ratings
-- https://www.interviewquery.com/questions/search-ratings

-- Create SQL table in SQLFiddle
CREATE TABLE search_results (
    result_id       integer NOT NULL,
    query_d          varchar(10),
    position        integer NOT NULL,
    rating   integer NOT NULL
);

INSERT INTO search_results 
 (result_id, query_d, position, rating) VALUES
    (1000,'dog', 1,2),
  (998,'dog', 2,4),
  (342,'dog', 3,1),
  (123,'cat', 1,4),
  (435,'cat', 2,2),
  (545,'cat', 3,1);


-- Approach:
-- Group by query
-- Average_rating
-- Running average with order by to figure out 

-- End table: query | avg_rating
-- 

-- Subquery
-- 1. AVG OVER() ORDER BY Rating, partition by query
-- 2. 
-- Parent query
-- 3. AVG over all ratings, grouped by query
-- 4. ORDER by overall avg

-- Answer:

SELECT query_d, ROUND(avg_rating,2) AS avg_rating
FROM (
    SELECT query_d, rating, position,
        AVG(rating) OVER(PARTITION BY query_d ORDER BY position, rating DESC) AS run_avg,
        AVG(rating) OVER(PARTITION BY query_d) AS avg_rating
    FROM search_results
    ) AS t
WHERE position = 1
ORDER BY run_avg DESC

-- Notes:
--> Have to be able to filter only one row per query grouping since using window function
--> Can't do round with window function so had to do it in the parent query