# 📘 Interview Q&A – Lab 5: Digital Certificates and PKI

---

### Q1. What is Public Key Infrastructure (PKI)?
**Answer:**  
PKI is a framework that manages digital certificates, public–private key pairs, and trust relationships to enable secure communication, authentication, and data integrity over untrusted networks.

---

### Q2. What are the main components of PKI?
**Answer:**  
The main components are Certificate Authority (CA), digital certificates, public and private keys, certificate revocation lists (CRLs), and certificate validation mechanisms.

---

### Q3. What is the difference between a self-signed certificate and a CA-signed certificate?
**Answer:**  
A self-signed certificate is signed by its own private key and is not trusted by default, while a CA-signed certificate is signed by a trusted Certificate Authority and validated through a certificate chain.

---

### Q4. Which OpenSSL commands were used to generate a self-signed certificate in this lab?
**Answer:**  
`openssl genrsa` to generate the private key,  
`openssl req` to create the CSR, and  
`openssl x509 -signkey` to generate the self-signed certificate.

---

### Q5. What is the role of a Certificate Authority (CA)?
**Answer:**  
A Certificate Authority verifies identities and signs certificates, establishing trust between entities in a PKI hierarchy.

---

### Q6. How did you verify a certificate chain in this lab?
**Answer:**  
By using the `openssl verify` command and a Python script that checks issuer–subject relationships and validates signatures.

---

### Q7. What certificate fields were analyzed during inspection?
**Answer:**  
Subject, issuer, validity period, serial number, signature algorithm, and public key type.

---

### Q8. How was certificate expiration checked programmatically?
**Answer:**  
By comparing the current date with the `not_valid_after` field using Python’s `cryptography` library.

---

### Q9. What cryptographic algorithm was used for digital signatures?
**Answer:**  
RSA with SHA-256 hashing and PSS padding.

---

### Q10. What is the purpose of an intermediate Certificate Authority?
**Answer:**  
An intermediate CA creates a layered trust model between the root CA and end-entity certificates, improving security and limiting root CA exposure.

---
