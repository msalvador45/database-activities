"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student(s): Miguel A. Salvador Tzoni
Description: A data load script for the IPPS database
"""

import psycopg2
import configparser as cp
## importing file into py script
import csv 

# logging in to user ipps
config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))

# connecting to db object
conn = psycopg2.connect(**params)
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')
    cur = conn.cursor()
    
    # prepare statemnsts for tables
    providersIn =   '''PREPARE providersInsert(int, text) AS
                    INSERT INTO Providers (Rndrng_Prvdr_CCN, Rndrng_Prvdr_Org_Name) VALUES
                    ($1, $2);
                    '''
    provider_loc_insert = '''PREPARE providerLocationsInsert(int, int, text, text, text, int) AS
                    INSERT INTO ProviderLocations (Rndrng_Prvdr_CCN, Rndrng_Prvdr_State_FIPS, Rndrng_Prvdr_St, Rndrng_Prvdr_City, Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_Zip5) VALUES
                    ($1, $2, $3, $4, $5, $6)
                    '''
    ruca_insert = '''PREPARE rucaInsert(numeric, text) AS
                    INSERT INTO RUCADescriptions (Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc) VALUES
                    ($1, $2)
                    '''
    cd_insert = '''PREPARE cdInsert(int, text) AS
                    INSERT INTO CDDescriptions (DRG_Cd, DRG_Desc) VALUES
                    ($1, $2)
                    '''
    charge_insert = '''PREPARE chargesInsert(int, int, numeric, int, numeric, numeric, numeric) AS
                    INSERT INTO Charges (Rndrng_Prvdr_CCN, DRG_Cd, Rndrng_Prvdr_RUCA, Tot_Dschrgs, Avg_Submtd_Cvrd_Chrg, Avg_Tot_Pymt_Amt, Avg_Mdcr_Pymt_Amt) VALUES
                    ($1, $2, $3, $4, $5, $6, $7)
                    '''
    
    # access csv file to get values
    with open('data/MUP_IHP_RY22_P02_V10_DY20_PrvSvc.csv', encoding='utf-8-sig') as csvfile:
        reader = csv.DictReader(csvfile)

        #loop through csv to store values into correspinging tables
        #count = 0
        for row in reader:
            cur.execute('DEALLOCATE ALL;')  #deallocates past prepared statements
            #count = count +1

            # execute prepare insert statement for providers
            cur.execute(providersIn)
            try:
                cur.execute("execute providersInsert (%s, %s)", (row['Rndrng_Prvdr_CCN'], row['Rndrng_Prvdr_Org_Name']))

            except psycopg2.IntegrityError:
                conn.rollback()
            else:
                conn.commit()
                
            # execute prepare insert statement for providers
            cur.execute(provider_loc_insert)
            try:
                cur.execute("execute providerLocationsInsert (%s, %s, %s, %s, %s, %s)", (row['Rndrng_Prvdr_CCN'], row['Rndrng_Prvdr_State_FIPS'],
                                                                                 row['Rndrng_Prvdr_St'], row['Rndrng_Prvdr_City'],
                                                                                 row['Rndrng_Prvdr_State_Abrvtn'], row['Rndrng_Prvdr_Zip5']))
            except psycopg2.IntegrityError:
                conn.rollback()
            else:
                conn.commit()
             
            # execute prepare insert statement for providers
            cur.execute(ruca_insert)
            try:
                cur.execute("execute rucaInsert (%s, %s)", (row['Rndrng_Prvdr_RUCA'], row['Rndrng_Prvdr_RUCA_Desc']))
            except psycopg2.IntegrityError:
                conn.rollback()
            else:
                conn.commit()

            # execute prepare insert statement for providers
            cur.execute(cd_insert)
            try:
                cur.execute("execute cdInsert (%s, %s)", (row['DRG_Cd'], row['DRG_Desc']))
            except psycopg2.IntegrityError:
                conn.rollback()
            else:
                conn.commit()

            # execute prepare insert statement for providers
            cur.execute(charge_insert)
            try:
                cur.execute("execute chargesInsert (%s, %s, %s, %s, %s, %s, %s)", 
                            (row['Rndrng_Prvdr_CCN'], row['DRG_Cd'], row['Rndrng_Prvdr_RUCA'],
                             row['Tot_Dschrgs'], row['Avg_Submtd_Cvrd_Chrg'], row['Avg_Tot_Pymt_Amt'], 
                             row['Avg_Mdcr_Pymt_Amt']))
            except psycopg2.IntegrityError:
                conn.rollback()
            else:
                conn.commit()
            
            #if count > 10:
                #break
    
    # disconnect from db
    print('Bye!')
    conn.close()