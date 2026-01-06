# 🛠️ Troubleshooting – Lab 12: Endpoint Security & Hardening

---

## Issue 1: Unable to connect via SSH after hardening

### Possible Causes:
- SSH service not running
- Incorrect port configuration
- Firewall blocking SSH port

### Solutions:
```bash
sudo systemctl status ssh
sudo sshd -t
sudo ufw status verbose
````

Ensure port `2222` is allowed and SSH is listening on that port.

---

## Issue 2: SSH key authentication fails

### Possible Causes:

* Incorrect file permissions
* Public key not present in `authorized_keys`

### Solutions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
ls -la ~/.ssh/
```

---

## Issue 3: fail2ban not banning IP addresses

### Possible Causes:

* Incorrect jail configuration
* Wrong log file path
* SSH running on a non-default port

### Solutions:

```bash
sudo fail2ban-client status
sudo fail2ban-client status sshd
sudo fail2ban-client get sshd logpath
sudo tail -f /var/log/fail2ban.log
```

---

## Issue 4: Monitoring scripts do not run

### Possible Causes:

* Scripts not executable
* Incorrect script paths

### Solutions:

```bash
chmod +x ~/security-scripts/*.sh
ls -la ~/security-scripts/
```

---

## Issue 5: Cron job not executing scripts

### Possible Causes:

* Incorrect cron syntax
* Missing absolute paths
* Environment variables unavailable in cron

### Solutions:

```bash
crontab -l
```

Use absolute paths and log output to files for debugging.

---

## Issue 6: File integrity script always detects changes

### Possible Causes:

* Baseline recreated accidentally
* Files legitimately changed due to updates

### Solutions:

* Recreate baseline after system updates
* Review diff output carefully before taking action
