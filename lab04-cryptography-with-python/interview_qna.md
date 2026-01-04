# 📘 Interview Q&A – Lab 4: Cryptography with Python

Q1. What is the main difference between symmetric and asymmetric encryption?  
A: Symmetric encryption uses a single shared key (AES), while asymmetric encryption uses a public–private key pair (RSA).

Q2. Which algorithm did you use for symmetric encryption in this lab?  
A: AES implemented using the Fernet module from Python’s cryptography library.

Q3. How was the AES encryption key generated in your implementation?  
A: Either randomly using Fernet.generate_key() or derived from a password using PBKDF2.

Q4. Why was PBKDF2 used for password-based key generation?  
A: PBKDF2 strengthens keys using salt and many iterations, protecting against brute-force attacks.

Q5. What limitation did you observe with RSA encryption?  
A: RSA cannot encrypt large data directly and has a strict message size limit.

Q6. Which padding scheme was used with RSA encryption?  
A: OAEP padding with SHA-256.

Q7. How did you ensure message integrity with RSA?  
A: By creating and verifying digital signatures using private and public keys.

Q8. What did the encryption performance comparison show?  
A: AES is much faster and suitable for large data, while RSA is slower and intended for small data or key exchange.

Q9. What is hybrid encryption and why is it used?  
A: Hybrid encryption encrypts data with AES and secures the AES key with RSA, combining speed and security.

Q10. Where is hybrid encryption commonly used in real systems?  
A: TLS/SSL, secure messaging applications, and enterprise data protection systems.
