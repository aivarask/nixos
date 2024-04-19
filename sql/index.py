import os
import sqlite3
from sqlite3 import Error
from dotenv import load_dotenv


def loadEnv():
    load_dotenv("/etc/nixos/sql/.env")


loadEnv()
db_path = os.environ.get("DB_PATH")
sql_init = os.environ.get("SQL_INIT")

if db_path and sql_init:
    conn = None
    try:
        conn = sqlite3.connect(db_path)
        print(sqlite3.version)
    except Error as e:
        print(e)
    finally:
        if conn:
            f = open(sql_init, "r").readlines()
            s = "".join(f).split(";")[:-1]
            c = conn.cursor()
            for l in s:
                c.execute(l)
                conn.commit()
            conn.close()
