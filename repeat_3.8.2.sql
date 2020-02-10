-- Use the join_example_db. Select all the records from both the users and roles tables.
use join_example_db;

select * from roles;
select * from users;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
select * 
from roles as r
join users as u
on (u.role_id = r.id);

select * 
from roles as r
left join users as u
on (u.role_id = r.id);

select * 
from roles as r
right join users as u
on (u.role_id = r.id);

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
select r.name, count(*)
from roles as r
join users as u 
on (u.role_id = r.id)
group by r.name;

-- Use the employees database.
use employees;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
select * from departments;
select * from dept_manager;

select dept_name, concat(first_name, ' ', last_name) as department_manager 
from employees
join dept_manager using (emp_no)
join departments using (dept_no)
where to_date = '9999-01-01'
order by dept_name;

-- Find the name of all departments currently managed by women.
select dept_name, concat(first_name, ' ', last_name) as department_manager 
from employees
join dept_manager using (emp_no)
join departments using (dept_no)
where to_date = '9999-01-01' and gender = 'F'
order by dept_name;

-- Find the current titles of employees currently working in the Customer Service department.
select * from titles;

select title, count(*) from employees as e
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
join titles as t using (emp_no)
where dept_name = 'Customer Service' and de.to_date = '9999-01-01' and t.to_date = '9999-01-01'
group by title;

-- Find the current salary of all current managers.
select dept_name, concat(first_name, ' ', last_name) as manager, salary from employees as e
join dept_manager as dm using (emp_no)
join salaries as s using (emp_no)
join departments as d using (dept_no)
where dm.to_date = '9999-01-01' and s.to_date = '9999-01-01'
order by dept_name;

-- Find the number of employees in each department.
select dept_no, dept_name, count(*) from employees
join dept_emp using (emp_no)
join departments using (dept_no)
where to_date = '9999-01-01'
group by dept_name
order by dept_no;

-- Which department has the highest average salary?
select dept_name, avg(salary) from employees as e
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
join salaries as s using (emp_no)
where de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
group by dept_name
order by avg(salary) desc
limit 1;

-- Who is the highest paid employee in the Marketing department?
select concat(first_name, ' ', last_name) as name, salary from employees as e
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
join salaries as s using (emp_no)
where de.to_date = '9999-01-01' and s.to_date = "9999-01-01" and dept_name = "Marketing"
order by salary desc
limit 1;

-- Which current department manager has the highest salary?
select dept_name, concat(first_name, ' ', last_name) as name, salary from employees as e
join dept_manager as dm using (emp_no)
join departments as d using (dept_no)
join salaries as s using (emp_no)
where dm.to_date = '9999-01-01' and s.to_date = "9999-01-01"
order by salary desc
limit 1;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.


-- Bonus Find the highest paid employee in each department.
