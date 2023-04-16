-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): Miguel A Salvador Tzoni
-- Description: IPPS database

DROP DATABASE ipps;

CREATE DATABASE ipps;

\c ipps

-- create tables
CREATE TABLE Providers(
    ccn INT PRIMARY KEY,
    prvdrName VARCHAR (500) NOT NULL,
);

CREATE TABLE ProviderLocations(
    prvdrCCN INT NOT NULL,
    stateFIPS INT NOT NULL,
    street VARCHAR(500),
    city VARCHAR(50),
    prvdrState VARCHAR(2),
    zip INT,
    PRIMARY KEY (prvdrCCN, stateFIPS),
    FOREIGN KEY (prvdrCCN) REFERENCES Providers(ccn)
);

CREATE TABLE RUCADescriptions(
    code INT PRIMARY KEY,
    rucaDesc VARCHAR(500)
);

CREATE TABLE CdDescriptions(
    code INT PRIMARY KEY,
    cdDesc VARCHAR(500)
);

CREATE TABLE ProviderCharges(
    dCode INT NOT NULL,
    rprvdrCCN INT NOT NULL,
    cucaCode INT NOT NULL,
    dscharges INT,
    avgCrvdChrg NUMERIC(16,10) NOT NULL,
    avgPymt NUMERIC(16,10) NOT NULL,
    avgMdcrPymt NUMERIC(16,10) NOT NULL,
    PRIMARY KEY (prvdrCCN, cdCode, rucaCode),
    FOREIGN KEY (prvdrCCN) REFERENCES Providers(ccn)
    FOREIGN KEY (cdCode) REFERENCES CdDescriptions(code)
    FOREIGN KEY (rucaCode) REFERENCES RUCADescriptions(code)
);
-- create user with appropriate access to the tables

-- queries

-- a) List all diagnosis in alphabetical order.    

-- b) List the names and correspondent states (including Washington D.C.) of all of the providers in alphabetical order (state first, provider name next, no repetition). 

-- c) List the total number of providers.

-- d) List the total number of providers per state (including Washington D.C.) in alphabetical order (also printing out the state).  

-- e) List the providers names in Denver (CO) or in Lakewood (CO) in alphabetical order  

-- f) List the number of providers per RUCA code (showing the code and description)

-- g) Show the DRG description for code 308 

-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.   

-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals. 

-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?
