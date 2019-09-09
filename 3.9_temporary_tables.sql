use bayes_811;

-- 1 create temporary table from the example
create temporary table employees_with_departments as
select emp_no, first_name, last_name, dept_no, dept_name
from employees.employees
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
limit 100;

select * from employees_with_departments;

-- 1a. add column named full_name with varchar whose length is the sum of the first and last name columns
describe employees_with_departments;

alter table employees_with_departments add full_name varchar(31);

select * from employees_with_departments;

-- 1b. update table to include first and last name
update employees_with_departments
set full_name = concat(first_name, " ", last_name);

select * from employees_with_departments;

-- 1c. remove first and last name columns
alter table employees_with_departments drop column first_name;
alter table employees_with_departments drop column last_name;

select * from employees_with_departments;

-- 1d. what is another way to end up with the same table 
-- A: concat first and last when the temp table is created

-- 2. create a temp table based on payment from sakila and update amount to integer by cents
select * from sakila.payment;

create temporary table payz2 as
select * from sakila.payment;

select * from payz2;
describe payz2;

alter table payz2 modify column amount double;

update payz2 set amount = amount * 100;

alter table payz2 modify column amount int;

select * from payz2;

-- 3. compare overall salary to each deparment 	
select * from employees.salaries;
select * from employees.dept_emp;
select * from employees.departments;

create temporary table avg_salary
select avg(salary)
from employees.salaries;

select * from avg_salary;

select * from avg_salary_by_department;

create temporary table avg_salary_by_dept_diff
select dept_name, avg(salary) - (select avg(salary) from employees.salaries) as sal_diff 
from employees.salaries
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
group by dept_name;

select * from avg_salary_by_dept_diff; 

alter table avg_salary_by_dept_diff add z_score float;

select std(sal_diff) from avg_salary_by_dept_diff;
select sal_diff from avg_salary_by_dept_diff;

update avg_salary_by_dept_diff
set z_score = sal_diff / std(sal_diff);

create temporary table avg_salary_by_dept_zscore7
select dept_name, (avg(salary) - (select avg(salary) from employees.salaries where to_date="9999-01-01")) / (select std(salary) from employees.salaries where to_date="9999-01-01") as z_score 
from employees.salaries
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
where salaries.to_date="9999-01-01" and dept_emp.to_date ="9999-01-01"
group by dept_name;

select * from avg_salary_by_dept_zscore7;

