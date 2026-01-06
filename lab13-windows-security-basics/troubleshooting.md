# 🛠️ Troubleshooting – Lab 13: Windows Security Basics

---

## Issue 1: Samba services fail to start

### Possible Causes:
- Incorrect smb.conf configuration
- Domain provision incomplete

### Solutions:
```bash
sudo testparm
sudo tail -20 /var/log/samba/samba.log
sudo systemctl restart smbd nmbd
````

---

## Issue 2: Users cannot authenticate to the domain

### Possible Causes:

* Password expired or locked
* Incorrect OU placement

### Solutions:

```bash
sudo samba-tool user show username
sudo samba-tool user setpassword username
```

---

## Issue 3: Group policies appear not applied

### Possible Causes:

* SYSVOL misconfiguration
* Scripts not executed

### Solutions:

* Verify policy files exist in SYSVOL
* Re-run policy scripts
* Review `/var/log/samba/security.log`

---

## Issue 4: Required services are blocked by firewall

### Possible Causes:

* Missing iptables rule
* Incorrect port number

### Solutions:

```bash
sudo iptables -L -n | grep port_number
sudo iptables -A INPUT -p tcp --dport port_number -j ACCEPT
```

---

## Issue 5: Too many dropped packets

### Possible Causes:

* Overly restrictive rules
* Misconfigured IP ranges

### Solutions:

```bash
sudo tail -50 /var/log/syslog | grep FIREWALL-DROPPED
sudo iptables -L -n -v | grep DROP
```

---

## Issue 6: Firewall rules lost after reboot

### Cause:

* Rules not saved

### Solution:

```bash
sudo iptables-save > /etc/iptables/rules.v4
```
