use employees;

-- Find all the employees with the same hire date as employee 101010 using a sub-query. 69 Rows
select * from employees
where hire_date in 
	(
	select hire_date
	from employees
	where emp_no = '101010' 
	);
	
-- Find all the titles held by all employees with the first name Aamod. 314 total titles, 6 unique titles
select count(*), sum(t_count) from 
	(select title, count(*) as t_count from employees
		join titles using (emp_no)
		where first_name in 
			(
			select first_name from employees
			where first_name = 'Aamod'
			)
	group by title
	) as a;

-- How many people in the employees table are no longer working for the company?
select * from employees
where emp_no not in 
	(
	select emp_no 
	from dept_emp
	where to_date = '9999-01-01'
	);

-- Find all the current department managers that are female.
select * from dept_manager;

select first_name, last_name, gender from employees
where emp_no in 
	(
	select emp_no
	from dept_manager
	where to_date = '9999-01-01'
	) and gender = 'F';
	
-- Find all the employees that currently have a higher than average salary.
select * from salaries;

select first_name, last_name, salary from employees
join salaries using (emp_no)
where salary >  
	(
	select avg(salary)
	from salaries
-- 	where to_date = '9999-01-01'
	) and to_date = '9999-01-01';


-- How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
select count(*) 
from employees
join salaries using (emp_no)
where salary >  
	(
	select stddev(salary)
	from salaries
	where to_date = '9999-01-01'
	) and to_date = '9999-01-01';

select stddev(salary)
from salaries
where to_date = '9999-01-01';