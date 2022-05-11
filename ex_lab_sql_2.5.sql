USE sakila ;

-- 1. Select all the actors with the first name ‘Scarlett’.
SELECT * from actor 
WHERE first_name = 'Scarlett';

-- How many films (movies) are available for rent ?
SELECT * FROM inventory;
SELECT COUNT(distinct(film_id)) FROM inventory;
-- 958 films are available for rents

-- 2. How many films have been rented?
SELECT * FROM rental;
SELECT COUNT(distinct(inventory_id)) FROM rental;
-- 4580 movies have been rented (some films could be the same here as for some films we have more than one version of films in inventory

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT * FROM film;
SELECT
MIN(length) as min_duration,
MAX(length) as max_duration
FROM film;
-- min_duration = 46 min // max_duration = 185 min

-- 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT 
round(AVG(length)/60 , 2) as avg_duration 
FROM film;

-- 5. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT(last_name)) FROM actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
-- we assume that operations are rentals. Dates are already in datetime format.
SELECT
DATEDIFF(MAX(last_update), MIN(rental_date)) as duration_operatons
FROM rental;
-- we assume the result is in days (didn't manage to change the format) : 275 days


-- 7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT * FROM rental;
SELECT rental_id, rental_date,
date_format(rental_date, '%M') as rental_month,
date_format(rental_date, '%W') as rental_weekday,
inventory_id,
customer_id,
return_date,
date_format(return_date, '%M') as return_month,
date_format(return_date, '%W') as return_weekday,
staff_id,
date_format(last_update, '%M') as last_update_month,
date_format(last_update, '%W') as last_update_weekday
FROM rental;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT rental_id, rental_date,
date_format(rental_date, '%M') as rental_month,
date_format(rental_date, '%W') as rental_weekday,
CASE 
WHEN (date_format(rental_date, '%M') IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')) THEN 'workday'
WHEN (date_format(rental_date, '%W') IN ('Saturday', 'Sunday')) THEN 'weekend'
ELSE 'No info'
END AS day_type
FROM rental;
-- seems like it doesn't read the info in my condition. Let's try another way :
SELECT rental_id, rental_date,
date_format(rental_date, '%M') as rental_month,
date_format(rental_date, '%W') as rental_weekday,
CASE 
WHEN rental_month IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'workday'
WHEN rental_weekday IN ('Saturday', 'Sunday') THEN 'weekend'
ELSE 'No info'
END AS day_type
FROM rental;
-- it doesn't recognize the new alias column in the case when


-- 9. Get release years.
SELECT title, release_year FROM film;


-- 10. Get all films starting with ARMAGEDDON in the title.
SELECT title FROM film
WHERE (CHARINDEX('ARMAGEDDON',title) != 0) ;

SELECT title FROM film
WHERE left(title,10) = 'ARMAGEDDON' ;
-- This one works : ARMAGEDDON LOST


-- 11. Get all films which title ends with APOLLO.
SELECT title FROM film
WHERE right(title,6) = 'APOLLO' ;
-- There are 5 films ending with 'APOLLO'


-- 12. Get 10 the longest films.
SELECT title, length FROM film
ORDER BY length DESC
LIMIT 10;


-- 13. How many films include Behind the Scenes content?
SELECT count(distinct(title)) FROM film
WHERE right(special_features,17) = 'Behind the Scenes' ;
-- 538
