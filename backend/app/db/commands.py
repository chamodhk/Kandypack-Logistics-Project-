import getpass
import datetime
from ..core.database import get_db
from ..core.security import hash_password

import getpass
import datetime

def create_superuser():
    username = input("Enter a username: ").strip()
    password = getpass.getpass("Enter a password: ")
    confirm = getpass.getpass("Enter the password (again): ")
    nic = input("Enter NIC: ").strip()
    registered_date = datetime.date.today()

    if password != confirm:
        print("Password didn't match")
        return

    hashed = hash_password(password)

    db = get_db()
    cursor = db.cursor()

    try:
        #get admin role id
        cursor.execute(
            "SELECT role_id FROM roles WHERE role_name = 'admin'"
        )
        role = cursor.fetchone()


        if not role:
            print("Admin role does not exist.")
            return
        role_id = role[0]

        # get admin store id
        cursor.execute(
            "SELECT store_id FROM store WHERE store_name = 'Admin Store'"
        )
        store = cursor.fetchone()
        if not store:
            print("Admin store does not exist.")
            return
        store_id = store[0]

        # create the super user
        cursor.execute(
            """
            INSERT INTO employee (
                employee_name,
                username,
                password_hash,
                employee_nic,
                official_contact_number,
                registrated_date,
                employee_status,
                total_hours_week,
                role_id,
                store_id
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """,
            (
                username,              # employee_name
                username,              # username
                hashed,                # password_hash
                nic,                   # employee_nic
                None,                  # official_contact_number
                registered_date,       # registrated_date
                "Active",              # employee_status
                0,                     # total_hours_week
                role_id,               # role_id
                store_id,              # store_id
            ),
        )

        db.commit()
        print("Superuser created successfully.")

    except Exception as e:
        db.rollback()
        print("Failed to create superuser:", e)

    finally:
        cursor.close()
        db.close()
