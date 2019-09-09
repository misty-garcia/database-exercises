use bayes_811;

-- 1. how much do current managers get paid, relative to the average salary for the department
-- does any manager get paid less than average
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

-- s14. use subqueries to display all actors who appear in alone trip
use sakila;

select * from actor;
select * from film;
select * from film_actor;

select a.first_name, a. last_name,f.title
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
where payment_date >= '2005-05-27';

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