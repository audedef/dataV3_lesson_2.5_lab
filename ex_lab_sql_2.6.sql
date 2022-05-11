USE sakila;

-- 1. In the table actor, which are the actors whose last names are not repeated? 
-- For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
-- These three actors have the same last name. So we do not want to include this last name in our output. 
-- Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
SELECT last_name, first_name, count(last_name) as count_ln FROM actor 
GROUP BY last_name
HAVING count_ln = 1
ORDER BY last_name ASC;


-- 2. Which last names appear more than once? 
-- We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once
SELECT last_name, first_name, count(last_name) as count_ln FROM actor 
GROUP BY last_name
HAVING count_ln > 1
ORDER BY last_name ASC;


-- 3. Using the rental table, find out how many rentals were processed by each employee.
SELECT count(rental_id) AS count_rental, staff_id 
FROM rental
GROUP BY staff_id
ORDER BY count_rental DESC;


-- 4. Using the film table, find out how many films were released each year.
SELECT * FROM film ;
SELECT count(film_id) as count_film, release_year FROM film
GROUP BY release_year ;


-- 5. Using the film table, find out for each rating how many films were there.
SELECT count(film_id), rating FROM film
GROUP BY rating
ORDER BY count(film_id) DESC;


-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT round(AVG(length),2) as avg_length, rating FROM film
GROUP BY rating
ORDER BY avg_length DESC;


-- 7.Which kind of movies (rating) have a mean duration of more than two hours?
SELECT round(AVG(length),2) as avg_length, rating FROM film
GROUP BY rating
HAVING avg_length > 120
ORDER BY avg_length DESC;


-- 8. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.
SELECT title,
	   length,
	   RANK()OVER(
       ORDER BY length DESC) Rank1_  
FROM film
WHERE (length <> ' ') AND (length IS NOT NULL)
ORDER BY length DESC;
