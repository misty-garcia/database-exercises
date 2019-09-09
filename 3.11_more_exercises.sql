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

select c.first_name, c.last_name, c.email, country
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
select * from store;
select * from staff;

select sum(amount), s.staff_id
from payment as p
join staff as s
on s.staff_id = p.staff_id
group by s.staff_id;
