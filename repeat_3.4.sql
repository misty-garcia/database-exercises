-- Use the albums_db database.
use albums_db;

-- Explore the structure of the albums table.
describe albums;

-- Write queries to find the following information.
-- The name of all albums by Pink Floyd
select * from albums
where artist = 'Pink Floyd';

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
select release_date from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band";

-- The genre for the album Nevermind
select genre from albums
where name = 'Nevermind';

-- Which albums were released in the 1990s
select * from albums
where release_date between 1990 and 1999;

-- Which albums had less than 20 million certified sales
select * from albums
where sales < 20;

-- All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? *\/
select * from albums
where genre like "%Rock%";
