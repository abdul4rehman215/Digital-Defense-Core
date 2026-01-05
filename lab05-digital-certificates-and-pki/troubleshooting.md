# 🧰 Troubleshooting – Lab 5: Digital Certificates and PKI

---

## OpenSSL Command Errors

**Issue:** `openssl: command not found`  
**Cause:** OpenSSL not installed or not in PATH  
**Fix:**
```bash
sudo apt update
sudo apt install openssl -y
````

---

## Certificate Generation Fails

**Issue:** CSR or certificate generation stops unexpectedly
**Cause:** Incorrect or incomplete input during `openssl req` prompts
**Fix:**
Re-run the command and provide all required fields exactly as prompted.

---

## Certificate Verification Failure

**Issue:**

```text
Issuer mismatch – verification failed
```

**Cause:**
The certificate was not signed by the specified CA or the wrong CA certificate was used.

**Fix:**

* Ensure the issuer of the server certificate matches the subject of the CA certificate
* Verify using the correct CA file:

```bash
openssl verify -CAfile ca_cert.crt ca_signed_server.crt
```

---

## Python `cryptography` Import Error

**Issue:**

```text
ModuleNotFoundError: No module named 'cryptography'
```

**Cause:** Python library not installed for the current user/environment
**Fix:**

```bash
pip3 install --user cryptography
```

---

## Digital Signature Verification Fails

**Issue:** Signature verification returns `False`
**Cause:**

* Message was modified
* Wrong public key used

**Fix:**

* Ensure the same original message is verified
* Use the public key derived from the signing private key

---

## Certificate Expiration Script Error

**Issue:** Script crashes when loading certificate
**Cause:** Invalid or corrupted `.crt` file
**Fix:**

* Re-generate the certificate
* Confirm file integrity using:

```bash
openssl x509 -in filename.crt -noout
```

---

## Multi-Level Chain Verification Failure

**Issue:** Intermediate or end-entity verification fails
**Cause:** Incorrect certificate chain order
**Fix:**
Concatenate certificates in correct order:

```bash
cat intermediate_ca.crt ca_cert.crt > chain.pem
```

---

## File Permission Issues

**Issue:** Permission denied while accessing keys
**Cause:** Incorrect file permissions
**Fix:**

```bash
chmod 600 *.key *.pem
ls -la
```
