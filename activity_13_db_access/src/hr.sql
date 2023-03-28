-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The hr database

CREATE DATABASE hr;

\c hr

CREATE TABLE Employees (
 id INT NOT NULL PRIMARY KEY,
 name VARCHAR(35) NOT NULL,
 sal INT ); 

INSERT INTO Employees VALUES
 ( 1, 'Sam Mai Tai', 35000 ),
 ( 2, 'Morbid Mojito', 65350 );