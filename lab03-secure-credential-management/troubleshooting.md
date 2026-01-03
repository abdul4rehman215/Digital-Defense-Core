# 🛠️ Troubleshooting – Lab 03: Secure Credential Management

## Issue 1: ModuleNotFoundError – cryptography / bcrypt
**Cause:** Required Python packages not installed  
**Solution:**
```
pip3 install --user cryptography bcrypt
```
## Issue 2: Permission Denied When Running Scripts

### Cause: Script not executable
Solution:
```
chmod +x script_name.py
```
## Issue 3: Wrong Master Password

### Cause: Incorrect password used to decrypt credential store
Solution:

- Delete credentials.enc and salt.key
- Reinitialize credential storage
```
rm credentials.enc salt.key
```
## Issue 4: Import Errors Between Python Files

### Cause: Files not in same directory or incorrect interpreter
Solution:

- Ensure all Python scripts are in the same directory

Run using:
```
python3 script_name.py
```
## Issue 5: Password Validation Always Fails

### Cause: Password does not meet policy requirements
Solution:

- Include uppercase, lowercase, digits, and special characters
- Avoid common weak patterns

---

## ✅ Final Verification Checklist – Lab 03

- ✔ Password policy enforcement working
- ✔ Secure password generation validated
- ✔ Credentials encrypted using Fernet (AES)
- ✔ PBKDF2 used for key derivation (100,000 iterations)
- ✔ Passwords hashed using bcrypt
- ✔ Credential storage protected with master password
- ✔ Audit system initialized successfully
- ✔ All scripts executable and documented
- ✔ Secrets excluded via .gitignore
- ✔ Portfolio-ready structure maintained

