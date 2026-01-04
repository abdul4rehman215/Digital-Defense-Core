# 🧪 Lab 5: Digital Certificates and PKI

---

## 🎯 Objectives
By the end of this lab, students will be able to:
- Understand Public Key Infrastructure (PKI) components and certificate chains
- Generate and manage digital certificates using OpenSSL
- Verify certificate authenticity and validity programmatically
- Implement digital signature creation and verification
- Analyze certificate properties and expiration dates

---

## 📋 Prerequisites
- Basic understanding of asymmetric cryptography concepts
- Familiarity with Linux command line operations
- Basic Python programming knowledge
- Understanding of file system navigation

---

## 🖥️ Lab Environment
Pre-configured Ubuntu 24.04 LTS cloud-based Linux environment including:
- OpenSSL (latest version)
- Python 3.x with cryptography library installed
- Text editors (nano, vim)
- All required development tools

---

## 🧩 Task 1: Generate Self-Signed Certificates

### 🔹 Step 1: Create Working Directory
Create a working directory for the PKI lab and navigate into it.

---

### 🔹 Step 2: Generate Private Key and Self-Signed Certificate
Generate an RSA private key, create a Certificate Signing Request (CSR), and generate a self-signed certificate valid for 365 days.  
Examine the generated certificate to review its properties such as version, serial number, issuer, validity period, and public key information.

---

### 🔹 Step 3: Create Certificate Authority (CA)
Generate a private key for the Certificate Authority and create a self-signed CA certificate valid for 10 years.

---

### 🔹 Step 4: Create CA-Signed Server Certificate
Generate a server private key and CSR, sign the certificate using the CA, and verify the certificate chain to ensure trust.

---

## 🧩 Task 2: Certificate Verification with Python
Create a Python script to load certificates, display certificate details, verify validity periods, and programmatically validate certificate chains.

---

## 🧩 Task 3: Digital Signature Implementation
Implement digital signature creation and verification using RSA keys to ensure message authenticity and integrity.

---

## 🧩 Task 4: Certificate Expiration Monitoring
Create a Python-based monitoring script to detect certificate expiration status and provide warnings based on remaining validity.

---

## 🧩 Task 5: Multi-Level Certificate Chain
Create an intermediate Certificate Authority, issue an end-entity certificate, verify a multi-level certificate chain, and validate trust relationships programmatically.

---

## 🏁 Conclusion
This lab provided hands-on experience with Public Key Infrastructure (PKI).  
Students generated self-signed and CA-signed certificates, built root and intermediate CAs, verified certificate chains using OpenSSL and Python, implemented digital signatures, monitored certificate expiration, and validated multi-level certificate trust chains.
