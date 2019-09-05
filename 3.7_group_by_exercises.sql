use employees;

-- find unique titles
select distinct title from titles;

-- find unique last names that start and end with E
select last_name from employees
where last_name like 'e%e'
group by last_name;

-- find unique combinations of first and last names where last names that start and end with E
select concat(first_name, " ", last_name) as full_name from employees
where last_name like 'e%e'
group by full_name;

-- find unique last names with 'q', but not 'qu'
select last_name from employees
where last_name like '%q%' and last_name not like '%qu%'
group by last_name;

-- add count and use order by to find most unusual name shared with others
select last_name, count(last_name) from employees
where last_name like '%q%' and last_name not like '%qu%'
group by last_name
order by count(last_name) desc;

-- update query for irena, vidya, or maya. use count and order by to find the number of each gender
select count(first_name), gender from employees
where first_name in ('irena', 'vidya', 'maya')
group by gender
order by count(last_name) desc;

-- find duplicates from generated usernames
select * from employees;

select * from employees;
select lower(concat(substr(first_name,1,1), substr(last_name, 1,4), "_", substr(birth_date,6,2), substr(birth_date,3,2))) as username,
	first_name,
	last_name,
	birth_date 
from employees;

select lower(concat(substr(first_name,1,1), substr(last_name, 1,4), "_", substr(birth_date,6,2), substr(birth_date,3,2))) as username, count(*)
from employees
group by username
order by count(username) desc; 

-- bonus: how many duplicates?
select count(*) from
(select lower(concat(substr(first_name,1,1), substr(last_name, 1,4), "_", substr(birth_date,6,2), substr(birth_date,3,2))) as username, count(*) as username_count
from employees
group by username having username_count>1) as total_count;

