# 🧪 Lab 17: Incident Response Simulation

## 📌 Lab Overview
This lab provides a **hands-on Incident Response (IR) simulation** using a single Linux system.  
Students simulate suspicious activity, detect indicators of compromise, apply containment using firewall rules and network segmentation, preserve evidence, and produce professional incident response documentation.

This lab mirrors **real SOC / Blue Team / Incident Response workflows** used in enterprise environments.

---

## 🎯 Objectives
By the end of this lab, I was able to:

- Understand the fundamentals of incident response procedures
- Perform initial system and network assessment
- Detect suspicious processes and network activity
- Capture and preserve forensic evidence
- Implement containment using firewall rules
- Apply network segmentation during an incident
- Document incidents using professional reporting standards
- Perform cleanup and system verification after containment

---

## 🧠 Skills Demonstrated
- Incident detection & triage
- Firewall-based containment (iptables)
- Network segmentation
- Evidence preservation
- Packet capture analysis
- Professional incident reporting
- Blue Team / SOC operations

---

## 🖥️ Lab Environment

| Component | Details |
|---------|--------|
| OS | Ubuntu Linux (Cloud VM) |
| User | cloud-lab-user |
| Shell | bash |
| Scope | Single-host IR simulation |
| Tools | iptables, tcpdump, netstat, ss, nmap, ufw |

---

## 🧩 Task Breakdown

### 🔹 Task 1: Environment Setup & Baseline Assessment
- System update and tool verification
- Deployment of a simulated suspicious service
- Collection of baseline network and firewall data

### 🔹 Task 2: Incident Detection & Analysis
- Generation of suspicious network traffic
- Identification of Indicators of Compromise (IOCs)
- Packet capture using tcpdump
- Documentation of suspicious activity

### 🔹 Task 3: Initial Containment
- Immediate blocking of malicious ports
- IP-based isolation
- Firewall logging enabled
- Verification of containment effectiveness

### 🔹 Task 4: Network Segmentation
- Creation of quarantine and secure zones
- Controlled traffic flow using iptables chains
- Documentation of segmentation rules

### 🔹 Task 5: Incident Reporting
- Evidence collection and preservation
- System state snapshot
- Professional incident response report
- Executive summary for management

### 🔹 Task 6: Cleanup & Restoration
- Safe termination of malicious processes
- Final system state verification
- Post-incident validation

---

## ✅ Final Outcomes

✔ Suspicious activity successfully detected  
✔ Indicators of compromise identified  
✔ Firewall containment applied  
✔ Network segmentation enforced  
✔ Evidence preserved correctly  
✔ Professional IR report generated  
✔ System restored and verified  

---

## 🏁 Final Conclusion

This lab demonstrates a **full incident response lifecycle**, from detection to containment, documentation, and recovery.

Unlike basic labs, this simulation emphasizes:
- Evidence preservation over premature eradication
- Defense-in-depth using layered controls
- Real-world SOC documentation standards
- Operational discipline required in security incidents

The techniques used in this lab directly align with:
- SOC Analyst workflows
- Blue Team operations
- Incident Response playbooks
- Compliance and audit requirements

This is **production-grade incident response practice**, not theoretical exercises.

---

## 🔐 Security Relevance
Incident response is a critical capability in cybersecurity operations.  
Rapid detection, controlled containment, accurate documentation, and structured recovery determine whether an incident becomes a minor event or a major breach.
