use albums_db;

-- explore albums db
show create table albums;
describe albums;
select * from albums;

-- the name of all albums by pink floyd
select name from albums where artist = "Pink Floyd";

-- the year sgt. peppers lonely hearts club band was released
select release_date from albums where name = "sgt. Pepper's Lonely Hearts Club Band";

-- the genre for the album nevermind
select genre from albums where name = "Nevermind";

-- albums released in the 1990s
select name, release_date from albums where release_date >= 1990 and release_date < 2000;

-- albums that had less than 20 million certified sales
select name, sales from albums where sales < 20.0;

-- all albums of the genre rock
select name from albums where genre = "Rock";

-- the query doesn't include all rock results as the string isn't an exact match