use employees;

select * from employees where first_name in ("Irena", "Vidya", "Maya") order by first_name;
select * from employees where first_name in ("Irena", "Vidya", "Maya") order by first_name, last_name;
select * from employees where first_name in ("Irena", "Vidya", "Maya") order by last_name, first_name;

select * from employees where last_name like 'E%' order by emp_no;

describe employees;
select * from employees where hire_date between '1990-01-01' and '1999-12-31';
select * from employees where birth_date like '%12-25';
select * from employees where last_name like '%q%';
select * from employees where (first_name="Irena" or first_name="Vidya"or first_name="Maya") and gender = 'M';

select * from employees where last_name like 'E%' or last_name like '%E' order by emp_no DESC;
select * from employees where last_name like 'E%E' order by emp_no DESC;

select * from employees where hire_date between '1990-01-01' and '1999-12-31' and birth_date like '%12-25'
order by birth_date, hire_date DESC;

select * from employees where last_name like '%q%' and last_name not like '%qu%';