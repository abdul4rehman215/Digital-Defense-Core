# 🧪 Lab 6: Steganography and Covert Channels

**Environment:** Ubuntu 24.04.1 LTS (Cloud Lab Environment)  
**User:** toor  
**Shell Prompt:** `toor@ip-172-31-10-198:~$`

---

## 🎯 Objectives

By the end of this lab, students will be able to:

- Understand fundamental concepts of steganography and LSB encoding
- Implement image-based steganography using Python
- Hide and extract text messages within digital images
- Analyze images for hidden content
- Understand security implications of covert channels

---

## 📋 Prerequisites

- Basic Python programming skills
- Understanding of binary number systems
- Familiarity with Linux command line

---

## 🖥️ Lab Environment

Pre-configured Ubuntu 24.04 LTS cloud-based Linux environment with:

- Python 3
- pip
- Required libraries installable via pip

---

## 🧩 Task 1: Understanding LSB Steganography

### Step 1: Set Up Working Directory

Create a dedicated working directory for steganography experiments and install required libraries.

---

### Step 2: Create Test Images

Generate test images programmatically to be used for hiding and analyzing hidden data.

---

### Step 3: Understand Binary Representation

Demonstrate how Least Significant Bit (LSB) manipulation works at the binary level using a Python script.

---

## 🧩 Task 2: Implement Basic Steganography

### Step 1: Create Steganography Encoder/Decoder

Develop a Python-based tool to hide and extract text messages inside image files using LSB encoding.

---

### Step 2: Test Your Implementation

Validate the encoder and decoder by hiding a message in an image and extracting it successfully.

---

### Step 3: Add Image Comparison

Conceptually analyze image changes introduced by steganography.

---

## 🧩 Task 3: Advanced Steganography Features

### Step 1: Implement Capacity Calculation

Create a script to calculate the maximum data capacity of an image.

---

### Step 2: Add Password Protection

Enhance message hiding by adding password-based encryption.

---

### Step 3: Test Advanced Features

Verify password-protected hiding and extraction behavior.

---

## 🧩 Task 4: Steganography Detection

### Step 1: Create Detection Tool

Develop statistical and visual tools to detect potential steganography in images.

---

### Step 2: Test Detection Tool

Analyze both clean and stego images for anomalies.

---

### Step 3: Batch Analysis Tool

Create a script to scan multiple images for potential covert channels.

---

## ✅ Expected Outcomes

After completing this lab, students will have hands-on experience with:

- LSB-based steganography
- Image capacity estimation
- Password-protected covert communication
- Statistical and visual steganography detection
- Security risks associated with covert channels

---

## 🏁 Conclusion

This lab introduces practical steganography techniques and detection methods, demonstrating how covert channels can be created and identified in digital images.
