-- Employee Salaries
-- https://www.interviewquery.com/questions/employee-salaries

-- Create SQL table in SQLFiddle
CREATE TABLE employees (
    id       integer NOT NULL,
    first_name          varchar(20),
    last_name          varchar(20),
    salary              integer NOT NULL,
    department_id       integer NOT NULL
    );

CREATE TABLE departments (
    id       integer NOT NULL,
    "name"          varchar(20)
    );

INSERT INTO employees 
    (id, first_name, last_name, salary, department_id) 
 VALUES
    (1,'Paul','Sims',40000,1),
    (2,'Pierre','Winter',60000,1),
    (3,'Jenny','Lin',80000,2),
    (4,'Sean','Nguyen',80000,2),
    (5,'Jane','Keung',90000,3),
    (6,'Jared','Leto',100000,3);

INSERT INTO departments 
    (id, "name") 
 VALUES
    (1,'biology'),
    (2,'math'),
    (3,'engineering');


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
--> 


