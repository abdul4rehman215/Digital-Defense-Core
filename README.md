# 🛡️ Digital Defense Core — Hands-on Cyber Security Labs (Labs 1–20)

<div align="center">

<!-- Platform & Environment -->
![OS](https://img.shields.io/badge/OS-Ubuntu%2020.04%20%7C%2022.04%20%7C%2024.04-orange?style=for-the-badge&logo=ubuntu)
![Linux](https://img.shields.io/badge/Linux-Security-black?style=for-the-badge&logo=linux)
![Python](https://img.shields.io/badge/Python-3.x-blue?style=for-the-badge&logo=python)
![Bash](https://img.shields.io/badge/Shell-Bash-green?style=for-the-badge&logo=gnu-bash)

<!-- SOC / Blue Team Focus -->
![SOC](https://img.shields.io/badge/Focus-SOC%20Operations-red?style=for-the-badge)
![BlueTeam](https://img.shields.io/badge/Defense-Blue%20Team-0A66C2?style=for-the-badge)
![DFIR](https://img.shields.io/badge/DFIR-Forensics-purple?style=for-the-badge)
![SIEM](https://img.shields.io/badge/SIEM-Log%20Correlation-critical?style=for-the-badge)
![Automation](https://img.shields.io/badge/Security-Automation-success?style=for-the-badge)

<!-- Scope & Status -->
![Labs](https://img.shields.io/badge/Labs-1--20%20Hands--On-brightgreen?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)
![Level](https://img.shields.io/badge/Level-Intermediate%20→%20Advanced-blueviolet?style=for-the-badge)

<!-- Repository Metadata -->
![Repo Size](https://img.shields.io/github/repo-size/abdul4rehman215/digital-defense-core?style=for-the-badge)
![Stars](https://img.shields.io/github/stars/abdul4rehman215/digital-defense-core?style=for-the-badge)
![Forks](https://img.shields.io/github/forks/abdul4rehman215/digital-defense-core?style=for-the-badge)
![Last Commit](https://img.shields.io/github/last-commit/abdul4rehman215/digital-defense-core?style=for-the-badge)

</div>

---

## 📌 Overview

**Digital Defense Core** is a **full-spectrum, hands-on cybersecurity lab repository** focused on **defensive security, SOC operations, detection engineering, DFIR, SIEM, automation, and patch management**.

This repository documents **real command execution, real outputs, real automation scripts, validation steps, troubleshooting workflows, and interview-ready explanations** — not theory, not slides, not copy-paste tutorials.

All labs were executed in **Linux cloud environments** and structured for **professional SOC portfolios and technical interviews**.

---

## 🎯 Learning Objectives

By completing **Labs 1–20**, the following skills are demonstrated:

- Linux security fundamentals & hardening
- Zero Trust & least-privilege enforcement
- Secure credential handling & cryptography
- PKI, TLS & certificate trust models
- Network segmentation & firewall engineering
- Log analysis & SIEM pipelines
- Incident detection, containment & response
- Digital forensics & evidence handling
- Patch management automation
- SOC-style monitoring & reporting
- Bash & Python security automation
- Interview-ready security explanations

---

## 📚 Labs Index (1–20)

> 🔗 Click any lab to jump directly to its folder

| Lab No | Lab Title | Focus Area |
|------|-----------|-----------|
| 01 | [Introduction to Defense-in-Depth](lab-01-defense-in-depth) | Security fundamentals |
| 02 | [Implementing Zero Trust Access](lab-02-zero-trust) | Access control & trust models |
| 03 | [Secure Credential Management](lab-03-secure-credential-management) | Passwords, hashing, encryption |
| 04 | [Cryptography with Python](lab-04-cryptography-python) | AES, hashing, secure storage |
| 05 | [Digital Certificates & PKI](lab-05-pki-certificates) | Certificates, OpenSSL, trust |
| 06 | [Linux Security Hardening](lab-06-linux-security-hardening) | Permissions, services, logging |
| 07 | [VPN Configuration & TLS](lab-07-vpn-tls) | Secure tunneling |
| 08 | [Secure Network Architecture](lab-08-secure-network-architecture) | Segmentation, iptables |
| 09 | [Firewall & IDS/IPS Configuration](lab-09-firewall-ids-ips) | UFW, Fail2Ban |
| 10 | [Web Security Basics](lab-10-web-security) | HTTPS, TLS, XSS |
| 11 | [Security Log Correlation](lab-11-security-log-correlation) | SOC fundamentals |
| 12 | [Binary Analysis & Reverse Engineering](lab-12-binary-analysis) | Malware analysis |
| 13 | [File Integrity Monitoring (FIM)](lab-13-file-integrity-monitoring) | Compliance & IR |
| 14 | [Virtualization Security](lab-14-virtualization-security) | KVM, hardening |
| 15 | [Incident Response Simulation](lab-15-incident-response) | IR lifecycle |
| 16 | [Cloud Security Basics](lab-16-cloud-security-basics) | IAM, monitoring |
| 17 | [Incident Response Simulation (Advanced)](lab-17-ir-advanced) | Containment & reporting |
| 18 | [Digital Forensics with Autopsy](lab-18-digital-forensics) | DFIR |
| 19 | [Log Management with SIEM (ELK Stack)](lab-19-siem-elk) | SOC operations |
| 20 | [Patch Management Automation](lab-20-patch-management) | Security automation |


## 🧱 Standard Lab Structure (ALL LABS)

Every lab follows the **same strict, professional structure**:

```
lab-XX/
├── README.md              # Objectives, environment, tasks, explanation
├── commands.sh            # EXACT commands executed (verbatim)
├── output.txt             # ONLY terminal outputs
├── scripts/               # Bash / Python automation
├── interview_qna.md       # Exactly 10 SOC/IR interview Q&A
└── troubleshooting.md     # Real issues, fixes, validation
```

---

## 🖥️ Lab Environment

* **OS:** Ubuntu 20.04 / 22.04 / 24.04 LTS
* **Shell:** Bash
* **Languages:** Bash, Python 3
* **Execution:** Real terminal commands
* **User:** Non-root with sudo
* **Focus:** SOC / Blue Team realism

---

## 🧰 Tools & Technologies Used

### 🔐 Security & SOC Tools

* OpenSSL
* Fail2Ban
* UFW / iptables
* rsyslog
* auditd
* tcpdump
* Suricata
* Lynis
* Autopsy
* ELK Stack (Elasticsearch, Logstash, Kibana)

### ⚙️ Scripting & Automation

* Bash
* Python 3
* Regex-based detection
* Log parsing
* Automation pipelines
* Validation scripts
* Dashboards & reports

### 🌐 Network & Web

* Apache2
* SSL/TLS
* PKI
* VPNs
* XSS detection & mitigation
* Secure web services

---

## 👥 Who This Repository Is For

* SOC Analysts (L1 / L2)
* Blue Team Engineers
* DFIR Analysts
* Cloud & Linux Security Students
* Cybersecurity Job Seekers
* Interview & portfolio preparation

---

## 📈 Skills Demonstrated (Labs 1–20)

* Linux system defense
* Credential security & encryption
* PKI & TLS trust models
* Firewall & IDS integration
* Network segmentation
* Log correlation & SIEM
* Incident detection & containment
* Digital forensics & evidence handling
* Patch automation & validation
* SOC dashboards & reporting
* Professional documentation

---

## 📁 Security-Aware Repository Hygiene

Sensitive artifacts are excluded by design:

* Logs & runtime data
* Forensic images
* SIEM indices
* Credentials & secrets
* Backups & snapshots

✔ Security-first Git hygiene
✔ Recruiter-safe repository

---

## 🏁 Final Note

This repository represents **real defensive security engineering**, not academic exercises.

> **Automation + Visibility + Response = Modern SOC**

If you are preparing for:

* SOC Analyst roles
* Blue Team interviews
* DFIR positions
* Security automation work

This repository demonstrates **production-grade capability**.

### Happy learning & building 🔐🚀

---
