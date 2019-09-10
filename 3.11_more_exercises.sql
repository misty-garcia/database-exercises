use bayes_811;

-- 1. how much do current managers get paid, relative to the average salary for the department
-- does any manager get paid less than average
use employees;

select * from employees;
select * from dept_manager;
select * from salaries;
select * from departments;
select * from dept_emp;

select dept_name, round(avg(salary),2) as dept_avg
from salaries as s
join employees as e
on s.emp_no = e.emp_no
join dept_emp as de
on de.emp_no = e.emp_no
join departments as d
on d.dept_no = de.dept_no
group by dept_name;

select dept_name, round(avg(salary),2) as mana_avg 
from salaries as s
join employees as e
on s.emp_no = e.emp_no
join dept_manager as dm
on dm.emp_no = e.emp_no
join departments as d
on d.dept_no = dm.dept_no
group by dept_name;

select d.dept_name, avg(s.salary) as dept_avg, am.salary
from salaries as s
join employees as e
	on s.emp_no = e.emp_no
join dept_emp as de
	on de.emp_no = e.emp_no
join departments as d
	on d.dept_no = de.dept_no
where am.salary in
	(select dept_name, avg(salary)
	from salaries as s
	join employees as e
		on s.emp_no = e.emp_no
	join dept_manager as dm
		on dm.emp_no = e.emp_no	
	join departments as d	
	on d.dept_no = dm.dept_no
	group by dept_name
	) as am
group by dept_name;

-- use world database
use world;

-- what languages are spoken in santa monica
select * from country;
select * from city;
select * from countrylanguage;

select co.name, ci.name, cl.language, cl.percentage
from country as co
join city as ci
on ci.countrycode = co.code
join countrylanguage as cl
on cl.countrycode = co.code
where ci.name = 'Santa Monica'
order by percentage;

-- how many different languages are in each region
select region, count(*)
from country
group by region
order by count(*);

-- what is the population for each region
select region, sum(population) as pop_sum
from country
group by region
order by pop_sum desc;

-- what is the population for each continent 
select * from country;

select continent, sum(population) as pop_sum
from country
group by continent
order by pop_sum desc;

-- what is the avg life expectancy globally 
select avg(lifeexpectancy) from country;

-- what is the avg life expectancy for each region, each continent
select continent, avg(lifeexpectancy) as avg_life
from country
group by continent
order by avg_life asc;

select region, avg(lifeexpectancy) as avg_life
from country
group by region
order by avg_life asc;

-- bonus. find countires whose local name is different from official name
select * from country;

select name, localname 
from country
where localname != name;

-- bonus. how many countries have a life expectancy less than x, where x is 60
select name, lifeexpectancy
from country
where lifeexpectancy < 60;

-- bonus. what state is city x located, where x is austin
select * from city;

select name, district 
from city
where name = 'Austin';

-- bonus. what region of world is city x located in, where x is austin
select * from city;
select * from country;

select ci.name, co.region
from city as ci
join country as co
on ci.countrycode = co.code
where ci.name = 'Austin';

-- bonus. what is life expentancy in city x, where x is Austin
select ci.name, co.region, co.lifeexpectancy
from city as ci
join country as co
on ci.countrycode = co.code
where ci.name = 'Austin';

-- s1. display the first and last name of all actors in lower case
select lower(first_name), lower(last_name)
from actor;

-- s2. ID number, first name, and last name of an actor, with first name "Joe." write one query
select actor_id, first_name, last_name from actor
where first_name = 'joe';

-- S3. Find all actors whose last name contain the letters "gen"
select * from actor
where last_name like '%gen%';

-- s4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order
select * from actor
where last_name like '%li%'
order by last_name, first_name;

-- s5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China
select country_id, country from country
where country in ('afghanistan', 'bangladesh', 'china');

-- s6. list the last names of all the actors, as well as how many actors have that last name
select last_name, count(*) from actor
group by last_name;

-- s7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(*) from actor
group by last_name
having count(*) >= 2;

-- s8. You cannot locate the schema of the address table. Which query would you use to re-create it?
describe address;

-- s9. Use JOIN to display the first and last names, as well as the address, of each staff member
select * from staff;
select * from address;

select first_name, last_name, address
from staff as s
join address as a
on a.address_id = s.address_id;

-- s10. use join to find total rung by each staff member in august 2005
select * from staff;
select * from payment;

select sum(amount), s.first_name, s.last_name
from payment as p
join staff as s
on s.staff_id = p.staff_id
where payment_date like '2005-08%'
group by s.staff_id;

-- s11. list each film and the number of actors with that film
select * from film;
select * from film_actor;

