# 📘 Interview Q&A – Lab 03: Secure Credential Management

Q1. Why should passwords never be stored in plaintext?  
A: Plaintext passwords can be directly read if compromised, leading to full account takeover.

Q2. How did you enforce a strong password policy in this lab?  
A: By validating length, uppercase, lowercase, digits, special characters, and blocking weak patterns using Python.

Q3. Which Python module was used to securely generate random passwords?  
A: The secrets module, which provides cryptographically secure randomness.

Q4. How did you ensure generated passwords always met the policy?  
A: Each generated password was revalidated against the password policy before being accepted.

Q5. What hashing algorithm was used for storing user passwords?  
A: bcrypt, which provides salted and computationally expensive password hashing.

Q6. Why is bcrypt preferred over simple hashing like SHA-256 for passwords?  
A: Bcrypt is slow and salted, making brute-force and rainbow table attacks harder.

Q7. How were credentials encrypted before storage?  
A: Using Fernet symmetric encryption with a key derived via PBKDF2.

Q8. What is the role of PBKDF2 in this lab?  
A: It derives a strong encryption key from the master password using many iterations.

Q9. What files were created for secure credential storage?  
A: credentials.enc for encrypted data and salt.key for key derivation.

Q10. Why is credential auditing important in secure systems?  
A: Auditing helps track credential activity and detect misuse or policy violations early.
