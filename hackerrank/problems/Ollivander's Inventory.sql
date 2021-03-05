-- Ollivander's Inventory
-- https://www.hackerrank.com/challenges/harry-potter-and-wands

-- Prompt:
-- Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

-- Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.



-- Approach:

-- End table: id | age | coins_needed | power
-- Order by Power Desc, age DESC
-- JOIN wands and wands property on code to get age and not evil wands
-- Find the min coins grouped by wand 

-- Subquery
-- 1. 
-- 2. 

-- Parent query
-- 3. 
-- 4. 

-- Query
-- 1. Join wands and wand property on code
-- 2. Conditional on is_evil = 0
-- 3. Get the min number of coins needed
-- 4. Order 
-- 5. Select

-- Answer:

-- DID NOT FINISH, question is unclear 

SELECT id, age, 
    MIN(coins_needed) OVER(PARTITION BY code, age, power) AS min_cost,
       power
FROM (
    SELECT id, age, coins_needed, power, code
    FROM Wands w JOIN Wands_Property wp ON w.code=wp.code AND 
        is_evil = 0
    ) AS t
ORDER BY power DESC, age DESC