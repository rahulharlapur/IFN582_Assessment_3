from . import mysql
from .models import Property, User


def create_user(form):
    cur = mysql.connection.cursor()
    cur.execute("""
        INSERT INTO users (
            firstname,
            lastname,
            email,
            password,
            phone,
            role
        )
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (
        form.firstname.data,
        form.lastname.data,
        form.email.data,
        form.password.data,
        form.phone.data,
        form.role.data
    ))
    mysql.connection.commit()
    cur.close()


def check_for_user(email, password):
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT *
        FROM users
        WHERE email = %s AND password = %s
    """, (email, password))
    row = cur.fetchone()
    cur.close()
    if row:
        return User(
            row['id'],
            row['firstname'],
            row['lastname'],
            row['email'],
            row['password'],
            row['phone'],
            row['role']
        )
    return None

def user_exists(email):
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT *
        FROM users
        WHERE email = %s
    """, (email,))
    row = cur.fetchone()
    cur.close()
    return row is not None


def get_properties():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM properties ORDER BY created_at DESC")
    properties = cur.fetchall()
    cur.close()
    return [
        Property(
            row['id'],
            row['title'],
            row['property_type'],
            float(row['price']),
            row['suburb'],
            row['city'],
            row['postcode'],
            row['bedrooms'],
            row['bathrooms'],
            row['occupants'],
            row['image'],
            row['description'],
            row['created_at']
        )
        for row in properties
    ]

def search_properties(form):
    query = "SELECT * FROM properties WHERE 1=1"
    params = []

    if form.location.data:
        query += """
        AND (
            suburb LIKE %s
            OR postcode LIKE %s
            OR city LIKE %s
        )
        """

        data = form.location.data.strip()
        params.append(f"%{data}%")
        params.append(f"%{data}%")
        params.append(f"%{data}%")

    if form.property_type.data and form.property_type.data != "Any Type":
        query += " AND property_type = %s"
        params.append(form.property_type.data)

    if form.bedrooms.data and form.bedrooms.data != "Any Room":
        if form.bedrooms.data == "4+":
            query += " AND bedrooms >= %s"
            params.append(4)
        else:
            query += " AND bedrooms = %s"
            params.append(int(form.bedrooms.data))

    if form.price_range.data and form.price_range.data != "Any Price":
        if form.price_range.data == "Under $300":
            query += " AND price < 300"
        elif form.price_range.data == "$300 - $500":
            query += " AND price BETWEEN 300 AND 500"
        elif form.price_range.data == "$500 - $800":
            query += " AND price BETWEEN 500 AND 800"
        elif form.price_range.data == "$800+":
            query += " AND price > 800"

    if form.sort_by.data == "price_low":
        query += " ORDER BY price ASC"
    elif form.sort_by.data == "price_high":
        query += " ORDER BY price DESC"
    else:
        query += " ORDER BY created_at DESC"

    cur = mysql.connection.cursor()
    cur.execute(query, tuple(params))
    properties = cur.fetchall()
    cur.close()

    return [
        Property(
            row['id'],
            row['title'],
            row['property_type'],
            float(row['price']),
            row['suburb'],
            row['city'],
            row['postcode'],
            row['bedrooms'],
            row['bathrooms'],
            row['occupants'],
            row['image'],
            row['description'],
            row['created_at']
        )
        for row in properties
    ]   