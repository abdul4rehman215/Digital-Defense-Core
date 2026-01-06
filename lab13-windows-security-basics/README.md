# 🧪 Lab 13: Windows Security Basics

## 📌 Overview
This lab focuses on **fundamental Windows security concepts** and demonstrates how enterprise-grade Windows security mechanisms can be **simulated, analyzed, and validated using Linux-based open-source tools**.

The lab covers:
- Active Directory (AD) security concepts
- Group Policy Object (GPO) simulation
- Password and audit policy enforcement
- Windows Firewall behavior using iptables
- Time-based and IP-based access controls
- Logging, monitoring, and verification

This approach mirrors real-world Windows enterprise environments while remaining platform-agnostic and SOC-relevant.

---

## 🎯 Objectives
By completing this lab, you will be able to:

- Understand Windows security hardening fundamentals
- Simulate Active Directory using Samba
- Create Organizational Units (OUs), users, and security groups
- Apply Group Policy–style password and audit policies
- Implement Windows Firewall logic using iptables
- Configure role-based, time-based, and IP-based firewall rules
- Enable logging and monitoring for security events
- Validate and test security controls

---

## 🧠 Skills Gained
- Active Directory security architecture
- Group Policy logic and enforcement
- Password & account lockout policies
- Firewall segmentation and default-deny strategy
- Security auditing and logging
- Enterprise security validation techniques
- Cross-platform security translation (Windows ↔ Linux)

---

## 🖥️ Lab Environment
- **Operating System:** Ubuntu 24.04 LTS  
- **Shell:** bash  
- **User:** cloud-lab-user  
- **Tools Used:**
  - Samba
  - smbclient
  - winbind
  - iptables
  - netcat
  - systemd
  - Linux shell scripting

---

## 🧩 Tasks Performed

### Task 1: Secure Active Directory & GPO Simulation

* Installed and configured Samba as an AD Domain Controller
* Created OUs, users, and security groups
* Applied password policies using scripted enforcement
* Simulated Group Policy using SYSVOL and configuration files
* Implemented audit policies and user rights assignments

### Task 2: Windows Firewall Simulation

* Implemented default-deny firewall policy
* Allowed only required AD and application ports
* Created time-based firewall rules for RDP access
* Implemented IP-based access control
* Enabled firewall logging and monitoring
* Validated rules using testing scripts

---

## ✅ Verification Checklist

✔ AD users and groups created
✔ Password and lockout policies enforced
✔ Audit policies logged correctly
✔ Firewall default-deny policy applied
✔ Time-based and IP-based rules enforced
✔ Logging and monitoring validated

---

## 🏁 Conclusion

This lab demonstrates **enterprise Windows security fundamentals** using open-source tooling.
The concepts implemented here directly translate to real-world Windows environments involving:

* Active Directory management
* Group Policy enforcement
* Windows Firewall administration
* SOC monitoring and auditing

These skills are **highly relevant for SOC analysts, system administrators, and cybersecurity engineers** working in enterprise environments.

---

## 🔑 Key Takeaways

* Centralized identity and policy enforcement is critical
* Group Policy ensures consistency and compliance
* Default-deny firewall rules reduce attack surface
* Logging and monitoring are essential for detection
* Windows security principles apply across platforms
