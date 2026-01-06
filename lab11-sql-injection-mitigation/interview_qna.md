# 📘 Interview Q&A – Lab 11: SQL Injection Mitigation

---

### Q1. What is SQL Injection (SQLi)?
**A:** SQL Injection is a web application vulnerability where an attacker injects malicious SQL code into application queries to manipulate the database, bypass authentication, or extract sensitive data.

---

### Q2. Why was the first Flask application vulnerable to SQL injection?
**A:** The application directly concatenated user input into SQL query strings without validation or parameterization, allowing attackers to alter the query logic.

---

### Q3. How was authentication bypassed in the vulnerable application?
**A:** Payloads such as `admin'--` and `' OR '1'='1` modified the WHERE clause to always evaluate as true, bypassing password verification.

---

### Q4. What types of SQL Injection were demonstrated in this lab?
**A:**
- Error-based SQL Injection  
- Boolean-based SQL Injection  
- UNION-based SQL Injection  

---

### Q5. How did the automated SQL Injection detector identify vulnerabilities?
**A:** It sent crafted SQL payloads to application endpoints and analyzed server responses for syntax errors, output differences, or leaked database content.

---

### Q6. What is a parameterized query?
**A:** A parameterized query is a database query where the SQL structure is predefined and user input is passed separately as data using placeholders.

---

### Q7. Why do parameterized queries prevent SQL injection?
**A:** Because user input is never interpreted as executable SQL code—only as literal data—making injection impossible.

---

### Q8. What additional security measure was applied to password handling?
**A:** Passwords were hashed using the SHA-256 algorithm instead of being stored in plaintext.

---

### Q9. How did input validation improve application security?
**A:** It restricted input length and blocked dangerous SQL metacharacters before processing requests, reducing the attack surface.

---

### Q10. What is the key secure coding lesson from this lab?
**A:** Never concatenate SQL queries. Always use parameterized queries combined with input validation and secure password handling.
