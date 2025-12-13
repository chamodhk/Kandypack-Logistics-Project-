from ..core.database import get_db 


def seed_roles(cur):
    roles = [
        ("admin", 0),
        ("store_manager", 40),
        ("driver", 40),
        ("assistant", 60),
    ]


    for role_name, max_hours in roles:
        cur.execute(
            """
            INSERT INTO roles (role_name, max_hours_week)
            VALUES (%s, %s)
            """, (role_name, max_hours)
        )


def seed_admin_store(cur):
    # add an admin city
    cur.execute(
        """
        INSERT INTO city (city_name) VALUES ("admin")
        """
    )
    cur.execute(
        """
        INSERT INTO store (store_name, contact_number, city_id) 
        VALUES ("admin store", "0000000000", (SELECT city_id from city WHERE city_name="admin"))
        """
    )


def seed_all():
    db = get_db()
    cur = db.cursor() 


    try:
        seed_roles(cur) 
        seed_admin_store(cur)
        db.commit() 
        print("Base reference data seeded.")
    finally:
        cur.close()
        db.close()