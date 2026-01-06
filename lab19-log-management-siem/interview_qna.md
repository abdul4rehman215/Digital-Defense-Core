#📘 Interview Q&A – Lab 19: Log Management with SIEM Tools (ELK Stack)

---

## Q1. What is a SIEM and why is it important in a SOC environment?
A SIEM (Security Information and Event Management) system centralizes logs from
multiple sources, correlates events, and helps detect security incidents in real time.

---

## Q2. What are the main components of the ELK Stack?
- **Elasticsearch** – Stores and indexes logs
- **Logstash** – Ingests and parses log data
- **Kibana** – Visualizes logs and security events

---

## Q3. Why is log normalization important?
Normalization converts raw logs into structured formats like JSON, enabling
efficient searching, correlation, dashboards, and alerting.

---

## Q4. How does Logstash help in threat detection?
Logstash uses filters such as `grok` to extract fields from logs, making it easier
to identify brute-force attempts, suspicious web requests, and anomalies.

---

## Q5. What types of attacks were detected in this lab?
- SSH brute-force attempts
- Failed authentication events
- SQL injection attempts
- Path traversal attacks
- Suspicious HTTP status codes

---

## Q6. Why is log retention and rotation critical?
It prevents disk exhaustion, supports compliance requirements, and ensures
historical logs are available for investigations and audits.

---

## Q7. How does Kibana help SOC analysts?
Kibana provides dashboards, visualizations, and real-time log discovery to
quickly identify anomalies and investigate incidents.

---

## Q8. What is the purpose of real-time log monitoring scripts?
They provide immediate alerts for critical events, complementing SIEM dashboards
with instant detection and response capabilities.

---

## Q9. How can SIEM dashboards help detect brute-force attacks?
By visualizing failed login counts per IP or user, analysts can quickly spot
abnormal spikes indicating brute-force activity.

---

## Q10. Why is the ELK Stack considered SOC-ready?
Because it demonstrates real-world capabilities such as centralized logging,
parsing, correlation, alerting, retention, and security visualization used in
production SOC environments.
