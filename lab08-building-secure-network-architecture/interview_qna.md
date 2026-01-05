# 📘 Interview Q&A – Lab 8: Building a Secure Network Architecture

This section contains **only the original 10 interview questions**, rewritten cleanly and professionally in **Markdown format**, without adding or removing any questions.

---

## Q1. What is network segmentation and why is it important?
**Answer:**  
Network segmentation divides a network into isolated zones to limit attack spread, reduce attack surface, and enforce access control between different parts of the network.

---

## Q2. Which tool did you use to implement network segmentation?
**Answer:**  
iptables was used to control, filter, and enforce traffic rules between different network segments.

---

## Q3. How did you simulate multiple network zones on a single machine?
**Answer:**  
By creating dummy virtual interfaces representing DMZ, Internal, and Management networks.

---

## Q4. Why was IP forwarding enabled in this lab?
**Answer:**  
IP forwarding was required to allow controlled routing of traffic between the segmented network interfaces.

---

## Q5. What traffic was allowed to the DMZ network?
**Answer:**  
Only HTTP (port 80), HTTPS (port 443), and SSH (port 22) from the Management network were allowed.

---

## Q6. How did you block lateral movement from DMZ to Internal network?
**Answer:**  
By explicitly dropping all DMZ-to-Internal traffic using iptables FORWARD rules.

---

## Q7. Why were logging rules added to iptables?
**Answer:**  
To monitor, audit, and detect dropped or suspicious network traffic for security visibility.

---

## Q8. How did you automate network configuration?
**Answer:**  
Using shell scripts to create interfaces, enable IP forwarding, apply firewall rules, and configure monitoring and cleanup.

---

## Q9. How did you validate that segmentation was correctly enforced?
**Answer:**  
By running validation scripts that checked interfaces, firewall rules, IP forwarding, and security logs.

---

## Q10. What security principle does this architecture demonstrate?
**Answer:**  
Defense-in-depth through isolation, least privilege access, and continuous monitoring.

---
