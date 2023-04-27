import psycopg2
import configparser as cp 

config = cp.RawConfigParser()
config.read('configFile.properties')
params = dict(config.items('db'))

conn = psycopg2.connect(**params)
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    # TODO: ask the user for a hotel's name and then using prepared statement 
    # show the information about the hotel
    name = input("? ")
    cur = conn.cursor()
    sql = "SELECT * FROM hotels WHERE name = '%s'"
    cur.execute(sql % (name))
    for row in cur:
        print(row)  


    print('Bye!')
    conn.close()