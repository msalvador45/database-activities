-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: Miguel A. Salvador Tzoni
-- Description: a database of occupations

CREATE DATABASE occupations;

\c occupations

DROP TABLE IF EXISTS Occupations;

-- TODO: create table Occupations
CREATE TABLE Occupations(
    code VARCHAR(10) PRIMARY KEY,
    occupation VARCHAR(300),
    jobFamily VARCHAR(300)
);

\d Occupations

-- TODO: populate table Occupations
\copy Occupations
    (code, occupation, job) from /home/occupations.csv DELIMITER ',' CSV HEADER;

-- TODO: a) the total number of occupations (expect 1016).
SELECT COUNT(*) FROM Occupations;

-- TODO: b) a list of all job families in alphabetical order (expect 23).

-- TODO: c) the total number of job families (expect 23)

-- TODO: d) the total number of occupations per job family in alphabetical order of job family.

-- TODO: e) the number of occupations in the "Computer and Mathematical" job family (expect 38)

-- BONUS POINTS

-- TODO: f) an alphabetical list of occupations in the "Computer and Mathematical" job family.

-- TODO: g) an alphabetical list of occupations in the "Computer and Mathematical" job family that begins with the word "Database"
