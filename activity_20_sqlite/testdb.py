import sqlite3 

conn = sqlite3.connect('pls.db')
cur = conn.cursor()
sql = 'SELECT * FROM pls'
cur.execute(sql)
for row in cur.fetchall():
    print(row)
conn.close()
