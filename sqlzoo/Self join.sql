-- SQLzoo: Self join
-- Link: https://sqlzoo.net/wiki/Self_join
-- Tables: Edinburgh Buses - stops, route

----------
-- Summary
----------

-- 1. How many stops are in the database.

-- Questions:
-- 1. Unique or total number of stops?

-- Approach:
-- 1. Count number of unique stops overall

-- Answer: 

SELECT COUNT(DISTINCT stop) as num_stops
FROM route

-- Notes:
--> No GROUP BY since count of entire table
--> They wanted unique stops even though that wasn't clear in the instructions


-- 2. Find the id value for the stop 'Craiglockhart'

-- Approach:
-- 1. Filter by name in stops
-- 2. Select id

-- Answer:

SELECT id
FROM stops
WHERE name = 'Craiglockhart'


-- 3. Give the id and the name for the stops on the '4' 'LRT' service.

-- Approach: 
-- 1. Filter by 4 for bus number and LRT for bus company from route table 
-- 2. JOIN with stops on id
-- 3. Select id and name

-- Answer:

SELECT DISTINCT id, name
FROM stops JOIN route ON stops.id=route.stop
WHERE route.num = '4' AND route.company = 'LRT'

-- Notes:
--> Note the quotation marks around the bus number!


-------------------
-- Routes and stops
-------------------

-- 4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num

-- Approach:
-- 1. Add Having to group results by count column = 2

-- Answer:

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

-- Notes:
--> Remember, you can put aggregate functions in WHERE and HAVING statements, but will have to include them in the SELECT statement as well
--> Can't create new count column (with a name) and then use that name in HAVING since it's created at the end, After having has been executed!


-- 5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 

-- Approach:
-- 1. a.stop is showing routes from craiglockhart, so need to restrict destinations in b.stop by filtering by b.stop = London Road (149)

-- Answer:

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149


-- 6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'

-- Approach:
-- 1. Just change where clause to filter out london road


-- Answer:

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

-- Notes:
--> Remember that OG table column references are maintained even after joining and you can reference them again later!
