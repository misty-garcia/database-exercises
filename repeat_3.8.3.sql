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
select count(*), 
		count(*)/(select count(*) 
					from salaries 
					where to_date = '9999-01-01'
					)*100
from salaries
where salary >  
	(
	select max(salary) - stddev(salary)
	from salaries
	) and to_date = '9999-01-01';	
	
-- bonus. Find all the department names that currently have female managers.
select * from employees
join dept_manager using (emp_no)
join departments using (dept_no)
where to_date = '9999-01-01' and gender ='F';

-- bonus. Find the first and last name of the employee with the highest salary.
select * from employees;

-- bonus. Find the department name that the employee with the highest salary works in.
