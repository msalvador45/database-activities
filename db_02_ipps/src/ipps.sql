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
    PRIMARY KEY (prvdrCCN, stateFIPS),
    FOREIGN KEY (prvdrCCN) REFERENCES Providers(ccn)
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
    PRIMARY KEY (prvdrCCN, cdCode, rucaCode),
    FOREIGN KEY (prvdrCCN) REFERENCES Providers(ccn),
    FOREIGN KEY (cdCode) REFERENCES CDDescriptions(code),
    FOREIGN KEY (rucaCode) REFERENCES RUCADescriptions(code)
);

-- create user with appropriate access to the tables
CREATE USER "ipps" PASSWORD '024680';

\du --check for user

GRANT ALL ON TABLE Providers, ProviderLocations, RUCADescriptions, CDDescriptions, Charges TO "ipps";

-- queries

-- a) List all diagnosis in alphabetical order.    
SELECT cdDesc FROM CDDescriptions
ORDER BY cdDesc

-- b) List the names and correspondent states (including Washington D.C.) of all of the providers in alphabetical order (state first, provider name next, no repetition). 

-- c) List the total number of providers.

-- d) List the total number of providers per state (including Washington D.C.) in alphabetical order (also printing out the state).  

-- e) List the providers names in Denver (CO) or in Lakewood (CO) in alphabetical order  

-- f) List the number of providers per RUCA code (showing the code and description)

-- g) Show the DRG description for code 308 

-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.   

-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals. 

-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?
