-- 2- List all details of actors
select * from actor;

-- 3 -List all customer information from DB.
select * from customer;

-- 4 -List different countries

select country from country;

-- 5 -Display all active customers.

select concat(first_name," ",last_name) as Full_name from customer where active = 1;

-- 6 -List of all rental IDs for customer with ID 1.

select rental_id from rental where customer_id = 1;

-- 7 - Display all the films whose rental duration is greater than 5 .

select title from film where rental_duration > 5;

 -- 8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
 
 select  count(film_id) as Total_number from film where replacement_cost between 15 and 20;
 
 -- 9 - Display the count of unique first names of actors
 
 select count(distinct first_name) as Total_distint_names from actor;
 
 -- 10- Display the first 10 records from the customer table .
 
 select * from customer limit 10;
 
 -- 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
 
 select first_name from customer where first_name like "b%" limit 3;
 
 -- 12 -Display the names of the first 5 movies which are rated as ‘G’.
 
 select title from film where rating = 'G' order by rating desc limit 5;
 
 -- 13-Find all customers whose first name starts with "a".
 
 select first_name from customer where first_name like "a%";
 
 -- 14- Find all customers whose first name ends with "a".
 
 select first_name from customer where first_name like "%a";
 
 -- 15- Display the list of first 4 cities which start and end with ‘a’ .
 
 select city from city where city like "a%a" limit 4; 
 
 -- 16- Find all customers whose first name have "NI" in any position.
 
 select first_name from customer where first_name like "%NI%";
 
 -- 17- Find all customers whose first name have "r" in the second position .
 
 select first_name from customer where first_name like "_r%";
 
 -- 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
 
 select first_name from customer where first_name like "a____";
 
 -- 19- Find all customers whose first name starts with "a" and ends with "o".
 
 select first_name from customer where first_name like "a%o";
 
 -- 20 - Get the films with pg and pg-13 rating using IN operator.
 
SELECT 
    title
FROM
    film
WHERE
    rating IN ('pg' , 'pg-13');
 
 -- 21 - Get the films with length between 50 to 100 using between operator.
 
SELECT 
    title
FROM
    film
WHERE
    LENGTH(title) BETWEEN 50 AND 100;
 
 -- 22 - Get the top 50 actors using limit operator.
 
SELECT 
    CONCAT(first_name, ' ', last_name) AS Full_name
FROM
    actor
LIMIT 50;
 
 -- 23 - Get the distinct film ids from inventory table.
 
SELECT DISTINCT
    (film_id)
FROM
    inventory;
 
--  Question 1:

-- Retrieve the total number of rentals made in the Sakila database.

-- Hint: Use the COUNT() function.

SELECT 
    COUNT(rental_id) AS Total_number
FROM
    rental;

-- Question 2:

-- Find the average rental duration (in days) of movies rented from the Sakila database.

-- Hint: Utilize the AVG() function.

SELECT 
    AVG(DAY(rental_date)) AS Average_rental_duration
FROM
    rental;
 
--  String Functions:

-- Question 3:

-- Display the first name and last name of customers in uppercase.

-- Hint: Use the UPPER () function.

SELECT 
    UPPER(CONCAT(first_name, ' ', last_name)) AS Upper_case_Names
FROM
    actor;

-- Question 4:

-- Extract the month from the rental date and display it alongside the rental ID.

-- Hint: Employ the MONTH() function.

SELECT 
    MONTH(rental_date) AS Month, rental_id
FROM
    rental;

-- Question 5:

-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals).

-- Hint: Use COUNT () in conjunction with GROUP BY.

SELECT 
    customer_id, COUNT(rental_id) AS count_rental
FROM
    rental
GROUP BY customer_id;

-- Question 7:
-- Determine the total number of rentals for each category of movies.
-- Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.

SELECT 
    title, COUNT(film_id) AS Total_number
FROM
    film_text
GROUP BY title; 

-- Question 8:

-- Find the average rental rate of movies in each language.

-- Hint: JOIN film and language tables, then use AVG () and GROUP BY.

SELECT 
    AVG(film.rental_rate) AS avg_rental_rate,
    language.name AS language
FROM 
    film
JOIN 
    language 
ON 
    film.language_id = language.language_id
GROUP BY 
    language.name;

-- Questions 9 -
-- Display the title of the movie, customer s first name, and last name who rented it.
-- Hint: Use JOIN between the film, inventory, rental, and customer tables.

