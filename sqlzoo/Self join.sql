-- SQLzoo: Self join
-- Link: https://sqlzoo.net/wiki/Self_join
-- Tables: Edinburgh Buses - stops, route


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


-- 4. 