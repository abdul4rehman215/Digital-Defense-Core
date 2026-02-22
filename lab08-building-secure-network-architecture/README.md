# 🧪 Lab 8: Building a Secure Network Architecture

## 📌 Lab Overview
This lab focuses on designing and implementing a **secure, segmented network architecture** using Linux firewall capabilities.  
The lab demonstrates how **network segmentation**, **firewall enforcement**, and **automation** can be applied to protect critical systems and reduce attack surface.

The entire architecture is implemented on a **single Ubuntu system** using **dummy network interfaces**, making it ideal for cloud and lab environments where multiple physical networks are unavailable.

---

## 🎯 Objectives
By completing this lab, I was able to:

- Understand the fundamentals of **network segmentation** and its security benefits
- Design logical network zones (DMZ, Internal, Management)
- Configure **iptables firewall rules** to control traffic flow between segments
- Implement **least-privilege network access**
- Create **automation scripts** for network configuration and validation
- Implement logging and monitoring for security visibility
- Troubleshoot common network segmentation issues
- Apply real-world **secure network architecture best practices**

---

## 📋 Prerequisites

- Basic Linux command-line experience
- Understanding of IP addressing and subnetting
- Familiarity with TCP/IP fundamentals
- Basic shell scripting knowledge
- Root or sudo privileges on a Linux system

---

## 🖥️ Lab Environment
- **OS:** Ubuntu 24.04 LTS  
- **Firewall:** iptables (pre-installed)  
- **User:** toor  
- **Execution Context:** Cloud-based Linux lab environment  

---

## 🏗️ Network Architecture Design

### Logical Network Segments
This lab implements **three isolated network zones**:

| Segment | Subnet | Purpose |
|------|------|------|
| DMZ | 192.168.10.0/24 | Public-facing services |
| Internal | 192.168.20.0/24 | Internal application traffic |
| Management | 192.168.30.0/24 | Administrative access |

Each segment is simulated using **dummy network interfaces**, allowing segmentation on a single host.

---

## 🧩 Lab Tasks Breakdown

### 🔹 Task 1: Network Discovery & Baseline Assessment
- Examine existing network interfaces
- Review routing table
- Inspect existing iptables rules
- Identify lack of segmentation and filtering

### 🔹 Task 2: Network Segmentation with iptables
- Create virtual network interfaces
- Enable IP forwarding
- Implement firewall rules for:
  - DMZ access control
  - Internal-to-DMZ access
  - Management-only administrative access
  - Lateral movement prevention
- Enable logging of dropped packets

### 🔹 Task 3: Automation & Infrastructure-as-Code
- Create automated scripts for:
  - Network interface creation
  - Firewall rule enforcement
  - Validation and testing
  - Monitoring and dashboards
  - Cleanup and rollback
- Apply repeatable and auditable configuration practices

---

## ✅ Expected Outcomes

After completing this lab, you will have:
- fully segmented network architecture
- Strictly enforced firewall rules
- Automated setup, validation, and monitoring
- Audit-ready logging of blocked traffic
- A realistic enterprise-grade network security lab
- Portfolio-ready documentation and scripts

--- 

## 🏁 Conclusion


This lab demonstrates how network architecture itself is a security control.
By combining segmentation, firewall enforcement, automation, and monitoring, the system achieves strong isolation between network zones while remaining manageable and auditable.

These skills are directly applicable to:
- Enterprise network security
- Cloud security architectures
- SOC and Blue Team operations
- Compliance-driven environments (PCI-DSS, HIPAA, SOX)
