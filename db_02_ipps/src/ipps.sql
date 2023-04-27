-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): Miguel A Salvador Tzoni
-- Description: IPPS database

DROP DATABASE ipps;

CREATE DATABASE ipps;

\c ipps

-- create tables
CREATE TABLE Providers(
    Rndrng_Prvdr_CCN INT PRIMARY KEY,
    Rndrng_Prvdr_Org_Name VARCHAR (500) NOT NULL
);

CREATE TABLE ProviderLocations(
    Rndrng_Prvdr_CCN INT NOT NULL,
    Rndrng_Prvdr_State_FIPS INT NOT NULL,
    Rndrng_Prvdr_St VARCHAR(500),
    Rndrng_Prvdr_City VARCHAR(50),
    Rndrng_Prvdr_State_Abrvtn VARCHAR(2),
    Rndrng_Prvdr_Zip5 INT,
    PRIMARY KEY (Rndrng_Prvdr_CCN, Rndrng_Prvdr_State_FIPS),
    FOREIGN KEY (Rndrng_Prvdr_CCN) REFERENCES Providers(Rndrng_Prvdr_CCN)
);

CREATE TABLE RUCADescriptions(
    Rndrng_Prvdr_RUCA NUMERIC(10,2) PRIMARY KEY,
    Rndrng_Prvdr_RUCA_Desc VARCHAR(500) NOT NULL
);

CREATE TABLE CDDescriptions(
    DRG_Cd INT PRIMARY KEY,
    DRG_Desc VARCHAR(500) NOT NULL
);

CREATE TABLE Charges(
    Rndrng_Prvdr_CCN INT NOT NULL,
    DRG_Cd INT NOT NULL,
    Rndrng_Prvdr_RUCA NUMERIC(10,2) NOT NULL,
    Tot_Dschrgs INT,
    Avg_Submtd_Cvrd_Chrg NUMERIC,
    Avg_Tot_Pymt_Amt NUMERIC,
    Avg_Mdcr_Pymt_Amt NUMERIC,
    PRIMARY KEY (Rndrng_Prvdr_CCN, DRG_Cd, Rndrng_Prvdr_RUCA),
    FOREIGN KEY (Rndrng_Prvdr_CCN) REFERENCES Providers(Rndrng_Prvdr_CCN),
    FOREIGN KEY (DRG_Cd) REFERENCES CDDescriptions(DRG_Cd),
    FOREIGN KEY (Rndrng_Prvdr_RUCA) REFERENCES RUCADescriptions(Rndrng_Prvdr_RUCA)
);

-- create user with appropriate access to the tables
CREATE USER "ipps" PASSWORD '024680';

\du --check for user

GRANT ALL ON TABLE Providers, ProviderLocations, RUCADescriptions, CDDescriptions, Charges TO "ipps";

-- queries

-- a) List all diagnosis in alphabetical order.    
SELECT DRG_Cd, DRG_Desc AS diagnosis FROM CDDescriptions
ORDER BY DRG_Desc;

-- b) List the names and correspondent states (including Washington D.C.) of all of the providers in alphabetical order (state first, provider name next, no repetition). 
SELECT DISTINCT Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_Org_Name FROM ProviderLocations A 
LEFT JOIN Providers B 
ON A.Rndrng_Prvdr_CCN = B.Rndrng_Prvdr_CCN;

-- c) List the total number of providers.
SELECT COUNT(*) AS total_number_providers FROM Providers;

-- d) List the total number of providers per state (including Washington D.C.) in alphabetical order (also printing out the state).  
SELECT Rndrng_Prvdr_State_Abrvtn, COUNT(Rndrng_Prvdr_CCN) AS total_number_providers FROM ProviderLocations 
GROUP BY Rndrng_Prvdr_State_Abrvtn
ORDER BY 1;

-- e) List the providers names in Denver (CO) or in Lakewood (CO) in alphabetical order  
SELECT Rndrng_Prvdr_City, Rndrng_Prvdr_Org_Name AS provider FROM ProviderLocations A 
INNER JOIN Providers B 
ON A.Rndrng_Prvdr_CCN = B.Rndrng_Prvdr_CCN
WHERE Rndrng_Prvdr_State_Abrvtn = 'CO' AND Rndrng_Prvdr_City = 'Denver' OR Rndrng_Prvdr_City = 'Lakewood'
GROUP BY Rndrng_Prvdr_City, Rndrng_Prvdr_Org_Name
ORDER BY 1;

-- f) List the number of providers per RUCA code (showing the code and description)
SELECT A.Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc, COUNT(Rndrng_Prvdr_Org_Name) AS total_providers FROM RUCADescriptions A 
INNER JOIN Charges B
ON A.Rndrng_Prvdr_RUCA = B.Rndrng_Prvdr_RUCA
INNER JOIN Providers C 
ON B.Rndrng_Prvdr_CCN = C.Rndrng_Prvdr_CCN
GROUP BY A.Rndrng_Prvdr_RUCA;

-- g) Show the DRG description for code 308 
SELECT DRG_Cd, DRG_Desc FROM CDDescriptions
WHERE DRG_CD = 308;

-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.   
SELECT Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_Org_Name, Avg_Submtd_Cvrd_Chrg, DRG_Cd FROM Charges
NATURAL JOIN ProviderLocations
NATURAL JOIN Providers
WHERE DRG_Cd = 308
ORDER BY Avg_Submtd_Cvrd_Chrg DESC
LIMIT 10;

-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals. 
SELECT Rndrng_Prvdr_State_Abrvtn, AVG(Avg_Submtd_Cvrd_Chrg)::numeric(20,2) AS Avg_Cvrd_Chrg FROM CHARGES 
NATURAL JOIN ProviderLocations
NATURAL JOIN CDDescriptions
WHERE DRG_Cd = 308
GROUP BY Rndrng_Prvdr_State_Abrvtn 
ORDER BY Avg_Cvrd_Chrg;


-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?
