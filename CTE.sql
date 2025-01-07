-- 5. CTE Basics:

--  a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 

--  have acted in from the actor and film_actor tables.
 
WITH FilmLanguageCTE AS (
    SELECT 
        f.title AS film_title, 
        l.name AS language_name, 
        f.rental_rate
    FROM 
        film f
    JOIN 
        language l ON f.language_id = l.language_id
)
SELECT * 
FROM FilmLanguageCTE;

-- 6. CTE with Joins:

--  a. Create a CTE that combines information from the film and language tables to display the film title, 

--  language name, and rental rate.

WITH CustomerRevenue AS (
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        SUM(p.amount) AS total_revenue
    FROM 
        customer c
    JOIN 
        payment p ON c.customer_id = p.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
)
SELECT * 
FROM CustomerRevenue;

-- 7 CTE for Aggregation:
--  a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
--  from the customer and payment tables.

with Total_revenue as (

select concat(c.first_name + " " + c.last_name) as Name_ , sum(p.amount) as Total_revenue 
from customer c join payment p
on c.customer_id = p.customer_id 
 group by Name_)
 
 select * from Total_revenue;
 
-- 8 CTE with Window Functions:

--  a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

WITH FilmRankingCTE AS (
    SELECT 
        film_id, 
        title AS film_title, 
        rental_duration, 
        RANK() OVER (ORDER BY rental_duration DESC) AS rank_
    FROM 
        film
)
SELECT * 
FROM FilmRankingCTE
ORDER BY rank_, film_title;

-- 9 CTE and Filtering:

--  a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 

--  customer table to retrieve additional customer details

WITH CustomerRentalCount AS (
    SELECT 
        r.customer_id, 
        COUNT(r.rental_id) AS rental_count
    FROM 
        rental r
    GROUP BY 
        r.customer_id
    HAVING 
        COUNT(r.rental_id) > 2
)
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    c.email, 
    crc.rental_count
FROM 
    CustomerRentalCount crc
JOIN 
    customer c ON crc.customer_id = c.customer_id
ORDER BY 
    crc.rental_count DESC, c.last_name, c.first_name;

-- 10 CTE for Date Calculations:

--  a. Write a query using a CTE to find the total number of rentals made each month, considering the 

--  rental_date from the rental table
WITH MonthlyRentalCount AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM 
        rental
    GROUP BY 
        DATE_FORMAT(rental_date, '%Y-%m')
    ORDER BY 
        rental_month
)
SELECT * 
FROM MonthlyRentalCount;

-- 11' CTE and Self-Join:

--  a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 

--  together, using the film_actor table.

WITH ActorPairs AS (
    SELECT 
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        f.title AS film_title
    FROM 
        film_actor fa1
    JOIN 
        film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
    JOIN 
        film f ON fa1.film_id = f.film_id
)
SELECT 
    a1.actor_id AS actor1_id, 
    a1.first_name AS actor1_first_name, 
    a1.last_name AS actor1_last_name, 
    a2.actor_id AS actor2_id, 
    a2.first_name AS actor2_first_name, 
    a2.last_name AS actor2_last_name, 
    film_title
FROM 
    ActorPairs ap
JOIN 
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN 
    actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY 
    film_title, actor1_last_name, actor2_last_name;

-- 12. CTE for Recursive Search:

--  a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 

--  considering the reports_to column


CREATE TABLE staff_hierarchy (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    reports_to INT NULL
);

INSERT INTO staff_hierarchy 
VALUES
    (1, 'John', 'Smith', NULL),    -- Top-level manager
    (2, 'Jane', 'Doe', 1),         -- Reports to John
    (3, 'Mike', 'Ross', 2),        -- Reports to Jane
    (4, 'Rachel', 'Zane', 2);      -- Reports to Jane

WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Start with the specified manager (e.g., manager_id = 1)
    SELECT 
        staff_id, 
        first_name, 
        last_name, 
        reports_to
    FROM 
        staff_hierarchy
    WHERE 
        staff_id = 1  -- Replace 1 with the desired manager's staff_id

    UNION ALL

    -- Recursive member: Find employees who report to the current level of employees
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.reports_to
    FROM 
        staff_hierarchy s
    JOIN 
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * 
FROM EmployeeHierarchy
ORDER BY reports_to, staff_id;









