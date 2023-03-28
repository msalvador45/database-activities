import psycopg2

params = {
    'host': 'localhost', 
    'port': 5432, 
    'dbname': 'hr', 
    'user': 'hr_admin',
    'password': '135791'
}

conn = psycopg2.connect(**params)
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    cur = conn.cursor()
    sql = 'SELECT id, name FROM employees'
    cur.execute(sql)
    for row in cur.fetchall():
        print(row)

    print('Bye!')
    conn.close()