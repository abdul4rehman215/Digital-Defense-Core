# 🛠️ Troubleshooting – Lab 16: Cloud Security Basics

This document covers common issues encountered during Lab 16 and provides clear, command-level solutions.  
All troubleshooting steps align with enterprise cloud security operations.

---

## Issue 1: Permission Denied Errors

### Symptoms
- Scripts fail with "Permission denied"
- Users cannot execute lab scripts
- Access to `/opt/cloud-security-lab` is restricted

### Root Cause
Incorrect file ownership or missing executable permissions.

### Solution
Fix ownership and permissions:

```bash
sudo chown -R root:root /opt/cloud-security-lab
sudo chmod -R 755 /opt/cloud-security-lab
sudo chmod +x /opt/cloud-security-lab/*.sh
````

Verify permissions:

```bash
ls -l /opt/cloud-security-lab
```

---

## Issue 2: IAM Policy Enforcement Not Working

### Symptoms

* All users are allowed or denied incorrectly
* Policy checks do not match expected roles

### Root Cause

Users not added to correct groups or group membership not refreshed.

### Solution

Verify group membership:

```bash
groups cloud-admin
groups cloud-developer
groups cloud-readonly
groups cloud-auditor
```

Re-add user to group if missing:

```bash
sudo usermod -a -G cloud-admins cloud-admin
```

Reload group membership:

```bash
newgrp cloud-admins
```

---

## Issue 3: MFA Setup Fails

### Symptoms

* `google-authenticator` fails to run
* QR code not generated
* MFA setup aborts

### Root Cause

Missing PAM modules or incorrect user execution.

### Solution

Ensure dependencies are installed:

```bash
sudo apt install -y libpam-google-authenticator qrencode
```

Run MFA setup as root but for target user:

```bash
sudo /opt/cloud-security-lab/setup-mfa.sh cloud-admin
```

Verify MFA secret exists:

```bash
ls -a /home/cloud-admin | grep google_authenticator
```

---

## Issue 4: Firewall Blocking Legitimate Access

### Symptoms

* SSH access blocked
* Web ports not accessible
* Unexpected connectivity failures

### Root Cause

Overly restrictive UFW rules.

### Solution

Check firewall status:

```bash
sudo ufw status verbose
```

Temporarily disable firewall for testing:

```bash
sudo ufw disable
```

Re-enable after validation:

```bash
sudo ufw --force enable
```

Re-add required rules if missing:

```bash
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

---

## Issue 5: Network Monitoring Script Produces No Output

### Symptoms

* Log files remain empty
* No alerts generated

### Root Cause

Log directory missing or script not executable.

### Solution

Ensure directories exist:

```bash
sudo mkdir -p /opt/cloud-security-lab/logs
```

Ensure script is executable:

```bash
sudo chmod +x /opt/cloud-security-lab/network-monitor.sh
```

Run manually:

```bash
sudo /opt/cloud-security-lab/network-monitor.sh
```

Check logs:

```bash
tail -20 /opt/cloud-security-lab/logs/network-monitor.log
```

---

## Issue 6: Encryption or Decryption Fails

### Symptoms

* OpenSSL errors
* Decrypted file missing or corrupted

### Root Cause

Missing encryption keys or wrong key name.

### Solution

Verify active keys:

```bash
ls -l /opt/cloud-security-lab/keys/active
```

Regenerate keys if required:

```bash
sudo rm -f /opt/cloud-security-lab/keys/active/*.key
sudo /opt/cloud-security-lab/key-manager.sh
```

Retry encryption:

```bash
sudo /opt/cloud-security-lab/key-manager.sh encrypt_file /tmp/test.txt data-encryption
```

---

## Issue 7: Fail2Ban Not Banning IPs

### Symptoms

* Failed SSH attempts not blocked
* Fail2Ban reports zero bans

### Root Cause

Incorrect jail configuration or service not running.

### Solution

Check Fail2Ban status:

```bash
sudo systemctl status fail2ban
sudo fail2ban-client status sshd
```

Restart Fail2Ban:

```bash
sudo systemctl restart fail2ban
```

Verify jail configuration:

```bash
sudo nano /etc/fail2ban/jail.local
```

---

## Issue 8: Backup Script Fails

### Symptoms

* Backup not created
* Encrypted file missing
* Restore fails

### Root Cause

Missing directories or incorrect encryption key.

### Solution

Verify backup directory:

```bash
ls -l /opt/cloud-security-lab/backups
```

Manually test backup:

```bash
sudo /opt/cloud-security-lab/secure-backup.sh create
```

Verify checksum:

```bash
sha256sum /opt/cloud-security-lab/backups/*.checksum
```

---

## Issue 9: Security Audit Script Errors

### Symptoms

* Audit script exits early
* HTML report not generated

### Root Cause

Missing utilities or insufficient permissions.

### Solution

Ensure required tools are installed:

```bash
sudo apt install -y net-tools ufw
```

Run audit as root:

```bash
sudo /opt/cloud-security-lab/security-audit.sh
```

Verify output files:

```bash
ls -l /opt/cloud-security-lab/logs
```

---

## Issue 10: Final Verification Script Fails

### Symptoms

* Verification incomplete
* Some checks fail

### Root Cause

One or more lab components not configured correctly.

### Solution

Run verification step-by-step:

```bash
sudo /opt/cloud-security-lab/final-verification.sh
```

Manually validate failing sections:

```bash
ufw status
systemctl is-active fail2ban
ls -l /opt/cloud-security-lab/keys/active
```

---

## Final Notes

* Always run scripts with `sudo` unless explicitly stated otherwise
* Ensure lab directory structure is preserved
* Logs are the primary source of truth during troubleshooting
* Treat this environment like a real cloud security audit
