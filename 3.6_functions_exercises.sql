use employees;

-- employees whose last name starts and end with E, combine first and last name into fullname
select concat(first_name, " ", last_name) as fullname from employees where last_name like "E%E";

-- make the previous entires all uppercase
select upper(concat(first_name, " ", last_name)) as fullname from employees where last_name like "E%E";

-- for christmas babies born in the 90s, how many days have they worked at the company
select * from employees;
select datediff(now(), hire_date) from employees where hire_date between '1990-01-01' and '1999-12-31' and birth_date like '%12-25';

-- find smallest and largest salary
select min(salary) from salaries;
select max(salary) from salaries;

-- create username: all lowercase, first character of first name, first four characters of last name, underscore, birth month, two digit birth year
select * from employees;
select lower(concat(substr(first_name,1,1), substr(last_name, 1,4), "_", substr(birth_date,6,2), substr(birth_date,3,2))) from employees; 