# 📘 Interview Q&A – Lab 15: Container Security Essentials

This document contains **interview-focused questions and answers** derived directly from the practical work performed in Lab 15.  
All answers are **hands-on**, **scenario-based**, and aligned with **real-world DevSecOps, SOC, and Cloud Security roles**.

---

## Q1. Why is container security critical in modern DevOps environments?

Container security is critical because containers often run **production workloads**, handle **sensitive data**, and may execute with elevated privileges. A compromised container can lead to:
- Unauthorized access to applications
- Lateral movement inside container networks
- Privilege escalation to the host system
- Supply chain attacks via vulnerable images

Modern DevOps relies heavily on automation and rapid deployments, so security must be **built-in**, not added later.

---

## Q2. What types of vulnerabilities does Trivy detect in container images?

Trivy detects:
- OS-level vulnerabilities (Debian, Alpine, Ubuntu packages)
- Language-specific vulnerabilities (Node.js, Python, Go, etc.)
- Misconfigurations
- Secrets accidentally embedded in images
- Dependency-related CVEs

This allows security teams to detect risks **before containers reach production**.

---

## Q3. Why did the nginx:1.18 image contain more vulnerabilities than node:14-alpine?

The `nginx:1.18` image is based on **Debian**, which includes more system packages, increasing the attack surface.  
In contrast, `node:14-alpine` uses **Alpine Linux**, which is:
- Minimal
- Lightweight
- Fewer installed dependencies

Smaller base images generally lead to **fewer vulnerabilities**.

---

## Q4. What is the purpose of blocking deployments in CI/CD pipelines after vulnerability scans?

Blocking deployments prevents images with **known high or critical vulnerabilities** from reaching production.  
This:
- Reduces breach risk
- Enforces security accountability
- Aligns with DevSecOps best practices
- Shifts security “left” in the development lifecycle

Automated gates ensure security is **consistent and non-optional**.

---

## Q5. What is Docker user namespace remapping and why is it important?

Docker user namespace remapping maps container users (including root) to **unprivileged host users**.  
This prevents attackers from gaining root access on the host even if they compromise a container.

It significantly reduces:
- Privilege escalation risks
- Impact of container escapes

---

## Q6. Why were Linux capabilities dropped for running containers?

Linux capabilities define what privileged operations a process can perform.  
Dropping unnecessary capabilities:
- Reduces attack surface
- Prevents privilege abuse
- Limits damage if a container is compromised

Principle applied: **Least Privilege**.

---

## Q7. What security benefit does a read-only filesystem provide to containers?

A read-only filesystem:
- Prevents attackers from modifying system files
- Stops malware from being written to disk
- Blocks persistence mechanisms

Writable paths are explicitly limited using `tmpfs`.

---

## Q8. Why are AppArmor profiles used with Docker containers?

AppArmor enforces **Mandatory Access Control (MAC)** by:
- Restricting filesystem access
- Blocking kernel-level operations
- Preventing unauthorized system interactions

Even if a container is compromised, AppArmor limits what the attacker can do.

---

## Q9. What role does Falco play in container security?

Falco provides **runtime threat detection** by monitoring:
- Process executions
- File access
- Network activity
- Privilege escalation attempts

It detects suspicious behavior **during container execution**, not just at build time.

---

## Q10. How does Falco differ from vulnerability scanners like Trivy?

| Tool | Purpose |
|----|--------|
| Trivy | Pre-deployment vulnerability scanning |
| Falco | Runtime behavior monitoring |

Trivy detects known CVEs, while Falco detects **unknown or zero-day behavior patterns**.

## ✅ End of Interview Q&A – Lab
