# 🧪 Lab 12 – Endpoint Security & Hardening

## 🎯 Objectives
By completing this lab, the following objectives were achieved:

- Configure secure SSH access using key-based authentication
- Harden SSH by disabling password authentication and root login
- Install and configure fail2ban to mitigate brute-force attacks
- Develop custom monitoring scripts for unauthorized access detection
- Implement host-based firewall rules using UFW
- Set up file integrity monitoring for critical system files
- Automate security monitoring using cron jobs
- Understand proactive endpoint security monitoring concepts

---

## 📋 Prerequisites
- Basic Linux command-line knowledge
- Understanding of file permissions and ownership
- Familiarity with nano or vim
- Basic understanding of SSH protocol
- Knowledge of Linux log file locations

---

## 🖥 Environment
- OS: Ubuntu 24.04 LTS (Cloud-based Linux Lab)
- User: cloud-lab-user
- Shell: bash
- Services: OpenSSH, fail2ban, UFW
- Scripting: Bash
- Logs Monitored: /var/log/auth.log

---

## 🧩 Lab Tasks Overview

### Task 1: Secure SSH Access Configuration
- Generate SSH key pairs
- Configure authorized keys and permissions
- Harden SSH daemon configuration
- Validate and restart SSH securely

### Task 2: Intrusion Prevention with fail2ban
- Install fail2ban
- Configure SSH jail with custom port
- Verify ban rules and logging

### Task 3: Monitoring Unauthorized Access
- Create SSH login monitoring scripts
- Monitor sudo usage, new users, and system load
- Centralize security checks into a master script
- Automate monitoring using cron

### Task 4: Endpoint Security Verification
- Test SSH access controls
- Validate monitoring scripts
- Generate test security events

### Task 5: Additional Hardening Measures
- Configure UFW firewall rules
- Implement file integrity monitoring
- Verify all security controls

---

## 🔐 Task 1 – Secure SSH Configuration

### Implemented Controls
- RSA 4096-bit key-based authentication
- Password authentication disabled
- Root login disabled
- SSH port changed to 2222
- Restricted SSH access to a specific user
- Reduced authentication retries

These changes significantly reduce exposure to brute-force and credential-based attacks.

---

## 🚫 Task 2 – Brute Force Protection (fail2ban)

fail2ban was configured to:
- Monitor SSH authentication failures
- Automatically ban IPs after repeated failures
- Use custom ports and log paths
- Provide real-time intrusion prevention

---

## 👁️ Task 3 – Proactive Security Monitoring

Custom Bash scripts were developed to monitor:
- Failed and successful SSH logins
- Login attempts during unusual hours
- Sudo usage spikes
- New user account creation
- System load and disk usage
- File integrity changes

Monitoring data is logged persistently for forensic analysis.

---

## 🔥 Task 5 – Endpoint Hardening

Additional hardening measures included:
- Host-based firewall using UFW (default deny)
- File integrity baseline creation
- Continuous integrity verification
- Automated hourly security checks

---

## ✅ Verification Summary

- SSH hardened and validated
- fail2ban active and monitoring
- Firewall enforcing least-privilege rules
- Monitoring scripts functioning correctly
- File integrity baseline established
- Cron automation verified

---

## 🏁 Conclusion

This lab implemented **defense-in-depth endpoint security** by combining:

- Secure authentication
- Intrusion prevention
- Continuous monitoring
- Firewall enforcement
- File integrity validation
- Automation

These controls mirror **real-world Linux hardening practices** used in SOC and production environments.
