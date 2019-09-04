select distinct title from titles;

select distinct last_name from employees order by last_name desc limit 10;

select * from employees where hire_date between '1990-01-01' and '1999-12-31' and birth_date like '%12-25'
order by birth_date, hire_date DESC
limit 5;

select * from employees where hire_date between '1990-01-01' and '1999-12-31' and birth_date like '%12-25'
order by birth_date, hire_date DESC
limit 5 offset 45;

-- to get to the correct page of results, subtract one from the desired page number and then multiply by the limit and then use that as the offset 