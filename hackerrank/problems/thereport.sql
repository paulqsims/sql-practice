-- The Report

-- Prompt:
-- You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.
-- Grades contains the following data:
-- | Grade | Min_Mark | Max_Mark |
-- |-------|----------|----------|
-- |   1   |     0    |     9    |
-- |   2   |    10    |     19   |
-- etc.

-- Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

-- Write a query to help Eve.

-- Sample Output:

-- Maria 10 99
-- Jane 9 81
-- Julia 9 88 
-- Scarlet 8 78
-- NULL 7 63
-- NULL 7 68

-- Note:
-- Print "NULL"  as the name if the grade is less than 8.

-- Answer:

SELECT CASE WHEN Grade < 8 THEN NULL
            ELSE Name END AS Name,
       Grade, Marks
FROM Students s JOIN Grades g ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY Grade DESC, Name, Marks 

-- Notes: 
--> MS SQL SERVER
--> Can do a join with two columns that aren't explicitly named for ID
