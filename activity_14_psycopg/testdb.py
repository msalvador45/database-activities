import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))

conn = psycopg2.connect(**params)
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    # TODO: ask the user for a hotel's name and then using prepared staement 
    # show the information about the hotel
    name = input("? ")
    cur = conn.curosr()
    sql = "SELECT * FROM hotels WHERE name = '%s'"  #%s is a string look up more about this

    
    
    print('Bye!')
    conn.close()