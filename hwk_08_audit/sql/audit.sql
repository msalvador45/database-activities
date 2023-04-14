-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: 
-- Description: SQL for the audit database

DROP DATABASE audit;

CREATE DATABASE audit;

\c audit

CREATE TABLE Employees (
    id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
); 

CREATE TABLE EmployeesAudit (
    seq SERIAL PRIMARY KEY, 
    date DATE NOT NULL, 
    descr VARCHAR(200) NOT NULL
);

-- example
CREATE FUNCTION employee_audit_after_insert() RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
        BEGIN
            INSERT INTO EmployeesAudit VALUES (seq, CURRENT_DATE, CONCAT(id, ', ', name) AS descr)
        END;
    $$;

--- CREATE FUNCTION employee_audit_after_insert() RETURNS TRIGGER
CREATE FUNCTION employee_audit_after_insert() RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
        BEGIN
            INSERT INTO EmployeesAudit(date, descr)
            VALUES(CURRENT_DATE, CONCAT(new.id,', ', new.name));
                RETURN new;
        END;
    $$;

-- CREATE TRIGGER employee_audit
CREATE TRIGGER employee_audit 
    BEFORE INSERT ON Employees 
    FOR EACH ROW 
    EXECUTE PROCEDURE employee_audit_after_insert();

-- use the following insert statements to test your trigger
INSERT INTO Employees VALUES (101, 'Samuel Adams'); 
INSERT INTO Employees VALUES (202, 'Adolph Coors');
INSERT INTO Employees VALUES (303, 'Arthur Guinness');