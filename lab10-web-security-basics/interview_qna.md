## 📘 Interview Q&A – Lab 10: Web Security Basics

### Q1. Why is SSL/TLS important for web applications?
**A:** SSL/TLS encrypts data in transit, protecting it from eavesdropping, data tampering, and man-in-the-middle (MITM) attacks.

---

### Q2. What type of certificate was used in this lab and why?
**A:** A self-signed SSL certificate was used because it is suitable for testing and learning environments without relying on a trusted Certificate Authority.

---

### Q3. Which Apache modules were required to enable HTTPS?
**A:** The `ssl` module and the `default-ssl` site configuration were required to enable HTTPS on the Apache web server.

---

### Q4. How did you verify that HTTPS was working correctly?
**A:** HTTPS was verified by accessing the site using `curl -k https://localhost` and confirming that the content was served over TLS.

---

### Q5. What is Cross-Site Scripting (XSS)?
**A:** XSS is a vulnerability where malicious scripts are injected into trusted web pages and executed in the user’s browser.

---

### Q6. How was XSS demonstrated in the vulnerable application?
**A:** By submitting a `<script>` payload that executed JavaScript alerts in the browser, confirming the presence of XSS.

---

### Q7. How did you detect potential XSS input programmatically?
**A:** Using regex-based pattern matching in a Python XSS detection script to identify malicious input patterns.

---

### Q8. What is the safest method to prevent XSS attacks?
**A:** Output encoding using HTML escaping before rendering user input is the safest and most reliable method.

---

### Q9. How did the secure PHP application prevent XSS?
**A:** By validating user input and sanitizing output using HTML encoding or tag stripping before displaying data.

---

### Q10. What key security principle does this lab reinforce?
**A:** Never trust user input—always validate, sanitize, and encode data before displaying it in web applications.
