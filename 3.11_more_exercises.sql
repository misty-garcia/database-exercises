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
