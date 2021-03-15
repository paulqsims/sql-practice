-- Total Cost Of Orders
-- https://platform.stratascratch.com/coding-question?id=10183&python=

-- Prompt:
-- Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. Order records by customer's first name alphabetically.


-- Approach:

-- End table: id | name | total order cost
-- 

-- Answer:

SELECT c.id, c.first_name, t.tot_ord_cost
FROM (
    SELECT cust_id, SUM(order_quantity * order_cost) AS tot_ord_cost
    FROM orders
    GROUP BY cust_id
    ) AS t
    JOIN customers c ON t.cust_id=c.id
ORDER BY c.first_name