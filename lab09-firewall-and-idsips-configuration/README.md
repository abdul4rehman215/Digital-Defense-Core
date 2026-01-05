# 🧪 Lab 9: Firewall and IDS/IPS Configuration

## 📌 Overview
This lab focuses on implementing **host-based firewall controls** and **intrusion detection / prevention mechanisms** on a Linux system.  
It demonstrates how firewalls and IDS/IPS tools work together to detect, prevent, and respond to malicious activity such as brute-force attacks.

The lab uses **UFW** for firewall rule management and **Fail2Ban** for automated intrusion prevention based on log analysis.

---

## 🎯 Objectives
By completing this lab, you will be able to:
- Understand firewall and IDS/IPS fundamentals
- Install and configure Fail2Ban
- Implement firewall rules using UFW
- Monitor authentication and firewall logs
- Test intrusion detection and firewall enforcement
- Apply basic Linux network hardening practices

---

## 🧰 Tools & Technologies Used
- **Operating System:** Ubuntu 20.04 LTS or newer
- **Firewall:** UFW (Uncomplicated Firewall)
- **IDS/IPS:** Fail2Ban
- **Logging:** `/var/log/auth.log`, `/var/log/ufw.log`
- **Utilities:** netstat, curl, logger, systemctl

---

## 🖥️ Lab Environment
- Linux system with sudo access
- Internet connectivity
- SSH enabled
- Pre-installed networking tools

---

## 🧩 Lab Tasks Breakdown

### 🔹 Task 1: Fail2Ban (IDS/IPS)
- Understand Fail2Ban concepts (jails, filters, actions)
- Install and enable Fail2Ban
- Configure SSH protection
- Test intrusion detection using simulated attacks

### 🔹 Task 2: Firewall Configuration (UFW)
- Enable and configure UFW
- Apply default deny/allow policies
- Allow essential services (SSH, HTTP, HTTPS)
- Create granular rules (IP-based, port-based)
- Test firewall enforcement

### 🔹 Task 3: Integration & Monitoring
- Combine Fail2Ban and UFW visibility
- Build security monitoring scripts
- Perform automated security health checks
- Validate system defensive posture

---

## ✅ Expected Outcome

After completing this lab, the system will:

* Automatically block brute-force SSH attempts
* Enforce firewall policies with least-privilege access
* Provide visibility into security events via logs
* Support automated security validation
* Demonstrate defense-in-depth at the host level

---

## 🏁 Conclusion

This lab demonstrated how **firewalls and IDS/IPS work together** to protect Linux systems from common network-based attacks.
By configuring **UFW** for strict traffic control and **Fail2Ban** for automated response to suspicious behavior, you implemented a **practical, real-world defensive setup** used in enterprise and cloud environments.
The integration of monitoring, testing, and verification scripts reinforces the importance of **continuous security validation**, not just one-time configuration.

These skills form a foundational part of:
* Linux system hardening
* SOC and Blue Team operations
* Cloud and server security
* Defense-in-depth strategies

---

## 🔐 Security Principle Demonstrated

**Defense in Depth** — combining firewall enforcement, intrusion prevention, log monitoring, and automated validation to reduce attack surface and response time.