SELECT 
    film.title AS Title,
    customer.first_name AS First_name,
    customer.last_name AS Last_name
FROM
    film
        JOIN
    inventory ON film.film_id = inventory.film_id
        JOIN
    rental ON rental.inventory_id = inventory.inventory_id
		JOIN
	customer
    on customer.customer_id = rental.customer_id;
    
   --  Question 10:
-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
-- Hint: Use JOIN between the film actor, film, and actor tables.

SELECT 
    CONCAT(first_name, '  ', last_name) AS Full_name
FROM
    actor
        JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
        JOIN
    film ON film.film_id = film_actor.film_id
WHERE
    film.title = 'GONE TROUBLE';

-- Question 11:
-- Retrieve the customer names along with the total amount they've spent on rentals.
-- Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY

SELECT 
    concat(first_name, ' ', last_name) AS full_name, SUM(amount)
FROM
    customer
        JOIN
    rental ON customer.customer_id = rental.customer_id
        JOIN
    payment ON rental.rental_id = payment.rental_id group by full_name;

-- Question 12:
-- List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.

SELECT 
    title, CONCAT(first_name, ' ', last_name) AS full_name
FROM
    film
         JOIN
    inventory ON film.film_id = inventory.film_id
        JOIN
    customer ON inventory.store_id = customer.store_id
        JOIN
    address ON address.address_id = customer.address_id
        JOIN
    city ON city.city_id = address.city_id
where city = 'London' group by title,full_name;

-- Question 13:
-- Display the top 5 rented movies along with the number of times they've been rented.
-- Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.

SELECT 
    title, COUNT(rental_id) AS Number_of_times
FROM
    film
        JOIN
    inventory ON film.film_id = inventory.film_id
        JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY title
LIMIT 5;


-- Question 14:
-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.

select first_name from customer join rental on
customer.customer_id = rental.customer_id join store on customer.store_id = store.store_id group by first_name;

-- 1. Rank the customers based on the total amount they've spent on rentals.

select rank() over (order by rental_id ) as Ranks , first_name from customer join rental on customer.customer_id = rental.customer_id;

-- 2. Calculate the cumulative revenue generated by each film over time.

select sum(rental_rate) over (order by release_year) as cumulative_revenue from film limit 1;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT 
    film.length AS film_length,
    AVG(datediff(rental.return_date,rental.rental_date)) AS avg_rental_duration
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY 
    film.length
ORDER BY 
    film_length;

    -- 4. Identify the top 3 films in each category based on their rental counts.
    
select * from (select row_number() over (partition by category_id order by category_id) as each_category,title,category_id from film join film_category 
on film.film_id = film_category.film_id) as category where each_category in (1,2,3) ;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals
-- across all customers.

select count(rental_id) as  rental_counts,sum(rental_rate) as Total, avg(rental_rate) from film join inventory
on film.film_id = inventory.film_id join rental on inventory.inventory_id = rental.inventory_id;

-- 6. Find the monthly revenue trend for the entire rental store over time.

SELECT 
    DATE_FORMAT(payment.payment_date, '%Y-%m') AS month_year,
    SUM(payment.amount) AS total_revenue
FROM 
    payment
GROUP BY 
    month_year
ORDER BY 
    month_year;
    
-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all custommer;

select first_name , sum(payment.amount) as amount   from customer join payment on customer.customer_id = payment.customer_id 
 where amount < (select 0.2*sum(amount) as total_spending from payment) group by first_name ;


-- 8. Calculate the running total of rentals per category, ordered by rental count.

SELECT 
    category.name AS category_name,
    COUNT(rental.rental_id) AS rental_count,
    SUM(COUNT(rental.rental_id)) OVER (ORDER BY COUNT(rental.rental_id) DESC) AS running_total
FROM 
    rental
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name
ORDER BY 
    rental_count DESC;

-- 9. Find the films that have been rented less than the average rental count for their respective categories.

SELECT 
    film_text.title AS title, SUM(payment.amount) AS amount
FROM
    film_text
        JOIN
    inventory ON film_text.film_id = inventory.film_id
        JOIN
    rental ON inventory.inventory_id = rental.inventory_id
        JOIN
    payment ON rental.rental_id = payment.rental_id
WHERE
    amount < (SELECT 
            AVG(rental_rate)
        FROM
            film)
GROUP BY title;


-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

select months,amount from (select sum(amount) over (partition by month(payment_date) order by month(payment_date)) as amount ,month(payment_date) as months  from payment order by amount desc ) as details group by months,amount ;

