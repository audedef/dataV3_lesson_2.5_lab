USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
select s.store_id, a.address, a.district, ci.city, co.country 
from address a
join store s
on a.address_id = s.address_id
join city ci
on a.city_id = ci.city_id
join country co
on ci.country_id = co.country_id ;

-- let's check if you have all stores :
select count(store_id) from store;
-- good


-- 2. Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as business FROM store s
join staff 
on s.store_id = staff.store_id
join payment p
on staff.staff_id = p.staff_id
group by store_id;


-- 3. Which film categories are longest?
-- i'll use length to define the longest
select c.name, sum(f.length) as longest
FROM category c
JOIN film_category fc 
ON c.category_id = fc.category_id 
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY longest DESC ;
-- Sports, Foreign and Family are the longest


-- 4. Display the most frequently rented movies in descending order.
-- title in film - count(rental_id)
select f.title, count(r.rental_id) as rent from film f
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
group by f.title
order by rent DESC ;


-- 5. List the top five genres in gross revenue in descending order.
-- amount in payment - name in category
select c.name, sum(p.amount) as revenue from category c
JOIN film_category fc 
ON c.category_id = fc.category_id 
JOIN film f
ON fc.film_id = f.film_id
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
group by c.name
order by revenue DESC
LIMIT 5;
-- top five genres are sports, then sci-fi, then anim, then drama, then comedy


-- 6. Is "Academy Dinosaur" available for rent from Store 1?
-- title from film - store_id from inventory 
select f.title, i.store_id from inventory i
join film f
on i.film_id = f.film_id
WHERE f.title = "Academy Dinosaur" 
group by store_id;
-- yes academy dinosaur is available for rent in store 1, but also in store 2


-- 7. Get all pairs of actors that worked together. OPTIONNAL
-- which actors in every movie. Then get all possible pairs. Then know which pair of actors worked together



-- 8. Get customers that have rented the same film more than 3 times. - OPTIONNAL
-- film_id from iventory - last name from customer - rental id
select c.last_name, count(r.rental_id) as rentals from rental r
join inventory i on r.inventory_id = i.inventory_id
join customer c on r.customer_id = c.customer_id
group by c.last_name
having rentals >= 3 ;
-- still needs to check what are the same film among rentals



-- 9. For each film, list actor that has acted in more than one film.- OPTIONNAL
-- in how many movie appears every actor. Then for every movie, get all actors that appears in a given movie and in more thnan on film
