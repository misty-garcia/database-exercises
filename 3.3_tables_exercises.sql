use employees;

-- show tables in currently selected db
show tables;

-- exploring the employees db
show create table employees;
describe employees; 	

-- 6. numeric type: emp_no
-- 7. string type: first_name, last_name 
-- 8. date type: birth_date, hire_date

-- explore the departments db
show create table departments;
describe departments;

-- 9. employees table holds employee num and departments table holds department number, and dept_emp shows which employee is in which department

-- explore the dept_manager db
show create table dept_manager;
describe dept_manager;

-- explore dept_emp db
show create table dept_emp;
describe dept_emp;