# 🧰 Troubleshooting – Lab 4: Cryptography with Python

## Issue 1: ImportError – cryptography module not found
**Cause:** Python cryptography library not installed.  
**Fix:**
```bash
pip3 install --upgrade cryptography --user
```
## Issue 2: RSA Message Too Large Error
**Cause:** RSA encryption has strict message size limits.
**Fix:**

- Keep RSA messages under ~190 bytes
- Use hybrid encryption for large data

## Issue 3: Permission Denied on Key Files

**Cause:** Insecure file permissions.
**Fix:**
```
chmod 600 *.pem *.key
ls -la *.pem *.key
```
## Issue 4: Decryption Failure

**Possible Causes:**

- Wrong key used
- Cipher not initialized
- Corrupted ciphertext
- Mismatched encryption/decryption logic

**Fix:**
- Verify key consistency and encryption flow.

## Issue 5: Script Not Executing

**Fix:**
```
chmod +x *.py
python3 script_name.py
```
