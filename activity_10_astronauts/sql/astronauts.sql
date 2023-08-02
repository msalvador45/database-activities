-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The astronauts database

-- make database
CREATE DATABASE activity10;
\c activity10

-- check to see if the table Astronauts exists, if it does drop
DROP TABLE Astronauts;
\d Astronauts 

-- create table Astronauts
CREATE TABLE Astronauts(
    id SERIAL PRIMARY KEY,              -- serial vs int?
    lastName VARCHAR(25) NOT NULL,      
    firstName VARCHAR(25) NOT NULL,
    suffix CHAR(10),
    gender CHAR(1) NOT NULL,            -- best way to choose number of characters?
    birth DATE NOT NULL,                -- especially if the data is very large?
    city VARCHAR(25),
    state VARCHAR(30),
    country VARCHAR(25),
    status VARCHAR(15),
    daysInSpace INT NOT NULL,           -- by default it takes NULL unless told not to
    flights INT NOT NULL                -- only specify NOT NULL when it can't be null
);

-- copy csv to docker container env NOT on psql
-- copy csv on container to table
\copy Astronauts
    (lastName, firstName, suffix, gender, birth, city, state, country, status, daysInSpace, flights)
    from  /home/astronauts.csv DELIMITER ',' CSV HEADER;

-- a) the total number of astronauts.
SELECT COUNT(*) FROM Astronauts;

-- b) the total number of American astronauts.
SELECT COUNT(*) FROM Astronauts
WHERE Country = 'USA';                          -- start WHERE condition after SELECT _ FROM _ 

-- c) the list of nationalities of all astronauts in alphabetical order.
SELECT DISTINCT country FROM Astronauts
ORDER BY 1;                                     -- need more context on how to use ORDER BY

-- d) all astronaut names ordered by last name (use the format Last Name, First Name, Suffix to display the names).
SELECT CONCAT(lastName, ',', firstName) AS total FROM Astronauts     -- concat makes a string out of params
ORDER BY 1;
                 
-- e) the total number of astronauts by gender.
SELECT gender, COUNT(*) AS total FROM Astronauts        -- gets gender columns and counts all rows
GROUP BY gender;                                        -- groups by unique gender labesl and disperses count into group

-- f) the total number of female astronauts that are still active.
SELECT COUNT(*) FROM Astronauts                     -- count all rows
WHERE gender = 'F' AND status = 'Active';           -- only where F and Active is true

-- g) the total number of American female astronauts that are still active.
SELECT COUNT(*) FROM Astronauts
WHERE gender = 'F' AND status = 'Active' AND Country = 'USA';       -- does order matter?

-- h) the list of all American female astronauts that are still active ordered by last name (use the same name format used in d).
SELECT CONCAT(lastName, ',', firstName) AS name FROM Astronauts     -- if column don't exist us AS to define one
WHERE gender = 'F' AND country = 'USA' AND status = 'Active' ORDER BY 1;

-- i) the list of Chinese astronauts, displaying only their names and ages (use the same name format used in d).
SELECT CONCAT(lastName, ',', firstName) AS name, birth, AGE(birth) AS age FROM Astronauts 
WHERE country = 'China' ORDER BY lastName;      -- AGE(col) changes to age
-- OR
SELECT CONCAT(lastName, ',', firstName) AS name, birth, date_part('year', AGE(birth)) AS age From Astronauts
WHERE country = 'China' ORDER BY lastName;      -- This simplifies age o/p by using date_part function

-- j) the total number of astronauts by country.
SELECT COUNT(*) AS total, country FROM Astronauts
GROUP BY country ORDER BY 1 DESC;            -- what does DESC do?

-- k) the total number of American astronauts per state ordered by the totals in descending order.
SELECT COUNT(*) AS total, state FROM Astronauts
WHERE country = 'USA' GROUP BY state ORDER BY 1 DESC;

-- l) the total number of astronauts by statuses (i.e., active or retired).
SELECT COUNT(*) AS total, status FROM Astronauts 
GROUP BY status;

-- m) name and age of all non-American astronauts in alphabetical order (use the same name format used in d).
SELECT CONCAT(lastName, ',', firstName) AS name, country FROM Astronauts
WHERE country <> 'USA' ORDER BY 1;          -- what does <> operator do?
-- OR
SELECT CONCAT(lastName, ',', firstName) AS name, country FROM Astronauts
WHERE country != 'USA' ORDER BY 1;          -- what does ORDER BY 1 mean? first column?

-- n) the average age of all American astronauts that are still active.
SELECT AVG(date_part('year', AGE(birth))) AS "avg age" FROM Astronauts
WHERE country = 'USA' AND status = 'Active';        -- multiple functions are being called 
