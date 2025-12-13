import mysql.connector 
import os 
import subprocess 
from pathlib import Path 
from dotenv import load_dotenv
from .seeds import seed_all

load_dotenv() 

DB_NAME = os.getenv("DB_NAME", "kandypacklogistics")
SCHEMA_FILE = Path(__file__).parent /"schema.sql"


def get_server_db():
    return mysql.connector.connect(
        host = os.getenv("DB_HOST", "localhost"),
        user = os.getenv("DB_USER","root"),
        password = os.getenv("DB_PASS","")
    )


def schema_exists():
    conn = get_server_db()
    try:
        cursor = conn.cursor()
        cursor.execute(
            """
            SELECT 1
            FROM information_schema.tables
            WHERE table_schema = %s
                AND table_name = 'employee'
            LIMIT 1

""",(DB_NAME,)
        )
        return cursor.fetchone() is not None 
    finally:
        conn.close()


def run_schema_once():
    if schema_exists():
        return 
    
    subprocess.run([
        "mysql",
        f"-u{os.getenv('DB_USER','root')}",
        f"-p{os.getenv('DB_PASS','')}",
    ],
    input=SCHEMA_FILE.read_bytes(),
    check=True,
    )

    seed_all()