# 📘 Interview Q&A – Lab 20: Patch Management Automation

---

### Q1. What is patch management and why is it critical for system security?
Patch management ensures systems receive timely updates to fix vulnerabilities, reduce attack surfaces, and maintain system stability. Unpatched systems are one of the most common causes of breaches.

---

### Q2. Why is automation important in patch management?
Automation reduces human error, ensures consistency across systems, saves time, and enables scalable and regular patching in enterprise environments.

---

### Q3. What role does `unattended-upgrades` play in this lab?
`unattended-upgrades` automatically installs security updates without manual intervention, ensuring critical patches are applied even if administrators are unavailable.

---

### Q4. Why are pre-patch checks necessary before applying updates?
Pre-patch checks validate system health (disk space, memory availability, system snapshot) to prevent system failures during patch installation.

---

### Q5. How does vulnerability scanning improve patch decisions?
Vulnerability scanners like Lynis identify security weaknesses and misconfigurations, helping prioritize security-critical patches over routine updates.

---

### Q6. What is the purpose of creating system snapshots before patching?
System snapshots provide rollback readiness. If a patch causes instability or failure, administrators can analyze or restore system state.

---

### Q7. How does this lab handle security-only vs full updates?
Security-only updates are applied using `unattended-upgrades`, while full upgrades use `apt upgrade -y`, allowing flexible patch strategies.

---

### Q8. Why is logging and reporting important in patch management?
Logs and reports provide audit trails, compliance evidence, and visibility into patch success, failures, and system impact.

---

### Q9. How can this patch management system integrate with CI/CD pipelines?
The scripts can be triggered by cron jobs, CI/CD runners, or configuration management tools to ensure continuous security patching.

---

### Q10. Why is this lab considered production-ready rather than beginner-level?
It combines automation, vulnerability awareness, validation, rollback readiness, structured reporting, and dashboarding—matching real enterprise patch management workflows.
