# 🧪 Lab 19: Log Management with SIEM Tools (ELK Stack)

---

## 🎯 Objectives

By the end of this lab, students will be able to:

- Install and configure the ELK Stack for centralized log management
- Implement log parsing and normalization using Logstash filters
- Create custom scripts for log analysis and threat detection
- Configure log retention policies and rotation strategies
- Build basic visualizations for security monitoring
- Understand SIEM concepts used in Security Operations Centers (SOC)

---

## 📋 Prerequisites

Before starting this lab, students should have:

- Basic Linux command line proficiency
- Understanding of system logs and their security relevance
- Familiarity with nano / vim
- Basic Bash scripting knowledge
- Networking fundamentals

---

## 🖥️ Lab Environment

- Ubuntu 20.04 LTS
- 4 GB RAM
- 20 GB disk
- Internet access
- OpenJDK 11
- Apache Web Server
- ELK Stack (Elasticsearch, Logstash, Kibana)

---

## 🧩 Lab Overview

This lab demonstrates a complete open-source SIEM pipeline using the ELK Stack.
System authentication logs and Apache web logs are centrally collected, parsed,
normalized, analyzed, retained, and visualized to simulate real-world SOC workflows.

The implementation mirrors production SOC environments where analysts rely on
centralized logging, detection scripts, dashboards, and alerting mechanisms.

---

## 🧩 Tasks Performed

### 🔹 ELK Stack Installation & Configuration

- Installed OpenJDK 11
- Installed and configured Elasticsearch (single-node mode)
- Installed Logstash and created SIEM ingestion pipeline
- Installed and configured Kibana
- Verified all ELK services running

---

### 🔹 Log Ingestion & Parsing

- Auth logs ingested from `/var/log/auth.log`
- Apache access logs ingested from `/var/log/apache2/access.log`
- Logstash filters used:
  - Grok parsing for auth logs
  - Apache combined log parsing
- Events indexed into Elasticsearch with daily indices

---

### 🔹 Custom Log Analysis Scripts

#### Authentication Log Analysis
- Failed login detection
- Brute-force attack detection
- Sudo usage tracking

#### Web Log Analysis
- Top source IP identification
- HTTP status code analysis
- Detection of common web attack patterns

#### Real-Time Monitoring
- Live monitoring of auth and web logs
- SOC-style alerts generated in real time
- Alerts written to log file for evidence retention

---

### 🔹 Log Retention & Normalization

- Implemented log rotation using `logrotate`
- Daily rotation with 30-day retention
- Compression of archived logs
- Safe Apache reload during rotation
- Converted raw logs into JSON format for SIEM ingestion

---

### 🔹 Kibana Dashboards & Visualization

- Created SIEM index patterns
- Verified parsed fields in Discover
- Built visualizations:
  - Failed login attempts
  - Top source IPs
  - HTTP status codes
- Created SOC dashboard for monitoring

---

### 🔹 Testing & Validation

- Generated simulated attacks:
  - SSH brute-force attempts
  - SQL injection attempts
  - Path traversal attempts
- Verified:
  - Logstash ingestion
  - Elasticsearch indexing
  - Kibana visualization
  - Custom script detection
  - Real-time alerting
  - Log rotation and normalization

---

## ✅ Final Outcomes

✔ Centralized log management implemented  
✔ Authentication and web logs parsed and indexed  
✔ Custom SOC detection scripts created  
✔ Real-time alerting functional  
✔ Log retention and normalization enforced  
✔ Kibana dashboards operational  
✔ SOC-style monitoring validated  

---

## 🏁 Conclusion

- This lab demonstrated a full Security Information and Event Management (SIEM) implementation using the ELK Stack. Students gained hands-on experience with centralized logging, parsing, normalization, detection, alerting, retention, and visualization.
- The architecture and workflows implemented in this lab closely resemble real-world SOC environments used by security analysts and incident responders.

- These skills are essential for roles such as SOC Analyst, Blue Team Engineer, Incident Responder, and Security Operations Engineer.

---

🎯 Recruiter & SOC Relevance

This lab proves the ability to:
- Build a SIEM from scratch
- Detect authentication attacks
- Analyze web exploitation attempts
- Create SOC dashboards
- Implement log retention policies
- Perform real-time security monitoring

This is SOC-ready, production-grade work.
