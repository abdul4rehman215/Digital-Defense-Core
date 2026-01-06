# 🛠️ Troubleshooting – Lab 11: SQL Injection Mitigation

---

## Issue 1: Application fails to start – "Address already in use"

### Cause:
Another instance of the Flask application is already running.

### Solution:
```bash
pkill -f vulnerable_app.py
pkill -f secure_app.py
````

---

## Issue 2: SQL Injection scanner reports no vulnerabilities on vulnerable app

### Possible Causes:

* Application is not running
* Database not initialized
* Error messages not returned in responses

### Solutions:

```bash
curl http://localhost:5000
```

* Ensure `init_db()` is executed
* Confirm debug mode is enabled

---

## Issue 3: Secure application blocks all input unexpectedly

### Cause:

Input validation regex is too restrictive.

### Solution:

* Allow safe alphanumeric characters
* Block only SQL-specific metacharacters
* Balance security with usability

---

## Issue 4: Parameterized query syntax error

### Cause:

Incorrect placeholder usage.

### Solution:

* SQLite uses `?` placeholders
* Pass parameters as tuples:

```python
(cursor.execute("SELECT * FROM users WHERE username=?", (username,)))
```

---

## Issue 5: Password authentication fails in secure app

### Cause:

Password hashing mismatch.

### Solution:

* Ensure passwords are hashed before comparison
* Verify consistent hashing algorithm usage (SHA-256)

---

## Issue 6: SQL Injection detector fails against secure app

### Expected Behavior:

This is normal. The secure application correctly blocks all SQL injection attempts.

---

## Best Practice Recommendations

* Do not expose database error messages
* Use ORM frameworks when possible
* Log authentication failures securely
* Apply least privilege to database users
* Test applications before deploymentSend **Lab 12** when ready.
