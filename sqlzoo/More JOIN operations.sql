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

-- Notes
-- + Must name subqueries in order to use them!
-- 