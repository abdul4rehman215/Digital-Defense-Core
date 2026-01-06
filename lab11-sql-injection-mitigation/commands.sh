#!/bin/bash
# Lab 11 – SQL Injection Mitigation
# All commands executed during the lab session

# Step 1: Create project directory
mkdir ~/sqli_lab
cd ~/sqli_lab
pwd

# Step 2: Install required dependencies
pip3 install flask requests --user

# Step 3: Create vulnerable application
nano vulnerable_app.py

# Step 4: Run vulnerable application
python3 vulnerable_app.py &

# Step 5: Manual SQL Injection testing (performed via browser)
# Login payloads tested:
# admin'--
# ' OR '1'='1

# Search payloads tested:
# ' OR 1=1--
# ' UNION SELECT username,password,email FROM users--

# Step 6: Create automated SQL Injection detector
nano sqli_detector.py

# Step 7: Run SQL Injection detector
python3 sqli_detector.py

# Step 8: View detection report
cat sqli_report.txt

# Step 9: Create secure application with parameterized queries
nano secure_app.py

# Step 10: Stop vulnerable app
pkill -f vulnerable_app.py

# Step 11: Run secure application
python3 secure_app.py &

# Step 12: Manual secure testing via browser
# Valid login tested:
# admin / admin123

# SQL Injection attempts tested and blocked:
# admin'--
# ' OR '1'='1
# '; DROP TABLE users;--

# Step 13: Create automated secure testing script
nano test_secure_app.py

# Step 14: Run secure testing script
python3 test_secure_app.py

# Step 15: Re-run SQLi detector against secure app
nano sqli_detector.py   # update base URL to http://localhost:5001
python3 sqli_detector.py

# Step 16: Verify secure scan report
cat sqli_report.txt
