use employees;

-- 1. find all employees with the same hire date as emp_no 101010
select * from employees;

select e.first_name, e.last_name, hire_date, emp_no
from employees as e
where hire_date in 
	(select hire_date 
	from employees
	where emp_no = 101010);
	
-- 2. find all titles held by employees with first name aamod
select * from employees;
select * from titles;

select e.first_name, e.last_name, t.title
from titles as t
join employees as e
on e.emp_no = t.emp_no
where e.emp_no in
	(select emp_no 
	from employees
	where first_name = "Aamod");
	
-- 3. how many people in the employees table no longer work for the company
select * from employees;
select * from dept_emp;
select * from salaries;

-- other select criteria: e.first_name, e.last_name, e.emp_no, de.to_date
select count(*)
from employees as e
-- join dept_emp as de
-- on de.emp_no = e.emp_no
where e.emp_no not in
	(select emp_no
	from dept_emp
	where to_date = "9999-01-01");	
	
-- 4. find current managers that are female
select * from employees;
select * from dept_manager;

select first_name, last_name, dm.to_date, dm.dept_no, e.gender
from dept_manager as dm
join employees as e
on e.emp_no = dm.emp_no
where first_name in 
	(select first_name
	from employees)
	and dm.to_date = "9999-01-01" and e.gender = "f";
	
-- 5. employees that have a salary that is currently higher than average
select * from employees;
select * from salaries;

select avg(salary) as avg_sal 
from salaries
where to_date = "9999-01-01"; 

select first_name, salary
from employees as e
join salaries as s
on s.emp_no = e.emp_no
where salary >
	(select avg(salary)
	from salaries)
	and s.to_date = "9999-01-01";
	
-- 6. how many current salaries are within 1 standard deviation of highest salary and what % is this
select * from salaries;

select count(*), count(*)/(select count(*) from salaries where to_date = "9999-01-01")*100 as percent
from employees as e	
join salaries as s
on s.emp_no = e.emp_no
where salary >
	(select max(salary) - STD(salary)
	from salaries)
	and s.to_date = "9999-01-01";

-- B1. find all departments that have female managers
select * from employees;
select * from dept_manager;
select * from departments;

select first_name, last_name, dm.to_date, dm.dept_no, e.gender, d.dept_name
from dept_manager as dm
join employees as e
on e.emp_no = dm.emp_no
join departments as d
on d.dept_no = dm.dept_no

where first_name in 
	(select first_name
	from employees)
	and dm.to_date = "9999-01-01" and e.gender = "f";
	
-- B2. find the name of the person with the highest salary
select * from salaries;
select * from employees;

select first_name, last_name, s.salary
from employees as e	
join salaries as s
on s.emp_no = e.emp_no
where s.salary = (select max(salary) from salaries);

-- B3. find the department name of the person with the highest salary
select * from salaries;
select * from employees;
select * from dept_emp;

select first_name, last_name, s.salary, d.dept_name
from employees as e	
join salaries as s
on s.emp_no = e.emp_no
join dept_emp as de
on de.emp_no = e.emp_no
join departments as d
on d.dept_no = de.dept_no
where s.salary = (select max(salary) from salaries)