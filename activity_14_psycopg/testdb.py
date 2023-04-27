import psycopg2
import configparser as cp 

config = cp.RawConfigParser() #object out of cp 
config.read('ConfigFile.properties') #obj reads in file w/ function
params = dict(config.items('db')) #store parameters in params 

# connect to psycopg2
conn = psycopg2.connect(**params)

# test connection
if conn:
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    
    
    print('Bye!') # after done executing commands 
    conn.close() #close connection