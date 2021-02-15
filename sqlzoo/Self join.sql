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

--------------------
-- Using a self join
--------------------

-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

-- Approach:
-- 1. Services = bus number and company, so I need these in the select
-- 2. I need to filter routes by 115 and 137 for arriving and going with a self join

-- Answer:

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON (a.num=b.num AND a.company=b.company)
WHERE a.stop = 115 AND b.stop = 137

-- Notes:
--> Keep in mind that the self join where imposes a filter on both stop columns so you don't need OR statement 


-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

-- Approach:
-- 1. Self join on route to get connections
-- 2. Join 1 to stops table and get names
-- 3. Filter by names
-- 4. Select company and bus number

-- Answer:

SELECT a.company,a.num
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
             JOIN stops stopsa ON (a.stop=stopsa.id)
             JOIN stops stopsb ON (b.stop=stopsb.id)
WHERE stopsa.name = 'Craiglockhart' AND stopsb.name = 'Tollcross'


-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.


-- Approach:
-- 1. Self join route
-- 2. Join with stops to get names
-- 3. Filter by craiglockhart in first route and LRT company
-- 4. Select company and bus number and stops from route b

-- Answer:

SELECT DISTINCT stopsb.name,a.company, a.num
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
             JOIN stops stopsa ON (stopsa.id=a.stop) 
             JOIN stops stopsb ON (stopsb.id=b.stop)
WHERE stopsa.name='Craiglockhart' AND a.company = 'LRT' AND b.company = 'LRT'

