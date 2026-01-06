#!/usr/bin/env python3
from flask import Flask, request, render_template_string
import sqlite3

app = Flask(__name__)

def init_db():
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        email TEXT
    )
    """)

    cursor.execute("DELETE FROM users")

    users = [
        ('admin', 'admin123', 'admin@test.com'),
        ('john', 'pass123', 'john@test.com'),
        ('jane', 'secret456', 'jane@test.com')
    ]

    cursor.executemany(
        "INSERT INTO users (username, password, email) VALUES (?, ?, ?)",
        users
    )

    conn.commit()
    conn.close()

@app.route('/')
def home():
    return render_template_string("""
    <html><body>
    <h2>Vulnerable Login System</h2>
    <form method="POST" action="/login">
    Username: <input type="text" name="username"><br>
    Password: <input type="password" name="password"><br>
    <input type="submit" value="Login">
    </form>
    <hr>
    <h3>Search Users</h3>
    <form method="GET" action="/search">
    Search: <input type="text" name="query">
    <input type="submit" value="Search">
    </form>
    </body></html>
    """)

@app.route('/login', methods=['POST'])
def vulnerable_login():
    username = request.form['username']
    password = request.form['password']

    query = f"SELECT * FROM users WHERE username = '{username}' AND password = '{password}'"

    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    try:
        cursor.execute(query)
        result = cursor.fetchone()
    except Exception as e:
        result = None
        error = str(e)
    conn.close()

    if result:
        return f"Login successful!<br>Executed Query:<br>{query}"
    return f"Login failed!<br>Executed Query:<br>{query}"

@app.route('/search')
def vulnerable_search():
    query_param = request.args.get('query', '')
    query = f"SELECT username, email FROM users WHERE username LIKE '%{query_param}%'"

    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    conn.close()

    return f"Executed Query:<br>{query}<br><br>Results:<br>{results}"

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5000, debug=True)
