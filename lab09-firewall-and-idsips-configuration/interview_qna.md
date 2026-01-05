# 📘 Interview Q&A – Lab 9: Firewall and IDS/IPS Configuration

---

### Q1. What is the role of a firewall in system security?
**A:** A firewall controls incoming and outgoing network traffic based on predefined security rules to prevent unauthorized access.

---

### Q2. What IDS/IPS tool did you configure in this lab?
**A:** Fail2Ban was configured as a host-based IDS/IPS to detect and prevent brute-force attacks.

---

### Q3. How does Fail2Ban detect malicious activity?
**A:** Fail2Ban monitors log files such as `/var/log/auth.log` for repeated failed login attempts and suspicious patterns.

---

### Q4. What happens when Fail2Ban detects multiple failed SSH login attempts?
**A:** Fail2Ban automatically bans the attacking IP address using firewall rules.

---

### Q5. What is a “jail” in Fail2Ban?
**A:** A jail defines the service being protected, detection filter, action to take, and ban parameters.

---

### Q6. Which firewall tool was used in this lab?
**A:** UFW (Uncomplicated Firewall) was used to manage firewall rules.

---

### Q7. Why was SSH explicitly allowed in UFW rules?
**A:** To prevent locking out the administrator after enabling the firewall.

---

### Q8. How did you test Fail2Ban without launching real attacks?
**A:** By injecting simulated failed SSH login entries into system logs using the `logger` command.

---

### Q9. How did you monitor both firewall and IDS activity together?
**A:** By creating a custom security monitoring script that displays Fail2Ban status, UFW rules, and security logs.

---

### Q10. What security principle does this lab demonstrate?
**A:** Defense-in-depth by combining firewall controls with automated intrusion prevention.

---
