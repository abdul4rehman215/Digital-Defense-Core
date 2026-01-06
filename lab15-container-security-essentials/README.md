# 🧪 Lab 15: Container Security Essentials

## 📌 Overview
This lab provides hands-on experience with **production-grade container security** using Docker and open-source security tools. It covers **image vulnerability scanning, runtime hardening, access controls, monitoring, and compliance validation**, mirroring real-world DevSecOps and SOC workflows.

The lab is designed to demonstrate **defense-in-depth for containerized environments**, combining preventive, detective, and corrective controls.

---

## 🎯 Objectives
By the end of this lab, you will be able to:

- Understand fundamental container security concepts and common vulnerabilities
- Scan Docker images for known vulnerabilities using Trivy
- Enforce security gates in CI/CD pipelines
- Implement Docker security features such as user namespaces
- Apply runtime hardening (capabilities, read-only filesystems, resource limits)
- Configure AppArmor security profiles for containers
- Implement secure container networking
- Monitor container runtime behavior using Falco
- Validate Docker security posture using Docker Bench Security
- Apply enterprise-grade Docker security baselines

---

## 📋 Prerequisites

Before starting this lab, you should have:

- Basic Linux command-line proficiency
- Familiarity with Docker concepts and commands
- Understanding of Linux users, permissions, and processes
- Basic knowledge of networking fundamentals
- Ubuntu 20.04+ LTS system with sudo privileges

---

## 🖥️ Lab Environment

| Component | Details |
|---------|--------|
| OS | Ubuntu 20.04+ LTS |
| Container Runtime | Docker Engine |
| User | cloud-lab-user |
| Shell | bash |
| Tools Used | Docker, Trivy, Falco, Docker Bench Security |

---

## 🧩 Task 1: Docker Image Vulnerability Scanning

### 🔹 Tool Used: Trivy

Trivy is an open-source vulnerability scanner that detects:
- OS package vulnerabilities
- Language-specific dependencies
- Misconfigurations and secrets

### 🔸 Installed Components
- Trivy CLI
- Vulnerability database (auto-updated)

### 🔸 Images Scanned
- `nginx:1.18`
- `node:14-alpine`
- `python:3.8-slim`

### 🔸 Key Findings
- Legacy images (Debian-based) contain significantly more vulnerabilities
- Alpine-based images have smaller attack surfaces
- High and Critical vulnerabilities can be programmatically enforced

### 🔐 CI/CD Security Gate
A CI-style script blocks deployments if:
- Any CRITICAL vulnerabilities exist
- HIGH vulnerabilities exceed threshold

➡️ Script: `scripts/container-security-scan.sh`

---

## 🧩 Task 2: Docker Security Features Implementation

### 🔹 User Namespace Remapping
- Prevents container root from mapping to host root
- Reduces impact of container escapes

Status verified:
```

docker info | grep -i "user namespace"
User Namespace: enabled

```

### 🔹 Runtime Hardening Controls
Implemented:
- Non-root user execution
- Dropped Linux capabilities
- Read-only root filesystem
- tmpfs for writable paths
- Restricted resource usage (CPU, memory, PIDs)
- Restart policies

### 🔹 AppArmor Security Profiles
- Custom AppArmor profile for nginx containers
- Enforced Mandatory Access Control (MAC)
- Restricted filesystem and kernel access

---

## 🧩 Task 3: Network Security & Isolation

### 🔹 Secure Docker Network
- Custom bridge network
- Fixed IP addressing
- Internal-only communication
- External access restricted

### 🔹 Verified Outcomes
- Containers can communicate internally
- External internet access blocked
- Network segmentation enforced

---

## 🧩 Task 4: Runtime Monitoring & Compliance

### 🔹 Falco Runtime Threat Detection
Falco monitors:
- Suspicious process execution
- Privilege escalation attempts
- Interactive shells inside containers
- Network misuse

Custom rules implemented:
- Suspicious container activity
- Privilege escalation detection

Alerts logged in:
```

/var/log/falco.log

```

---

### 🔹 Docker Bench Security
Docker Bench validates:
- Docker daemon configuration
- Host-level security controls
- Runtime security settings

Results showed:
- User namespace remapping enabled
- AppArmor enforced
- Minor warnings for non-read-only containers

---

## 🧩 Task 5: Docker Security Baseline

### 🔹 Baseline Features Applied
- Default deny inter-container communication
- User namespace enforcement
- Seccomp syscall restrictions
- No-new-privileges enforcement
- Secure logging configuration
- Live restore enabled

➡️ Script: `scripts/docker-security-baseline.sh`

---

## 🧹 Cleanup
A cleanup script removes:
- Test containers
- Custom networks
- Temporary scan files
- Unused images

➡️ Script: `scripts/cleanup.sh`

---

## 🏁 Final Conclusion

This lab demonstrated **end-to-end container security engineering**, covering:

- Preventive Controls:
  - Image vulnerability scanning
  - Secure baselines
  - Hardening configurations

- Detective Controls:
  - Runtime monitoring with Falco
  - Log analysis and alerts

- Corrective Controls:
  - Deployment blocking
  - Cleanup automation
  - Compliance validation

These techniques reflect **real-world DevSecOps and SOC practices** used in modern cloud-native environments.

---

## 🎯 Skills Demonstrated

- Container vulnerability management
- Docker hardening & isolation
- Runtime threat detection
- Security automation
- Compliance validation
- Cloud-native security engineering
