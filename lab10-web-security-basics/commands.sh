#!/bin/bash
# Lab 10: Web Security Basics – commands.sh
# System: Ubuntu 24.04 LTS

# -------------------------------
# Task 1: Configure SSL/TLS on Apache
# -------------------------------

sudo apt update
sudo apt install apache2 -y

sudo a2enmod ssl
sudo a2ensite default-ssl
sudo systemctl restart apache2

sudo netstat -tlnp | grep apache2

# -------------------------------
# Generate Self-Signed SSL Certificate
# -------------------------------

sudo mkdir -p /etc/apache2/ssl

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/apache2/ssl/apache-selfsigned.key \
-out /etc/apache2/ssl/apache-selfsigned.crt

sudo ls -la /etc/apache2/ssl/

# -------------------------------
# Configure Apache SSL Virtual Host
# -------------------------------

sudo cp /etc/apache2/sites-available/default-ssl.conf \
/etc/apache2/sites-available/default-ssl.conf.backup

sudo nano /etc/apache2/sites-available/default-ssl.conf

sudo apache2ctl configtest
sudo systemctl restart apache2

# -------------------------------
# Test SSL Configuration
# -------------------------------

sudo nano /var/www/html/ssl-test.html
curl -k https://localhost/ssl-test.html

# -------------------------------
# Task 2: Detect and Prevent XSS
# -------------------------------

sudo apt install php libapache2-mod-php -y
sudo systemctl restart apache2

sudo mkdir -p /var/www/html/xss-lab
sudo nano /var/www/html/xss-lab/vulnerable.php

# -------------------------------
# XSS Detection Script
# -------------------------------

mkdir -p ~/security-scripts
cd ~/security-scripts

nano xss_detector.py
chmod +x xss_detector.py

python3 xss_detector.py "<script>alert('XSS')</script>"
cat /tmp/xss_detection.log

# -------------------------------
# XSS Protection Script
# -------------------------------

nano xss_protector.py
chmod +x xss_protector.py
python3 xss_protector.py

# -------------------------------
# Secure Web Application
# -------------------------------

sudo nano /var/www/html/xss-lab/secure.php

# -------------------------------
# XSS Testing
# -------------------------------

# Test manually in browser:
# http://localhost/xss-lab/vulnerable.php
# http://localhost/xss-lab/secure.php

# Payloads:
# <script>alert('XSS')</script>
# <img src=x onerror=alert(1)>
# <iframe src="javascript:alert('XSS')"></iframe>
# <svg onload=alert('XSS')>
# javascript:alert(document.cookie)

