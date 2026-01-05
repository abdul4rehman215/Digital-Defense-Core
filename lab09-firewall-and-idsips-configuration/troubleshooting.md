# 🛠️ Troubleshooting – Lab 9: Firewall and IDS/IPS Configuration

---

## Issue 1: Fail2Ban service is not running

### Problem  
Fail2Ban service does not start or is inactive after installation.

### Solution  
- Check service status:
  ```bash
  sudo systemctl status fail2ban
  ````

* Restart the service:

  ```bash
  sudo systemctl restart fail2ban
  ```
* Enable service on boot:

  ```bash
  sudo systemctl enable fail2ban
  ```

---

## Issue 2: Fail2Ban does not ban attacking IPs

### Problem

Failed SSH attempts are logged but no IP is banned.

### Solution

* Verify SSH jail is enabled:

  ```bash
  sudo fail2ban-client status
  ```
* Check SSH jail status:

  ```bash
  sudo fail2ban-client status sshd
  ```
* Ensure correct log path is configured:

  ```
  logpath = /var/log/auth.log
  ```
* Confirm `maxretry`, `bantime`, and `findtime` values in `jail.local`.

---

## Issue 3: Fail2Ban configuration changes not applied

### Problem

Modifications to `jail.local` have no effect.

### Solution

* Never edit `jail.conf` directly.
* Always restart Fail2Ban after changes:

  ```bash
  sudo systemctl restart fail2ban
  ```
* Check for configuration syntax errors:

  ```bash
  sudo fail2ban-client reload
  ```

---

## Issue 4: UFW blocks SSH access after enabling firewall

### Problem

SSH connection is lost after enabling UFW.

### Solution

* Always allow SSH before or immediately after enabling UFW:

  ```bash
  sudo ufw allow ssh
  ```

  or

  ```bash
  sudo ufw allow 22/tcp
  ```
* Verify rule exists:

  ```bash
  sudo ufw status
  ```

---

## Issue 5: UFW rules not working as expected

### Problem

Allowed services are unreachable or blocked unexpectedly.

### Solution

* Check firewall status:

  ```bash
  sudo ufw status verbose
  ```
* List numbered rules:

  ```bash
  sudo ufw status numbered
  ```
* Remove conflicting rules:

  ```bash
  sudo ufw delete <rule-number>
  ```

---

## Issue 6: Fail2Ban test does not trigger a ban

### Problem

Test script runs but no IP is banned.

### Solution

* Ensure test log entries match SSH failure format.
* Verify test IP is not whitelisted in `ignoreip`.
* Check auth log entries:

  ```bash
  sudo tail /var/log/auth.log
  ```
* Re-run test after restarting Fail2Ban.

---

## Issue 7: UFW logs not appearing

### Problem

Firewall blocks occur but no logs are visible.

### Solution

* Enable UFW logging:

  ```bash
  sudo ufw logging on
  ```
* Check log file:

  ```bash
  sudo tail -f /var/log/ufw.log
  ```
* Verify rsyslog is running:

  ```bash
  sudo systemctl status rsyslog
  ```

---

## Issue 8: Security monitoring script shows incomplete data

### Problem

Dashboard script does not display Fail2Ban or UFW output correctly.

### Solution

* Run script with proper permissions:

  ```bash
  sudo ./security_monitor.sh
  ```
* Ensure Fail2Ban and UFW services are running.
* Verify log file permissions.

---

## Issue 9: Firewall reset removes all rules

### Problem

Accidental firewall reset clears all configured rules.

### Solution

* Reapply essential rules:

  ```bash
  sudo ufw allow ssh
  sudo ufw allow http
  sudo ufw allow https
  ```
* Re-enable UFW if required:

  ```bash
  sudo ufw enable
  ```

---

## Issue 10: Authentication log file not accessible

### Problem

Fail2Ban cannot read `/var/log/auth.log`.

### Solution

* Check file permissions:

  ```bash
  ls -l /var/log/auth.log
  ```
* Ensure Fail2Ban runs with required privileges.
* Verify correct log path is set in SSH jail.

---

## ✅ General Best Practices

* Always test firewall rules before logging out.
* Restart Fail2Ban after every configuration change.
* Monitor logs regularly for early threat detection.
* Combine firewall rules with IDS/IPS for defense-in-depth.

---

