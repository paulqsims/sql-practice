-- 13. Actors with 15 leading roles
-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.


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