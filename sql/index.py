import sqlite3
from sqlite3 import Error

conn = None
try:
    conn = sqlite3.connect("/etc/nixos/sql/_.db")
    print(sqlite3.version)
except Error as e:
    print(e)
finally:
    if conn:
        f = open("/etc/nixos/sql/index.sql", "r").readlines()
        s = "".join(f).split(";")[:-1]
        c = conn.cursor()
        for l in s:
            c.execute(l)
            conn.commit()
        conn.close()
