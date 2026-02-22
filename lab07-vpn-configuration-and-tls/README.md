# 🧪 Lab 7: VPN Configuration and TLS

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Understand the fundamentals of VPN technology and TLS encryption
- Install and configure an OpenVPN server on Linux
- Create and manage PKI certificates using Easy-RSA
- Establish secure VPN client connections
- Verify VPN connectivity using command-line tools
- Analyze VPN and TLS traffic using Wireshark and tshark
- Validate TLS connections using `curl`
- Troubleshoot common VPN and TLS configuration issues

---

## 📋 Prerequisites

- Basic Linux command-line knowledge
- Understanding of networking concepts (IP, routing, DNS)
- Familiarity with file permissions and Linux text editors
- Basic cryptography knowledge (certificates, keys)
- Experience with Linux package management

---

## 🖥️ Environment

- **OS:** Ubuntu 24.04.1 LTS (Cloud Lab Environment)
- **User:** toor
- **Host:** AWS EC2
- **Network Interface:** ens5
- **Shell Prompt:** `toor@ip-172-31-10-214:~$`

---

## 🧩 Lab Tasks Overview

### 🔹 Task 1: OpenVPN Installation and Server Setup
- Install OpenVPN and Easy-RSA
- Initialize PKI and create Certificate Authority
- Generate server and client certificates
- Configure OpenVPN server
- Enable IP forwarding and firewall rules
- Start and verify OpenVPN service

### 🔹 Task 2: VPN Client Configuration
- Create OpenVPN client configuration
- Embed certificates and keys inline
- Establish VPN tunnel
- Verify routing and connectivity

### 🔹 Task 3: VPN Traffic Analysis
- Capture VPN traffic using Wireshark/tshark
- Verify encrypted OpenVPN packets
- Analyze tunneled traffic over `tun0`

### 🔹 Task 4: TLS Validation and Analysis
- Test HTTPS connections using `curl`
- Validate TLS versions (1.2, 1.3)
- Capture TLS handshakes
- Analyze certificate verification and cipher usage

### 🔹 Task 5: Performance, Security & Cleanup
- Verify DNS resolution through VPN
- Check external IP changes
- Analyze OpenVPN logs
- Stop VPN services and clean up environment

---

## 🏁 Conclusion

This lab demonstrates a complete, real-world VPN deployment using OpenVPN with TLS-based security.  
It covers certificate-based authentication, encrypted tunneling, firewall configuration, and traffic analysis.

These skills are essential for:
- Secure remote access
- Enterprise VPN deployments
- Network security operations
- TLS and encrypted communication validation

---
