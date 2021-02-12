-- SQLzoo: More JOIN operations
-- Link: https://sqlzoo.net/wiki/More_JOIN_operations
-- Tables: movie, actor, casting


-- 13. Actors with 15 leading roles
-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

-- Approach:
-- 1. Get the number of starring roles per actor
-- 2. Filter by >= 15 and ord 1 for starring
-- 3. Join subquery of casting with actor tables on actor id to get actor name 
-- 4. Order by actor name 

-- Answer: 

SELECT actor.name
FROM (
  SELECT actorid, COUNT(actorid) AS cts
  FROM casting 
  WHERE casting.ord = 1
  GROUP BY actorid
  HAVING COUNT(actorid) >=15
  ) AS tab JOIN actor ON tab.actorid=actor.id
ORDER BY actor.name

-- Notes:
--> Must name subqueries in order to use them!


-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

-- Approach:
-- 1. Filter movie id by year
-- 2. Join to casting 
-- 3. Count actors by movie id
-- 4. Order by actor count, movie title

-- Answer:
 
SELECT title, COUNT(actorid) AS num_actors
FROM (
    SELECT title,id
        FROM movie 
    WHERE yr = 1978
    ) AS movie_1978 JOIN casting ON movie_1978.id=casting.movieid
GROUP BY title
ORDER BY num_actors DESC, title 

-- Notes:
--> Apparently ordered by meant descending, but only for actors


-- 15. List all the people who have worked with 'Art Garfunkel'.

-- Approach:
-- 1. Filter actor id by name
-- 2. SELECT movie id where casting actor id is in filtered actor id
-- 3. JOIN casting actorid to actor.id
-- 4. Filter casting names to not include art (we want ppl that worked with him only)
-- 5. Select actor names
-- 5. Order by actor names

-- Answer:

SELECT actor.name
FROM casting JOIN actor ON casting.actorid=actor.id 
WHERE casting.movieid IN (
    SELECT DISTINCT movieid
    FROM casting 
    WHERE actorid IN (
        SELECT id
        FROM actor 
        WHERE name = 'Art Garfunkel'
        )
    ) AND actor.name != 'Art Garfunkel'
ORDER BY name

-- Notes:
--> Note that we don't want to include Art G. in our results! We only want to know who worked with him
--> Order by useful here
--> Add disctinct to remove duplicate names (what if someone is a producer and actor?)
--> Could remove Art in the join statement too?