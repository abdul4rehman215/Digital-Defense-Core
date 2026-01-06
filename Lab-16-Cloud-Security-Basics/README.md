# 🧪 Lab 16: Cloud Security Basics

## 📌 Lab Overview
This lab focuses on implementing core cloud security principles using a simulated cloud environment built on Linux. The lab mirrors real-world cloud security controls such as Identity and Access Management (IAM), network security groups, encryption and key management, monitoring, auditing, and secure backup practices.

All implementations are performed using open-source tools on a Linux system to demonstrate cloud-provider-agnostic security concepts aligned with AWS, Azure, and GCP security models.

---

## 🎯 Objectives
By completing this lab, the following objectives are achieved:
- Implement IAM-style users, roles, and policy enforcement
- Apply least privilege access control principles
- Simulate Multi-Factor Authentication (MFA)
- Configure cloud-style firewall security groups
- Implement encryption and key management for data protection
- Monitor system and network security events
- Perform security auditing and compliance-style reporting
- Understand the shared responsibility model in cloud security

---

## 📋 Prerequisites
The following knowledge is required before starting this lab:
- Basic Linux command-line usage
- Understanding of users, groups, and file permissions
- Familiarity with networking concepts (ports, IP ranges)
- Basic cloud computing concepts
- No prior cloud security tooling experience required

---

## 🖥️ Lab Environment
- **Operating System:** Ubuntu 22.04 LTS  
- **User:** cloud-lab-user  
- **Shell:** bash  
- **Context:** Simulated Cloud Security Environment  

---

## 🧩 Task 1: Implement IAM-Like Security Controls
This task simulates cloud Identity and Access Management (IAM) using Linux users, groups, and policy logic.

### Key Activities
- Creation of IAM-style users representing cloud roles
- Role-based grouping of users
- Policy-based access control simulation using scripts
- Logging of access attempts
- Enforcement of least privilege

All user creation, group assignments, and policy enforcement commands are documented in `commands.sh`.  
Policy enforcement results and validation outputs are captured in `outputs/output.txt`.

---

## 🧩 Task 2: Cloud Security Best Practices
This task implements core cloud security controls commonly enforced at the infrastructure level.

### Key Activities
- Firewall configuration simulating cloud security groups
- Network access monitoring and alerting
- Encryption and secure key lifecycle management
- Brute-force protection using Fail2Ban
- Centralized logging for security events

Associated scripts are located in the `scripts/` directory, and all execution results are stored in `outputs/output.txt`.

---

## 🧩 Task 3: Security Auditing, Backup, and Compliance
This task focuses on operational security and compliance-style controls.

### Key Activities
- Secure backup creation with encryption
- Backup integrity verification and restoration
- Automated security auditing
- Compliance-style reporting in log and HTML formats
- Final verification of all security controls

---

## ✅ Verification Summary
The following security controls were successfully verified:
- IAM-style access enforcement
- MFA simulation for privileged accounts
- Firewall and network monitoring
- Encryption and key management
- Backup and restore procedures
- Security auditing and reporting

Verification outputs are included in `output.txt`.

---

## 🧠 What I Learned
- How IAM principles apply across all cloud platforms
- Why least privilege is critical for cloud security
- How MFA strengthens privileged account protection
- How cloud security groups differ from traditional firewalls
- The importance of encryption, auditing, and backups in cloud environments

---

## 🏁 Conclusion
This lab demonstrates foundational cloud security practices using open-source Linux tools in a simulated cloud environment. The concepts implemented in this lab directly translate to enterprise cloud platforms such as AWS, Azure, and Google Cloud.

The lab reinforces the shared responsibility model and highlights the importance of identity security, network controls, monitoring, encryption, and continuous auditing in maintaining a strong cloud security posture.