select f.title, count(fa.actor_id) as num_act
from film_actor as fa
right join film as f
on f.film_id = fa.film_id
group by f.title
order by num_act desc;

-- s12. how many copies of the film Hunchback Impossible exist in the inventory system
select * from film;
select * from inventory;

select title, count(*) 
from film as f
join inventory as i
on i.film_id = f.film_id
where title = 'hunchback impossible';

-- s13. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English
select * from film;
select * from language;

select title, language_id
from film as f
where language_id in
	(select language_id
	from language as l 
	where name = 'English')
	and (title like 'k%' or title like 'q%');

-- s14. use subqueries to display all actors who appear in alone trip
use sakila;

select * from actor;
select * from film;
select * from film_actor;

select a.first_name, a.last_name, f.title
	from film_actor as fa
	join film as f
	on f.film_id = fa.film_id
	join actor as a
	on a.actor_id = fa.actor_id
	where f.film_id =
		(select film_id
		from film
		where title = "alone trip");

-- s15. get all the names and email addresses of candian customers
select * from address;
select * from country;
select * from city;
select * from customer;

select c.first_name, c.last_name, c.email, co.country
from customer as c
join address as a
on a.address_id = c.address_id
join city as ci
on ci.city_id = a.city_id
join country as co
on co.country_id = ci.country_id
where co.country = 'Canada';

-- s16. identify family films
select * from film;
select * from film_category;
select * from category;

select f.title, c.name
from film_category as fc
join category as c
on c.category_id = fc.category_id
join film as f
on f.film_id = fc.film_id
where name = 'family';

-- s17. how much business in dollars did each store bring in
select * from payment;
select * from rental;
select * from inventory;

select * from staff;
select * from store;

select sum(amount), s.staff_id
from payment as p
join staff as s
on s.staff_id = p.staff_id
group by s.staff_id;

-- s18. display each store's id, city, country
select * from store;
select * from address;
select * from city;
select * from country;

select store_id, ci.city, co.country
from store as s
join address as a
on a.address_id = s.store_id
join city as ci
on ci.city_id = a.city_id
join country as co
on co.country_id = ci.country_id;

-- s19. list top five genres in gross revenue in desc order
select * from payment;
select * from rental;
select * from inventory;
select * from film;
select * from film_category;
select * from category;

select c.name, sum(p.amount) as total_purchase
from payment as p
join rental as r
on r.rental_id = p.rental_id
join inventory as i
on i.inventory_id = r.inventory_id
join film_category as fc
on fc.film_id = i.film_id 
join category as c
on c.category_id = fc.category_id
group by c.name
order by total_purchase desc
limit 5;

-- 1a. select all columns the actor table
select * from actor;

-- 1b. select only last name column from actor table
select last_name from actor;

-- 1c. select only the following colums from the film table
select * from film;

-- 2a. Select all distinct (different) last names from the actor table.
select distinct last_name from actor;

-- 2b. Select all distinct (different) postal codes from the address table.
select distinct postal_code from address;

-- 2c. Select all distinct (different) ratings from the film table. 
select distinct rating from film;

-- 3a. Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
select title, description, rating, length from film
where length > 180;

-- 3b. Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
select payment_id, amount, payment_date from payment
where payment_date >= '2005-05-27';

-- 3c. Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
select payment_id, amount, payment_date from payment
where date(payment_date) = '2005-05-27';

-- 3d. Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
select * from customer
where last_name like 's%' and first_name like 'n%';

-- 3e. Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
select * from customer 
where last_name like 'm%' or active = 0
order by active;

-- 3f. Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
select * from category
where category_id > 4 and (name like 'C%' or name like 'S%' or name like 't%');

-- 3g. Select all columns minus the password column from the staff table for rows that contain a password.
select * from staff
where isnull(password);

-- 3h. Select all columns minus the password column from the staff table for rows that do not contain a password.
select * from staff
where not isnull(password);

-- 4a. Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
select phone, district from address
where district in ('California', 'England', 'Taipei', 'West Java');

-- 4b. Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
select payment_id, amount, payment_date from payment
where date(payment_date) in ('2005-05-25', '2005-05-27', '2005-05-29');

-- 4c. Select all columns from the film table for films rated G, PG-13 or NC-17.
select * from film
where rating in ('g','pg-13','nc-17');

-- 5a. Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
select * from payment
where payment_date between '2005-05-25 00:00:0' and '2005-05-26 23:59:59';

-- 5b. Select the following columns from the film table for films where the length of the description is between 100 and 120.
select * from film
where length(description) between 100 and 120;

-- Hint: total_rental_cost = rental_duration * rental_rate

