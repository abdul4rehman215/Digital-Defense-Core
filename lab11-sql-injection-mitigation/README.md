# 🧪 Lab 11 – SQL Injection Mitigation

## 🎯 Objectives
By the end of this lab, the following skills were achieved:

- Identify SQL Injection vulnerabilities in web applications
- Understand how insecure query construction leads to SQL Injection
- Exploit SQL Injection using manual and automated techniques
- Implement parameterized queries to mitigate SQL Injection
- Apply secure coding practices such as input validation and password hashing
- Verify mitigation using automated security testing

---

## 📋 Prerequisites
- Basic Python programming knowledge
- Understanding of SQL (SELECT, INSERT, UPDATE)
- Familiarity with HTTP requests and web forms
- Basic Linux command-line skills

---

## 🖥 Environment
- OS: Ubuntu 24.04 LTS (Cloud Lab Environment)
- User: cloud-lab-user
- Shell: bash
- Language: Python 3
- Framework: Flask
- Database: SQLite3

---

## 🧩 Lab Tasks Overview

### Task 1: Understanding SQL Injection Vulnerabilities
- Build an intentionally vulnerable Flask application
- Perform manual SQL Injection attacks
- Observe authentication bypass and data leakage

### Task 2: Automated SQL Injection Detection
- Develop a Python-based SQL Injection scanner
- Detect error-based, boolean-based, and UNION-based SQL Injection

### Task 3: Secure Coding with Parameterized Queries
- Implement a secure version of the application
- Use prepared statements and password hashing
- Add strict input validation

### Task 4: Validation & Comparison
- Retest secure application with automated scanner
- Confirm complete mitigation of SQL Injection attacks

---

## 🔓 Task 1 – Vulnerable Application

A deliberately insecure Flask application was created using **string-concatenated SQL queries**.  
This application allowed attackers to manipulate SQL logic using crafted input.

### Demonstrated Vulnerabilities
- Authentication bypass
- Full table disclosure
- Credential leakage

---

## 🛡 Task 3 – Secure Application

The secure version implements:
- Parameterized queries
- Input validation using regex
- Password hashing using SHA-256
- Disabled debug mode
- No SQL error leakage

---

## 🧠 Why Parameterized Queries Work
- SQL structure is fixed at prepare time
- User input is treated strictly as data
- SQL logic cannot be altered
- Injection payloads lose execution power

---

## ✅ Verified Outcomes
- Vulnerable app successfully exploited
- Automated scanner detected vulnerabilities
- Secure app blocked all SQL Injection payloads
- Scanner confirmed zero vulnerabilities post-fix

---

## 🏁 Conclusion

This lab demonstrated **end-to-end SQL Injection exploitation and mitigation**, covering:

- Why SQL Injection occurs
- How attackers exploit insecure queries
- How scanners identify vulnerabilities
- Why parameterized queries are the definitive defense

This reflects **real-world secure coding practices used in production systems**.

---

## 🔑 Key Takeaways
- ❌ Never concatenate SQL strings
- ✅ Always use parameterized queries
- 🔐 Hash passwords
- 🧪 Test applications before deployment
- 🔍 Validate input at boundaries
