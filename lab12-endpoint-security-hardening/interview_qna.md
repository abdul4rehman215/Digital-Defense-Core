# 📘 Interview Q&A – Lab 12: Endpoint Security & Hardening

---

### Q1. What is endpoint security in Linux systems?
**A:** Endpoint security focuses on protecting individual Linux machines from unauthorized access, misuse, and attacks through hardening, access controls, monitoring, and automation.

---

### Q2. Why is SSH key-based authentication more secure than password authentication?
**A:** SSH keys use cryptographic key pairs that are resistant to brute-force and credential stuffing attacks, unlike passwords which can be guessed, reused, or stolen.

---

### Q3. Why was the default SSH port changed from 22 to 2222?
**A:** Changing the default port reduces noise from automated scanners and brute-force attacks targeting port 22, lowering exposure to opportunistic attacks.

---

### Q4. What is the purpose of disabling root login over SSH?
**A:** Disabling root login prevents attackers from directly targeting the highest-privileged account and enforces least-privilege access through individual user accounts.

---

### Q5. What role does fail2ban play in endpoint hardening?
**A:** fail2ban monitors authentication logs and automatically blocks IP addresses that exhibit malicious behavior such as repeated failed login attempts.

---

### Q6. How does fail2ban detect SSH brute-force attacks?
**A:** It analyzes `/var/log/auth.log` for multiple failed authentication attempts within a defined time window and triggers bans based on configured thresholds.

---

### Q7. Why are custom monitoring scripts important even when fail2ban is enabled?
**A:** Monitoring scripts provide visibility into successful logins, sudo usage, unusual access times, system load, and user account changes—areas not fully covered by fail2ban.

---

### Q8. What is file integrity monitoring?
**A:** File integrity monitoring detects unauthorized changes to critical system files by comparing current file hashes against a trusted baseline.

---

### Q9. Why is a “default deny” firewall policy recommended?
**A:** A default deny policy blocks all inbound traffic except explicitly allowed services, significantly reducing the system’s attack surface.

---

### Q10. What is the benefit of automating security checks with cron jobs?
**A:** Automation ensures continuous, consistent monitoring without manual intervention, enabling early detection of security incidents.
