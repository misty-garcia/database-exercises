use employees;

-- In your script, use DISTINCT to find the unique titles in the titles table. Your results should look like:
select distinct title from titles;

-- Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY.
select last_name from employees
where last_name like 'e%' and last_name like '%e'
group by last_name;

-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.

select distinct concat(first_name, ' ', last_name) from employees
where last_name like 'e%' and last_name like '%e';

-- Find the unique last names with a 'q' but not 'qu'. Your results should be:
select distinct last_name from employees
where last_name like '%q%' and last_name not like '%qu%';

-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
select last_name, count(*) from employees
group by last_name
order by count(*) desc;

-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
select first_name, gender, count(*) from employees
where first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya'
group by first_name, gender;

-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
select lower( concat( 
				substr(first_name, 1, 1), 
				substr(last_name, 1, 4), 
				'_',
				substr(birth_date,6,2),
				substr(birth_date,3,2)
				)) as username,
		count(*)
from employees
group by username
order by count(*) desc;

-- Bonus: how many duplicate usernames are there?
select count(*) from 
	(select lower( concat( 
				substr(first_name, 1, 1), 
				substr(last_name, 1, 4), 
				'_',
				substr(birth_date,6,2),
				substr(birth_date,3,2)
				)) as username,
		count(*)
	from employees
	group by username having count(*) > 1) as total_count;