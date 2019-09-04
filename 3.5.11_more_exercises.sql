use employees;

-- how much do current managers get paid, relative to the average salary for the department
select * from employees;
select * from salaries;

-- any departments that managers get paid less than the average department

use world;
show tables;
describe city;
describe country;
describe countrylanguage;

-- which language is spoken in santa monica?
select * from country order by localname;
select * from country where name = 'Santa Monica';
select * from countrylanguage;