-- fix the db

-- fix Providers
ALTER TABLE Providers
RENAME 'old_name' TO Rndrng_Prvdr_CCN
RENAME 'old_name' TO Rndrng_Prvdr_Org_Name;

-- fix ProviderLocations
ALTER TABLE ProviderLocations
RENAME COLUMN prvdrCCN TO Rndrng_Prvdr_CCN;
ALTER TABLE ProviderLocations
RENAME COLUMN stateFIPS TO Rndrng_Prvdr_State_FIPS;
ALTER TABLE ProviderLocations
RENAME COLUMN street TO Rndrng_Prvdr_St;
ALTER TABLE ProviderLocations
RENAME COLUMN city TO Rndrng_Prvdr_City;
ALTER TABLE ProviderLocations
RENAME COLUMN prvdrState TO Rndrng_Prvdr_State_Abrvtn;
ALTER TABLE ProviderLocations
RENAME COLUMN zip TO Rndrng_Prvdr_Zip5;

-- fix RUCA_descriptions
ALTER TABLE RUCAdescriptions
RENAME COLUMN code TO Rndrng_Prvdr_RUCA;
ALTER TABLE RUCAdescriptions
RENAME COLUMN rucaDesc TO Rndrng_Prvdr_RUCA_Desc;

-- fix CdDescriptions
ALTER TABLE CdDescriptions
RENAME COLUMN code TO DRG_Cd;
ALTER TABLE CdDescriptions
RENAME COLUMN cdDesc TO DRG_Desc;

-- fix ProviderCharges
ALTER TABLE Charges
RENAME COLUMN prvdrCCN TO Rndrng_Prvdr_CCN;
ALTER TABLE Charges
RENAME COLUMN cdCode TO DRG_Cd;
ALTER TABLE Charges
RENAME COLUMN rucaCode TO Rndrng_Prvdr_RUCA;
ALTER TABLE Charges
RENAME COLUMN dscharges TO Tot_Dschrgs;
ALTER TABLE Charges
RENAME COLUMN avgCrvdChrg TO Avg_Submtd_Cvrd_Chrg;
ALTER TABLE Charges
RENAME COLUMN avgPymt TO Avg_Tot_Pymt_Amt;
ALTER TABLE Charges
RENAME COLUMN avgMdcrPymt TO Avg_Mdcr_Pymt_Amt;
