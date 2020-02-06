-- Create a file named 3.5.1_where_exercises.sql. Make sure to use the employees database
use employees;
show tables;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
select * from employees
where first_name in ('Irena', 'Vidya', 'Maya');

-- Find all employees whose last name starts with 'E' — 7,330 rows.
select * from employees
where last_name like 'e%';

-- Find all employees hired in the 90s — 135,214 rows.
select * from employees
where hire_date like '199%';

-- Find all employees born on Christmas — 842 rows.
select * from employees
where birth_date like '%12-25';

-- Find all employees with a 'q' in their last name — 1,873 rows.
select * from employees
where last_name like '%q%';

-- Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
select * from employees
where first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya';

-- Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
select * from employees
where (first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya')
	and gender = 'M';

-- Find all employees whose last name starts or ends with 'E' — 30,723 rows.
select * from employees
where last_name like 'e%' or last_name like '%e';

-- Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
select * from employees
where last_name like 'e%' and last_name like '%e';

-- Find all employees hired in the 90s and born on Christmas — 362 rows.
select * from employees
where hire_date like '199%' and birth_date like '%12-25';

-- Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
select concat(first_name, ' ', last_name) as full_name
from employees
where last_name like 'e%' or last_name like '%e';

-- Convert the names produced in your last query to all uppercase.
select upper(concat(first_name, ' ', last_name)) as full_name
from employees
where last_name like 'e%' or last_name like '%e';

-- For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
select datediff(now(), hire_date) as days_worked
from employees
where hire_date like '199%' and birth_date like '%12-25';

-- Find the smallest and largest salary from the salaries table.
select min(salary), max(salary) from salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born.
select lower( concat( 
				substr(first_name, 1, 1), 
				substr(last_name, 1, 4), 
				'_',
				substr(birth_date,6,2),
				substr(birth_date,3,2)
				)) as username
from employees
limit 10;
