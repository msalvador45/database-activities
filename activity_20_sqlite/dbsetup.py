import sqlite3 

conn = sqlite3.connect('pls.db')    #what is pls.db
with open('pls.sql') as f:
    conn.executescript(f.read())
conn.commit()
print('done!')
