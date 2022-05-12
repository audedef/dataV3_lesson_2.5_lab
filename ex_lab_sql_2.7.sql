USE sakila;

-- 1. How many films are there for each of the categories in the category table. 
-- Using category & film_category table (left) - category_id (right)
select c.name, count(fc.film_id) as counts 
FROM film_category fc
JOIN category c 
ON fc.category_id = c.category_id 
GROUP BY c.name
ORDER BY counts DESC ;


-- 2. Display the total amount rung up by each staff member in August of 2005.
-- Payments (left) - staff (right)

select s.last_name, sum(p.amount) as total_amount 
FROM payment p
JOIN staff s 
ON p.staff_id = s.staff_id 
WHERE p.payment_date BETWEEN "2005-08-01" AND "2005-08-31"
GROUP BY s.last_name
ORDER BY total_amount DESC ;


-- 3. Which actor has appeared in the most films?
-- film-actor (left) - actor (right)
-- an actor can play in many films
SELECT a.actor_id, a.last_name, a.first_name, (count(fa.film_id)) as counts 
FROM film_actor fa
JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY actor_id
ORDER BY counts DESC;
-- Gina Degeneres appeared in the most films (42 films)


-- 4. Most active customer (the customer that has rented the most number of films)
-- rental (left) & customer (right)
SELECT c.customer_id, c.last_name, (count(r.rental_id)) as counts 
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY customer_id
ORDER BY counts DESC;
-- Hunt is the most active customer (with 46 rentals)


-- 5. Display the first and last names, as well as the address, of each staff member.
-- staff (left) - address (right)
select s.first_name, s.last_name, a.address, a.district
FROM staff s
JOIN address a
ON s.address_id = a.address_id;



-- 6. List each film and the number of actors who are listed for that film.
-- film_actor (left) & film (right)
select f.title, count(fa.actor_id) as counts 
FROM film_actor fa
JOIN film f 
ON fa.film_id = f.film_id
GROUP BY f.title
ORDER BY counts DESC ;


-- 7. List the total paid by each customer. List the customers alphabetically by last name.
-- payment (left) & customer (right)
select c.last_name, c.customer_id, sum(p.amount) FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name ASC;
-- I group by customer_id to avoid mixing customers with the same last name


-- 8. List number of films per category.
-- film_category (left) & category (right)
select c.name, count(fc.film_id) as counts FROM film_category fc
JOIN category c 
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY counts DESC;
-- I don't understand how this question is different from the 1st one
