# 🧰 Troubleshooting – Lab 6: Steganography and Covert Channels

---

## Issue: Python Module Import Error (Pillow / NumPy / Matplotlib)
**Error Example:**
```
ModuleNotFoundError: No module named 'PIL'
```
**Cause:**  
Required Python libraries are not installed for the current user environment.

**Fix:**
```bash
pip3 install --user Pillow numpy matplotlib
````

---

## Issue: Message Too Long for Image

**Error Message:**

```
Error: Message too long for image
```

**Cause:**
The image does not have enough pixels to store the binary representation of the message.

**Fix:**

* Use `capacity_checker.py` to calculate maximum supported message length
* Choose a larger image or reduce message size

---

## Issue: Extracted Message is Garbled

**Symptom:**
Extracted output appears as unreadable or random characters.

**Cause:**

* Incorrect password used
* Message delimiter corrupted
* Extraction attempted on non-stego image

**Fix:**

* Ensure the correct password is used
* Verify the image contains embedded data
* Re-run hide and extract steps carefully

---

## Issue: Password-Based Extraction Fails

**Symptom:**

```
Extracted message: @7��K�
```

**Cause:**
Wrong password supplied during extraction.

**Fix:**
Use the exact same password used during message hiding.

---

## Issue: Steganography Detection Shows False Positives

**Symptom:**
Clean images flagged as “Suspicious”.

**Cause:**
Natural image noise can sometimes resemble LSB manipulation statistically.

**Fix:**

* Combine chi-square, entropy, and visualization results
* Do not rely on a single detection method

---

## Issue: LSB Visualization File Not Created

**Cause:**
Permission issues or incorrect image path.

**Fix:**

```bash
ls -la
chmod u+w .
```

---

## Issue: Script Execution Permission Denied

**Error:**

```
Permission denied
```

**Fix:**

```bash
chmod +x *.py
```

---

## Issue: Batch Analyzer Skips Images

**Cause:**
Files do not match `.png` extension filter.

**Fix:**
Ensure image files have `.png` extension or update script logic.

---

## Issue: Image Open Error

**Cause:**
Corrupted image file or unsupported format.

**Fix:**
Verify image integrity:

```bash
file image.png
```

---

## Security Note

Steganography techniques should be used responsibly.
Unauthorized use of covert channels can violate security policies and laws.

