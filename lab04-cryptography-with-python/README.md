# 🧪 Lab 04: Cryptography with Python

## 🎯 Objectives
By the end of this lab, you will be able to:
- Implement symmetric encryption using AES
- Implement asymmetric encryption using RSA
- Compare symmetric vs asymmetric encryption performance
- Apply cryptographic principles to secure data
- Implement hybrid encryption combining AES and RSA

---

## 📋 Prerequisites
- Basic Python programming (functions, classes, file I/O)
- Linux command line familiarity
- Understanding of encryption and decryption concepts

---

## 🖥️ Lab Environment
- Ubuntu 24.04 LTS (cloud lab environment)
- Python 3.x
- cryptography Python library

---

## 🧩 Tasks Performed

### Task 1: AES Symmetric Encryption
- Random AES key generation
- Password-derived key using PBKDF2
- Encryption and decryption of messages
- Saving and loading AES keys securely

### Task 2: RSA Asymmetric Encryption
- RSA public/private key generation
- Encryption and decryption
- Digital signature creation and verification
- Detection of message tampering

### Task 3: Encryption Performance Comparison
- Benchmarked AES vs RSA
- Measured encryption/decryption time
- Compared ciphertext sizes
- Identified real-world use cases

### Task 4: Hybrid Encryption
- AES used for bulk data encryption
- RSA used for AES key protection
- Simulated real-world TLS-style encryption

---

## 🏁 Conclusion
This lab demonstrated industry-standard cryptographic techniques using Python.  
AES provides fast bulk encryption, RSA enables secure key exchange and identity verification, and hybrid encryption combines both for real-world secure systems such as TLS/SSL.
