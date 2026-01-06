# 📘 Interview Q&A – Lab 16: Cloud Security Basics

This document contains interview-focused questions and answers derived strictly from the tasks performed in Lab 16.  
All answers reflect hands-on implementation and real-world cloud security concepts.

---

### Q1. What is cloud security?

Cloud security refers to the set of policies, controls, technologies, and best practices used to protect cloud-based systems, data, and infrastructure from threats, misconfigurations, and unauthorized access.

---

### Q2. What is the shared responsibility model in cloud security?

The shared responsibility model defines which security responsibilities belong to the cloud provider (infrastructure, physical security) and which belong to the customer (identity management, data protection, access control, and monitoring).

---

### Q3. How does Identity and Access Management (IAM) improve cloud security?

IAM improves security by enforcing least privilege, ensuring users only have access to the resources and actions required for their role, reducing the risk of unauthorized access.

---

### Q4. How was IAM simulated in this lab?

IAM was simulated using Linux users, groups, and policy-based scripts that controlled access based on role, mimicking cloud IAM services such as AWS IAM or Azure AD.

---

### Q5. What is policy-based access control?

Policy-based access control evaluates user permissions based on predefined policies rather than hardcoded rules, allowing centralized and consistent security enforcement.

---

### Q6. Why is least privilege important in cloud environments?

Least privilege minimizes potential damage if an account is compromised by limiting permissions to only what is necessary for normal operations.

---

### Q7. What is the purpose of Multi-Factor Authentication (MFA)?

MFA adds an additional authentication factor beyond passwords, significantly reducing the risk of credential theft and unauthorized access.

---

### Q8. How was MFA implemented in this lab?

MFA was simulated using TOTP-based authentication via Google Authenticator PAM modules for privileged users.

---

### Q9. How do cloud security groups differ from traditional firewalls?

Cloud security groups act as virtual firewalls applied at the resource level, controlling traffic based on identity and role rather than just IP and port.

---

### Q10. How were cloud security groups simulated in this lab?

They were simulated using UFW firewall rules that controlled ingress traffic based on trusted IP ranges and allowed services.
