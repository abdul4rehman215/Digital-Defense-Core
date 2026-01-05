#!/bin/bash
# -------------------------------
# Task 1: Fail2Ban Installation
# -------------------------------

sudo apt update
sudo apt install fail2ban -y

# Check Fail2Ban status
sudo systemctl status fail2ban

# Create local configuration (never edit jail.conf)
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Edit configuration
sudo nano /etc/fail2ban/jail.local

# Restart and enable Fail2Ban
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban

# Check Fail2Ban status
sudo fail2ban-client status
sudo fail2ban-client status sshd

# -------------------------------
# Task 1.5: Fail2Ban Testing
# -------------------------------

nano test_fail2ban.sh
chmod +x test_fail2ban.sh
./test_fail2ban.sh

# -------------------------------
# Task 2: UFW Firewall Setup
# -------------------------------

# Check firewall status
sudo ufw status

# Enable firewall
sudo ufw enable

# Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Verify policies
sudo ufw status verbose

# -------------------------------
# Allow Essential Services
# -------------------------------

# SSH
sudo ufw allow ssh
sudo ufw allow 22/tcp

# HTTP / HTTPS
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# -------------------------------
# Custom Firewall Rules
# -------------------------------

# Allow specific IP
sudo ufw allow from 192.168.1.100

# Allow MySQL from specific IP
sudo ufw allow from 192.168.1.100 to any port 3306

# Allow port range
sudo ufw allow 8000:8010/tcp

# Deny malicious IP
sudo ufw deny from 203.0.113.100

# View numbered rules
sudo ufw status numbered

# Delete rule example
sudo ufw delete 5

# Reset firewall (use with caution)
sudo ufw --force reset

# -------------------------------
# Task 2.7: Firewall Testing
# -------------------------------

nano test_firewall.sh
chmod +x test_firewall.sh
./test_firewall.sh

# -------------------------------
# Advanced UFW Configuration
# -------------------------------

sudo nano /etc/ufw/applications.d/myapp
sudo ufw app update MyWebApp
sudo ufw allow MyWebApp

# -------------------------------
# Task 3: Monitoring & Integration
# -------------------------------

nano security_monitor.sh
chmod +x security_monitor.sh
./security_monitor.sh

# -------------------------------
# Automated Security Checks
# -------------------------------

nano security_check.sh
chmod +x security_check.sh
./security_check.sh

# -------------------------------
# Final Verification
# -------------------------------

nano final_verification.sh
chmod +x final_verification.sh
./final_verification.sh

# -------------------------------
# Logs & Validation
# -------------------------------

sudo tail -20 /var/log/auth.log
sudo tail -20 /var/log/ufw.log
netstat -tuln
