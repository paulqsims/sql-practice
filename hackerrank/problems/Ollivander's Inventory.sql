-- Ollivander's Inventory
-- https://www.hackerrank.com/challenges/harry-potter-and-wands

-- Prompt:
-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

-- Approach:

-- End table: HackerID | Name
-- Filter by full score, >1 challenge
-- Get full score from difficulty table
-- Calculate challenges > 1 by hacker and full score
-- ORDER tot num challenges that have full score
-- Ascending hacker id 

-- Subquery
-- 1. Get counts of challenges > 1 by hacker 
-- 2. Filter by full scores only
-- Parent query
-- 3. Filter by counts > 1
-- 4. Order by counts desc, ids ascending

-- Answer: