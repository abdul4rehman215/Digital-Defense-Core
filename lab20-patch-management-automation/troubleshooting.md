# 🛠️ Troubleshooting – Lab 20: Patch Management Automation

---

## Issue 1: Permission Denied Errors

### Symptoms
- Scripts fail with permission errors
- Unable to run system commands

### Resolution
```bash
chmod +x scripts/*.py
sudo usermod -aG sudo $USER
````

Log out and log back in if sudo group changes were made.

---

## Issue 2: Package Installation Fails

### Symptoms

* `apt install` fails
* Broken package dependencies

### Resolution

```bash
sudo apt update
sudo apt --fix-broken install
df -h
```

Ensure sufficient disk space and valid repositories.

---

## Issue 3: Lynis Not Found

### Symptoms

* `lynis: command not found`
* Vulnerability scan fails

### Resolution

```bash
sudo apt install lynis
which lynis
lynis --version
```

Verify Lynis exists in `$PATH`.

---

## Issue 4: Reports Not Generating

### Symptoms

* No JSON reports created
* Dashboard missing files

### Resolution

```bash
mkdir -p reports logs
chmod -R 755 reports logs
```

Ensure write permissions exist for the executing user.

---

## Issue 5: Unattended Upgrades Not Running

### Symptoms

* Security updates not applied automatically

### Resolution

```bash
sudo systemctl status unattended-upgrades
sudo unattended-upgrade --dry-run
```

Verify `/etc/apt/apt.conf.d/20auto-upgrades` configuration.

---

## Issue 6: Python Module Import Errors

### Symptoms

* `ModuleNotFoundError`
* Script import failures

### Resolution

```bash
pip3 install pyyaml schedule psutil requests
```

Ensure correct Python version:

```bash
python3 --version
```

---

## Issue 7: Disk or Memory Check Fails

### Symptoms

* Pre-patch checks fail
* Patch cycle aborted

### Resolution

```bash
df -h
free -m
```

Free disk space or memory before rerunning patch cycle.

---

## General Recovery Tips

* Review logs:

```bash
cat logs/patch_activity.log
```

* Re-run individual components before full automation
* Validate system snapshots exist in `reports/`

---

## Best Practice Reminder
- Always test automated patching in staging environments before production deployment.
