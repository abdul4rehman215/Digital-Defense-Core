#!/usr/bin/env python3
from flask import Flask, request, render_template_string
import sqlite3
import hashlib
import re

app = Flask(__name__)

def init_secure_db():
    conn = sqlite3.connect('secure_users.db')
    cursor = conn.cursor()

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password_hash TEXT,
        email TEXT
    )
    """)

    cursor.execute("DELETE FROM users")

    users = [
        ('admin', 'admin123', 'admin@test.com'),
        ('john', 'pass123', 'john@test.com')
    ]

    for u in users:
        pwd_hash = hashlib.sha256(u[1].encode()).hexdigest()
        cursor.execute(
            "INSERT INTO users (username, password_hash, email) VALUES (?, ?, ?)",
            (u[0], pwd_hash, u[2])
        )

    conn.commit()
    conn.close()

def validate_input(value):
    if not value or len(value) > 50:
        return False
    if re.search(r"[;'\"--]", value):
        return False
    return True

@app.route('/')
def home():
    return render_template_string("""
    <h2>Secure Login</h2>
    <form method="POST" action="/login">
    Username: <input name="username"><br>
    Password: <input type="password" name="password"><br>
    <input type="submit">
    </form>
    <hr>
    <form method="GET" action="/search">
    Search: <input name="query">
    <input type="submit">
    </form>
    """)

@app.route('/login', methods=['POST'])
def secure_login():
    username = request.form.get('username', '')
    password = request.form.get('password', '')

    if not validate_input(username):
        return "Invalid input"

    pwd_hash = hashlib.sha256(password.encode()).hexdigest()

    conn = sqlite3.connect('secure_users.db')
    cursor = conn.cursor()
    cursor.execute(
        "SELECT username FROM users WHERE username=? AND password_hash=?",
        (username, pwd_hash)
    )
    result = cursor.fetchone()
    conn.close()

    return "Login successful" if result else "Login failed"

@app.route('/search')
def secure_search():
    q = request.args.get('query', '')
    if not validate_input(q):
        return "Invalid search input"

    conn = sqlite3.connect('secure_users.db')
    cursor = conn.cursor()
    cursor.execute(
        "SELECT username,email FROM users WHERE username LIKE ?",
        (f"%{q}%",)
    )
    results = cursor.fetchall()
    conn.close()

    return str(results)

if __name__ == '__main__':
    init_secure_db()
    app.run(host='0.0.0.0', port=5001, debug=False)
