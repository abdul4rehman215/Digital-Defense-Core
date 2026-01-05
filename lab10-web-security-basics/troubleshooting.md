## 🛠️ Troubleshooting – Lab 10: Web Security Basics

---

### 🔐 SSL / TLS Certificate Issues

**Problem:** Browser or curl shows certificate warnings or HTTPS errors.  
**Possible Causes & Fixes:**
- Ensure the Common Name (CN) in the certificate matches the hostname (e.g., `localhost`).
- Verify certificate and key permissions:
  ```bash
  sudo chmod 600 /etc/apache2/ssl/*.key
  sudo chmod 644 /etc/apache2/ssl/*.crt
  ```

* Confirm SSL module is enabled:

  ```bash
  sudo a2enmod ssl
  sudo systemctl restart apache2
  ```

---

### 🌐 Apache Not Starting After SSL Configuration

**Problem:** Apache fails to start or restart after editing SSL config.
**Fix Steps:**

* Test Apache configuration:

  ```bash
  sudo apache2ctl configtest
  ```
* Review error logs:

  ```bash
  sudo tail -f /var/log/apache2/error.log
  ```
* Ensure port 443 is free:

  ```bash
  sudo netstat -tlnp | grep :443
  ```

---

### 🧩 PHP Files Not Executing

**Problem:** PHP files are downloaded instead of executed.
**Fix Steps:**

* Ensure PHP and Apache PHP module are installed:

  ```bash
  sudo apt install php libapache2-mod-php -y
  ```
* Restart Apache:

  ```bash
  sudo systemctl restart apache2
  ```
* Verify PHP installation:

  ```bash
  php -v
  ```

---

### ⚠️ XSS Detection Script Not Detecting Payloads

**Problem:** XSS detector does not flag malicious input.
**Fix Steps:**

* Verify regex patterns are properly escaped.
* Test patterns individually before combining.
* Ensure `re.IGNORECASE` flag is used for case-insensitive matching.
* Print input data during debugging to confirm correct values are passed.

---

### 🧼 XSS Protection Script Not Sanitizing Input

**Problem:** Malicious input still appears in output.
**Fix Steps:**

* Ensure output encoding (`html.escape` / `htmlspecialchars`) is applied **before rendering**.
* Avoid mixing raw and sanitized variables.
* Confirm the selected sanitization method (encode/strip) is applied consistently.

---

### 🐍 Python Script Execution Errors

**Problem:** Python scripts fail to run or import modules.
**Fix Steps:**

* Verify Python version:

  ```bash
  python3 --version
  ```
* Check script permissions:

  ```bash
  chmod +x *.py
  ```
* Run scripts explicitly with Python:

  ```bash
  python3 script_name.py
  ```

---

### 📂 File Permission Issues in Web Root

**Problem:** Apache cannot read or serve files.
**Fix Steps:**

* Ensure correct ownership:

  ```bash
  sudo chown -R www-data:www-data /var/www/html
  ```
* Ensure readable permissions:

  ```bash
  sudo chmod -R 755 /var/www/html
  ```

---

### 📌 General Debugging Tips

* Always restart Apache after configuration changes.
* Test HTTPS using both browser and `curl -k`.
* Log detection events to files for visibility.
* Keep SSL keys private and never commit them to GitHub.
* Combine detection and sanitization for layered defense.

---

### ✅ Final Note

Most SSL and XSS issues arise from:

* Incorrect configuration files
* Missing modules
* Improper input/output handling

Systematic testing, log review, and strict input validation resolve the majority of problems in web security labs.
