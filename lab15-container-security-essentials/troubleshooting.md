# 🛠️ Troubleshooting Guide – Lab 15: Container Security Essentials

This document provides **detailed troubleshooting steps** for common issues encountered while performing **container security hardening**, **vulnerability scanning**, and **runtime monitoring** using Docker, Trivy, Falco, and Docker Bench Security.

All solutions are **hands-on**, **production-relevant**, and aligned with **real-world DevSecOps and SOC practices**.

---

## 🔴 Issue 1: Docker service fails to start after enabling user namespaces

### Symptoms
- `docker info` shows `User Namespace: disabled`
- Docker service fails to start
- Errors in `journalctl -u docker`

### Root Cause
User namespace remapping requires:
- Proper `/etc/subuid` and `/etc/subgid` configuration
- Clean Docker state
- Kernel support for user namespaces

### Solution

#### Step 1: Verify kernel support
```bash
cat /proc/sys/user/max_user_namespaces
````

Expected output:

```
> 0
```

#### Step 2: Verify subuid and subgid entries

```bash
cat /etc/subuid
cat /etc/subgid
```

Ensure entries exist:

```
dockremap:165536:65536
```

#### Step 3: Reset Docker state (⚠️ destructive)

```bash
sudo systemctl stop docker
sudo rm -rf /var/lib/docker
sudo systemctl start docker
```

#### Step 4: Verify

```bash
docker info | grep -i "user namespace"
```

Expected:

```
User Namespace: enabled
```

---

## 🔴 Issue 2: Trivy scan fails or returns empty results

### Symptoms

* Trivy scan fails with database errors
* Scan output is empty
* Network-related errors

### Root Cause

* Outdated vulnerability database
* Corrupted cache
* Network restrictions

### Solution

#### Step 1: Update Trivy database

```bash
trivy image --download-db-only
```

#### Step 2: Clear cache

```bash
trivy clean --all
```

#### Step 3: Retry scan

```bash
trivy image nginx:latest
```

---

## 🔴 Issue 3: Container fails to start with AppArmor profile

### Symptoms

* Container exits immediately
* Error related to AppArmor profile
* `apparmor_parser` errors

### Root Cause

* Incorrect AppArmor profile syntax
* Profile not loaded
* AppArmor not enabled

### Solution

#### Step 1: Verify AppArmor status

```bash
sudo aa-status
```

#### Step 2: Reload profile manually

```bash
sudo apparmor_parser -r -W /etc/apparmor.d/containers/docker-nginx
```

#### Step 3: Test container

```bash
docker run --rm \
 --security-opt apparmor=docker-nginx \
 nginx:alpine
```

---

## 🔴 Issue 4: Falco service not detecting container activity

### Symptoms

* Falco running but no alerts
* `/var/log/falco.log` empty

### Root Cause

* Falco rules not loaded
* Kernel driver issues
* Falco service not restarted after rule changes

### Solution

#### Step 1: Verify Falco status

```bash
sudo systemctl status falco
```

#### Step 2: Verify rules loaded

```bash
sudo grep "Rule loaded" /var/log/falco.log
```

#### Step 3: Restart Falco

```bash
sudo systemctl restart falco
```

#### Step 4: Trigger test event

```bash
docker exec secure-nginx curl http://example.com
```

Expected Falco alert:

```
WARNING Suspicious activity in container
```

---

## 🔴 Issue 5: Docker Bench Security shows multiple WARN results

### Symptoms

* Multiple WARN findings
* Failing CIS checks

### Root Cause

* Docker defaults not hardened
* Missing security flags

### Solution

#### Step 1: Review warnings

```bash
cat /tmp/docker-bench-results.log
```

#### Step 2: Apply baseline configuration

```bash
sudo cp /tmp/secure-daemon.json /etc/docker/daemon.json
sudo cp /tmp/seccomp-profile.json /etc/docker/
sudo systemctl restart docker
```

#### Step 3: Re-run benchmark

```bash
sudo ./docker-bench-security.sh
```

---

## 🔴 Issue 6: Container cannot write files (unexpected failures)

### Symptoms

* Application fails to write files
* Errors like `Read-only file system`

### Root Cause

* Read-only filesystem enabled intentionally

### Solution

Allow writable directories explicitly:

```bash
docker run \
 --read-only \
 --tmpfs /tmp \
 --tmpfs /var/run \
 my-container
```

Only required paths should be writable.

---

## 🔴 Issue 7: Resource-limited container crashes or behaves unexpectedly

### Symptoms

* Container exits unexpectedly
* Out-of-memory errors

### Root Cause

* Aggressive memory or CPU limits
* Insufficient resource allocation

### Solution

#### Step 1: Monitor resource usage

```bash
docker stats container-name
```

#### Step 2: Adjust limits

```bash
--memory=256m --cpus="1.0"
```

Apply least privilege **without breaking functionality**.

---

## 🔴 Issue 8: Secure Docker network cannot access external internet

### Symptoms

* Containers cannot reach external IPs
* `ping 8.8.8.8` fails

### Root Cause

* Network isolation configured intentionally
* No outbound NAT configured

### Solution

This is **expected behavior** for isolated networks.

If outbound access is required:

```bash
docker network connect bridge container-name
```

---

## 🔴 Issue 9: CI/CD scan script always fails builds

### Symptoms

* Pipeline always blocked
* High vulnerability count

### Root Cause

* Using outdated base images
* No vulnerability remediation process

### Solution

#### Step 1: Switch to minimal images

```bash
nginx:alpine
python:3.8-alpine
```

#### Step 2: Rebuild images frequently

```bash
docker build --no-cache .
```

#### Step 3: Adjust thresholds cautiously

```bash
HIGH > 5 → Review case-by-case
```

---

## 🔴 Issue 10: Docker daemon logs too large

### Symptoms

* Large disk usage
* `/var/lib/docker` growing rapidly

### Root Cause

* No log rotation configured

### Solution

Configure log rotation:

```json
"log-opts": {
  "max-size": "10m",
  "max-file": "3"
}
```

Restart Docker:

```bash
sudo systemctl restart docker
```

---

## 🧹 Cleanup Issues

### Problem: Containers/networks left running

```bash
docker ps -aq | xargs docker rm -f
docker network prune -f
docker image prune -f
```

---

## ✅ Best Practices to Avoid Issues

✔ Always scan images before deployment
✔ Use minimal base images
✔ Run containers as non-root
✔ Enable runtime monitoring
✔ Apply resource limits
✔ Log and audit continuously

---

## 🏁 End of Troubleshooting – Lab 15

This troubleshooting guide ensures **operational resilience**, **security stability**, and **production readiness** for containerized environments.
