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
SELECT DISTINCT jobFamily FROM Occupations
ORDER BY 1;

-- TODO: c) the total number of job families (expect 23)
SELECT COUNT(DISTINCT jobFamily) AS total FROM Occupations;

-- TODO: d) the total number of occupations per job family in alphabetical order of job family.
SELECT jobFamily, COUNT(*) AS numberOfOccupations FROM Occupations
GROUP BY jobFamily ORDER BY 1;

-- TODO: e) the number of occupations in the "Computer and Mathematical" job family (expect 38)
SELECT jobFamily, COUNT(*) AS total FROM Occupations
WHERE jobFamily = 'Computer and Mathematical' GROUP BY 1;

-- BONUS POINTS

-- TODO: f) an alphabetical list of occupations in the "Computer and Mathematical" job family.
SELECT occupation FROM Occupations
WHERE jobFamily = 'Computer and Mathematical' ORDER BY 1;

-- TODO: g) an alphabetical list of occupations in the "Computer and Mathematical" job family that begins with the word "Database"
SELECT occupation FROM Occupations
WHERE jobFamily = 'Computer and Mathematical' 
AND occupation LIKE 'Database%'
ORDER BY 1;
