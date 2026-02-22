# 🧪 Lab 10: Web Security Basics

## 🎯 Objectives
By completing this lab, the following objectives were achieved:

- Configure SSL/TLS encryption on an Apache web server  
- Generate and deploy a self-signed SSL certificate  
- Verify secure HTTPS communication  
- Identify Cross-Site Scripting (XSS) vulnerabilities  
- Develop XSS detection mechanisms  
- Implement input sanitization and output encoding  
- Secure a vulnerable web application against XSS attacks  

---

## 📋 Prerequisites
- Basic Linux command-line knowledge  
- Understanding of HTTP vs HTTPS  
- Familiarity with Apache web server  
- Basic PHP and Python knowledge  
- Awareness of common web security vulnerabilities

---

## 📌 Lab Information
- **System:** Ubuntu 24.04 LTS  
- **User:** cloud-lab-user  
- **Shell:** bash  
- **Web Server:** Apache 2  
- **Languages Used:** PHP, Python  

---

## 🧩 Lab Tasks Overview

### 🔐 Task 1: Configure SSL/TLS on Apache Web Server
- Installed and enabled Apache SSL modules  
- Generated a self-signed SSL certificate using OpenSSL  
- Configured Apache SSL virtual host  
- Enforced secure TLS protocols and cipher suites  
- Verified HTTPS functionality on port 443  

### 🛡️ Task 2: Detect Cross-Site Scripting (XSS)
- Built a deliberately vulnerable PHP comment system  
- Demonstrated reflected XSS using malicious payloads  
- Confirmed JavaScript execution in the browser  
- Understood real-world impact of XSS vulnerabilities  

### 🧪 Task 3: XSS Detection Using Python
- Developed a regex-based XSS detection script  
- Classified XSS risk levels (LOW / MEDIUM / HIGH)  
- Logged malicious inputs for audit and monitoring  

### 🔒 Task 4: XSS Prevention & Secure Application
- Implemented HTML encoding and tag stripping techniques  
- Built a secure PHP comment system  
- Added runtime detection and sanitization  
- Verified protection against common XSS payloads  

---

## 🧠 Key Security Concepts Learned
- Importance of HTTPS for data confidentiality  
- Role of SSL/TLS certificates in secure communication  
- How XSS attacks exploit untrusted user input  
- Difference between detection and prevention  
- Why output encoding is the safest XSS defense  
- Defense-in-depth for web applications  

---

## 🏁 Conclusion

In this lab, core web security concepts were implemented and validated through hands-on configuration and testing. HTTPS was successfully enabled on the Apache web server using SSL/TLS, ensuring encrypted communication and protecting data in transit.
A vulnerable web application was deliberately created to demonstrate how Cross-Site Scripting (XSS) attacks occur in real environments. By exploiting unvalidated user input, the lab highlighted how easily malicious scripts can execute in a browser when proper security controls are missing.
Detection and prevention mechanisms were then implemented using both Python and PHP. Regex-based detection scripts identified malicious patterns, while secure coding practices such as input validation, output encoding, and tag stripping were applied to eliminate XSS risks.

This lab reinforces essential defensive principles used in real-world web security:
- Always encrypt web traffic using HTTPS
- Never trust user input
- Detect, sanitize, and encode untrusted data
- Apply layered security controls instead of relying on a single defense

The skills practiced in this lab are directly applicable to secure web application development, SOC analysis, and defensive security operations.
