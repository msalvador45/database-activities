"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student(s): Miguel A. Salvador Tzoni
Description: A room reservation system
"""

import psycopg2
from psycopg2 import extensions, errors
import configparser as cp
from datetime import datetime
# psychopg2 lib extra tools
import psycopg2.extras

def menu(): 
    print('1. List')
    print('2. Reserve')
    print('3. Delete')
    print('4. Quit')

def db_connect():
    config = cp.RawConfigParser()
    config.read('ConfigFile.properties')
    params = dict(config.items('db'))
    conn = psycopg2.connect(**params)
    conn.autocommit = False 
    with conn.cursor() as cur: 
        cur.execute('''
            PREPARE QueryReservationExists AS 
                SELECT * FROM Reservations 
                WHERE abbr = $1 AND room = $2 AND date = $3 AND period = $4;
        ''')
        cur.execute('''
            PREPARE QueryReservationExistsByCode AS 
                SELECT * FROM Reservations 
                WHERE code = $1;
        ''')
        cur.execute('''
            PREPARE NewReservation AS 
                INSERT INTO Reservations (abbr, room, date, period) VALUES
                ($1, $2, $3, $4);
        ''')
        cur.execute('''
            PREPARE UpdateReservationUser AS 
                UPDATE Reservations SET "user" = $1
                WHERE abbr = $2 AND room = $3 AND date = $4 AND period = $5; 
        ''')
        cur.execute('''
            PREPARE DeleteReservation AS 
                DELETE FROM Reservations WHERE code = $1;
        ''')
    return conn

# TODO: display all reservations in the system using the information from ReservationsView
def list_op(conn):
    cur = conn.cursor()
    cur.execute("SELECT * FROM ReservationsView;")
    print('\nThe following reservations are listed:')
    for reservation in cur.fetchall():
        print(reservation[0],reservation[1],reservation[2],reservation[3],
              reservation[4],reservation[5],reservation[6])
    print('\n')
    return

# TODO: reserve a room on a specific date and period, also saving the user who's the reservation is for
def reserve_op(conn): 
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # ask user for date (yyyy-mm-dd), period(A), abbr(AAA), room(111)
    userDate = input("date for resrvation in yyyy-mm-dd format: ")
    userPeriod = input("period slot: ")
    userAbbr = input("building abbr: ")
    userRoom = input("building room number: ")
    
    # check for reservation if exists
    cur.execute("execute QueryReservationExists(%s, %s, %s, %s)", (userAbbr, userRoom,userDate, userPeriod))
    for rsvs in cur.fetchall():
        # check if reservation input has a match(reservation exists)
        if str(rsvs['abbr'])==userAbbr:
            pass
        else:
            break
        if str(rsvs['room'])==userRoom:
            pass 
        else:
            break
        if str(rsvs['date'])==userDate:
            pass 
        else:
            break
        if str(rsvs['period'])==userPeriod:
            pass 
        else:
            break

        # we have a match therfore the reservation exists
        print('room not available')
        return

    # no matching string therfore the reservation DNE
    print("room is available")
    try:
        conn.set_isolation_level(extensions.ISOLATION_LEVEL_SERIALIZABLE)
        cur.execute("execute NewReservation(%s, %s, %s, %s)",(userAbbr,userRoom, userDate, userPeriod))
        conn.commit()
    except:
        conn.rollback() 
        print("reservation could not be secured")
        return

    # Ask user to update reservation with name
    userName = input("User ID: ")
    cur.execute("execute UpdateReservationUser(%s,%s,%s,%s,%s)",(userName,userAbbr,userRoom,
                                                                 userDate,userPeriod))
    conn.commit()
    print("Your Rservation Was Succesful")
    return
        
# TODO: delete a reservation given its code
def delete_op(conn):
    cur= conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # Ask user for reservation code
    userRsvt = input("Enter Reservation Code: ")
    
    # Check if reservation code exists
    cur.execute("execute QueryReservationExistsByCode(%s)", (userRsvt,))
    for rsvs in cur.fetchall():
        if str(rsvs['code'])==userRsvt: 
            #reservation has matching user reservation code
            print('reservation exists')
            
        # try for exception
        try: 
            conn.set_isolation_level(extensions.ISOLATION_LEVEL_SERIALIZABLE)
            cur.execute("execute DeleteReservation(%s)", (userRsvt,))
        except:
            conn.rollback()
            print('reservation could not be deleted')
    
        # commit reservation 
        conn.commit()
        print('Reservation Was Deleted')
        return
            
    print("no reservation exists")
    return

if __name__ == "__main__":
    with db_connect() as conn: 
        op = 0
        while op != 4: 
            menu()
            op = int(input('? '))
            if op == 1: 
                list_op(conn)
            elif op == 2:
                reserve_op(conn)
            elif op == 3:
                delete_op(conn)