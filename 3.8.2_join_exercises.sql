use bayes_811;

-- select all records
select * from roles;
select * from users;

-- use inner, left, and right join on tables
select users.name as user_name, roles.name as roles_name
from users
join roles on users.role_id = roles.id;

select users.*, roles.*
from users
join roles on users.role_id = roles.id;

select users.name as user_name, roles.name as role_names
from users
left join roles on users.role_id = roles.id;

select users.name as user_name, roles.name as role_names
from users
right join roles on users.role_id = roles.id;

-- use count to get the number of users and and appropriate join
select roles.name as role_names, count(*)
from roles
left join users on users.role_id = roles.id
group by role_names;

-- use employee db
use employees;

-- show each department and current manager
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;

select * from employees;
select * from departments;
select * from dept_manager;

select d.dept_name as department_name, concat(e.first_name, " ", e.last_name) as manager_name
from employees as e
join dept_manager as dm
on e.emp_no = dm.emp_no 
join departments as d
on d.dept_no = dm.dept_no
where dm.to_date = "9999-01-01"
order by department_name asc;

-- find all departments currently managed by women
select d.dept_name as department_name, concat(e.first_name, " ", e.last_name) as manager_name
from employees as e
join dept_manager as dm
on e.emp_no = dm.emp_no 
join departments as d
on d.dept_no = dm.dept_no
where dm.to_date = "9999-01-01" and e.gender = "F"
order by department_name asc;

-- find current titles of peeps currently working in customer service
select * from employees;
select * from dept_emp;
select * from departments;
select * from titles;

select t.title as emp_title, count(*)
from employees as e
join dept_emp as de
on de.emp_no = e.emp_no
join titles as t
on t.emp_no = e.emp_no
join departments as d
on d.dept_no = de.dept_no
where t.to_date = "9999-01-01" and d.dept_no = "d009"
group by emp_title;


-- find current salary of current managers
select * from salaries;

select d.dept_name as department_name, concat(e.first_name, " ", e.last_name) as full_name, s.salary
from employees as e
join dept_manager as dm
on e.emp_no = dm.emp_no 
join departments as d
on d.dept_no = dm.dept_no
join salaries as s
on s.emp_no = e.emp_no
where dm.to_date = "9999-01-01" and s.to_date = "9999-01-01"
order by department_name asc;

-- find the number of employees in each department
select * from employees;
select * from dept_emp;
select * from departments;

select d.dept_no, d.dept_name as department_name, count(*)
from employees as e 
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
where de.to_date = "9999-01-01"
group by d.dept_no;

-- which department has the highest average salary
select * from salaries;
select * from employees;
select * from dept_emp;
select * from departments;

select d.dept_name as department_name, avg(s.salary) as avg_sal
from employees as e 
join salaries as s
on s.emp_no = e.emp_no
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no	
where de.to_date = "9999-01-01" and s.to_date = "9999-01-01"
group by department_name asc
order by avg_sal desc
limit 1;

-- highest paid employee in marketing
select * from employees;
select * from salaries;
select * from dept_emp;
select * from departments;

select d.dept_name, s.salary, concat(e.first_name, " ", last_name)
from employees as e
join salaries as s
on e.emp_no = s.emp_no
join dept_emp as de
on de.emp_no = e.emp_no
join departments as d
on de.dept_no = d.dept_no
where de.to_date = "9999-01-01" and s.to_date = "9999-01-01" and d.dept_name = "marketing"
order by s.salary desc
limit 1;

-- current manager with the highest salary
select * from employees;
select * from salaries;
select * from dept_manager;
select * from departments;

select d.dept_name, max(s.salary) as max_sal, concat(e.first_name, " ", e.last_name) as full_name
from employees as e
join salaries as s
on e.emp_no = s.emp_no
join dept_manager as dm
on dm.emp_no = e.emp_no
join departments as d
on dm.dept_no = d.dept_no
where dm.to_date = "9999-01-01" and s.to_date = "9999-01-01"
group by dm.dept_no, full_name
order by max_sal desc
limit 1;

-- find the names of all current employees, their department, and current manager
select * from employees;
select * from dept_emp;
select * from departments;
select * from dept_manager;

select concat(e.first_name, " ", e.last_name) as emp_full_name, d.dept_name, dme.mana_full_name
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
join dept_manager as dm
on dm.dept_no = d.dept_no
join (
	select concat(e.first_name, " ", e.last_name) as mana_full_name, dm.dept_no
	from employees as e
	join dept_manager as dm 
	on e.emp_no = dm.emp_no
	where dm.to_date = "9999-01-01"
	) as dme 
	on dme.dept_no = d.dept_no
where dm.to_date = "9999-01-01" and de.to_date = "9999-01-01"
order by d.dept_name;

-- highest paid employee in each department
select * from employees;
select * from salaries;
select * from dept_emp;
select * from departments;

select d.dept_name, max(s.salary) as max_sal, fn.full_name
from employees as e
join salaries as s
on e.emp_no = s.emp_no
join dept_emp as de
on de.emp_no = e.emp_no
join departments as d
on de.dept_no = d.dept_no
join (
	select concat(e.first_name, " ", e.last_name) as full_name, e.emp_no, d.dept_name  
	from employees as e
	join dept_emp as de
	on de.emp_no = e.emp_no
	join departments as d
	on d.dept_no = de.dept_no
	where de.to_date = "9999-01-01"
	) as fn
	on fn.emp_no = s.emp_no
where de.to_date = "9999-01-01" and s.to_date = "9999-01-01"
group by d.dept_name;
