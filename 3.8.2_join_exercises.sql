use bayes_811;

-- select all records
select * from roles;
select * from users;

-- use inner, left, and right join on tables
select users.name as user_name, roles.name as roles_name
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

select d.dept_name as department_name, concat(e.first_name, " ", e.last_name) as full_name
from employees as e
join dept_manager as dm
on e.emp_no = dm.emp_no 
join departments as d
on d.dept_no = dm.dept_no
where dm.to_date = "9999-01-01"
order by department_name asc;

-- find all departments currently managed by women
select d.dept_name as department_name, concat(e.first_name, " ", e.last_name) as full_name
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
