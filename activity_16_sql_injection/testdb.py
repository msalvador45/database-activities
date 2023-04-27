import psycopg2
import configparser as cp

# connecting to db on postgres
config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))
conn = psycopg2.connect(**params)
conn.autocommit = True

# execute commands
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    #prepare statement
    id = input('id? ')
    sql = '''
        prepare statement as
        SELECT * FROM Grades
        WHERE id = $1;  
    ''' # the $1 = first argument
    #execute statment by using cur
    cur = conn.cursor() 
    cur.execute(sql) 
    cur.execute("execute statement (%s)", (id)) #what is this doing?
    #print results
    for row in cur:
        print(row)
    
    print('Bye!')
    conn.close()