-- 6a. Select the following columns from the film table for rows where the description begins with "A Thoughtful".
select * from film
where description like 'a thoughtful%';
-- 6b. Select the following columns from the film table for rows where the description ends with the word "Boat".
select * from film
where description like '%boat';

-- 6c. Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
select * from film
where description like '%database%' and length > 180;

-- 7a. Select all columns from the payment table and only include the first 20 rows.
select * from payment
limit 20;

-- 7b. Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
select payment_date, amount from payment
where amount > 5 
limit 1000 offset 1999;

-- 7c. Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
select * from customer
limit 100 offset 100; 

-- 8a. Select all columns from the film table and order rows by the length field in ascending order.
select * from film
order by length asc;

-- 8b. Select all distinct ratings from the film table ordered by rating in descending order.
select distinct rating from film
order by rating desc;

-- 8c. Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
select payment_date, amount from payment
order by amount desc
limit 20;

-- 8d. Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
select title, description, special_features, length, rental_duration from film
where special_features like '%behind the scenes%' and rental_duration between 5 and 7
order by length desc
limit 10;

/* 9a. Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
Label customer first_name/last_name columns as customer_first_name/customer_last_name
Label actor first_name/last_name columns in a similar fashion.
returns correct number of records: 599 */
select * from customer;
select * from actor;

select concat(c.first_name, " ", c.last_name) as customer_full_name, concat(a.first_name, " ", a.last_name) as actor_full_name
from customer as c
left join actor as a
on c.last_name = a.last_name; 

/* 9b. Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 200 */
select concat(c.first_name, " ", c.last_name) as customer_full_name, concat(a.first_name, " ", a.last_name) as actor_full_name
from customer as c
right join actor as a
on c.last_name = a.last_name;

/* 9c. Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 43 */
select concat(c.first_name, " ", c.last_name) as customer_full_name, concat(a.first_name, " ", a.last_name) as actor_full_name
from customer as c
join actor as a
on c.last_name = a.last_name;

/*  9d. Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
Returns correct records: 600 */
select * from city;
select * from country;

select city, country
from city as ci
join country as co
on ci.country_id = co.country_id;


/* 9e.  Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
Label the language.name column as "language"
Returns 1000 rows */
select * from film;
select * from language;

select title, description, release_year, l.name as language
from film as f
left join language as l
on l.language_id = f.language_id;

/* 9f. Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
returns correct number of rows: 2  */
select * from staff;
select * from address;
select * from city;

select s.first_name, s.last_name, a.address, a.address2, c.city, a.district, a.postal_code
from staff as s
left join address as a
on a.address_id = s.address_id
left join city as c
on c.city_id = a.city_id;

-- 1. What is the average replacement cost of a film? Does this change depending on the rating of the film?
select avg(replacement_cost) from film;

select avg(replacement_cost), rating from film
group by rating;

-- 2. How many different films of each genre are in the database?
select * from film; 
select * from film_category;
select * from category;

select c.name, count(fc.category_id) 
from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on c.category_id = fc.category_id
group by fc.category_id;

-- 3. what are the 5 frequently rented films?
select * from film;
select * from rental;
select * from inventory;

select f.title, count(*)
from rental as r
join inventory as i
on i.inventory_id = r.inventory_id
join film as f
on f.film_id = i.film_id
group by f.title
order by count(*) desc
limit 5;

-- 4. what are the 4 most profitable films? Hint: total_rental_cost = rental_duration * rental_rate
select * from film;
select * from rental;
select * from inventory;
select * from payment;

select f.title, sum(p.amount) as total_rent
from rental as r
join inventory as i
on i.inventory_id = r.inventory_id
join film as f
on f.film_id = i.film_id
join payment as p
on p.rental_id = r.rental_id
group by f.title
order by total_rent desc
limit 5;

-- 5. who is the best customer?
select * from customer;
select * from payment;

select concat(c.last_name, ", ", c.first_name) as name, sum(amount) as total
from payment as p
join customer as c
on c.customer_id = p.customer_id
group by name
order by total desc
limit 1;

-- 6. which actors have appeared in teh most films
select * from film;
select * from film_actor;
select * from actor;

select concat(last_name, ", ", first_name) as actor_name, count(*) as total
from film_actor as fa
join film as f
on f.film_id = fa.film_id
join actor as a
on a.actor_id = fa.actor_id
group by a.actor_id
order by total desc
limit 5;

-- 7. what are the sales for each store for each month in 2005
select * from store;
select * from payment;
select * from rental;

select month(payment_date) as month, p.staff_id as store_id, sum(amount) as sales 
from payment as p
join store as s
on s.manager_staff_id = p.staff_id
where payment_date like '2005%'
group by month(payment_date), p.staff_id;

-- 8. bonus: find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs

