use sakila;
select * from actor;
select last_name, first_name from actor;
select * from actor where last_name = 'Cage'
select last_name as last, first_name as first from actor;
select * from actor where actor_id = 2;
select * from actor where last_update = "2006-02-15 04:34:33";
select 'i am output!' as info;