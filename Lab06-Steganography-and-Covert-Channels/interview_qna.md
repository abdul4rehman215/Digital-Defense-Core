# 📘 Interview Q&A – Lab 6: Steganography and Covert Channels

---

### Q1. What is steganography?
**Answer:**  
Steganography is the practice of hiding the existence of information within another medium, such as embedding a secret message inside an image, so that the presence of the data is concealed.

---

### Q2. How is steganography different from encryption?
**Answer:**  
Encryption hides the content of a message, while steganography hides the existence of the message itself.

---

### Q3. What steganography technique was used in this lab?
**Answer:**  
Least Significant Bit (LSB) encoding was used to hide data inside RGB image pixel values.

---

### Q4. Why are LSB changes difficult to detect visually?
**Answer:**  
Because modifying the least significant bit changes pixel values by only ±1, which is imperceptible to the human eye.

---

### Q5. How did you hide a message inside an image?
**Answer:**  
The message was converted to binary and embedded into the LSBs of image pixel values using Python.

---

### Q6. How was the hidden message extracted?
**Answer:**  
By reading the LSBs from image pixels, reconstructing the binary data, and converting it back to readable text.

---

### Q7. How did you calculate the maximum data capacity of an image?
**Answer:**  
Using the formula: image width × height × 3 color channels ÷ 8 bits per character.

---

### Q8. How was password protection implemented in this lab?
**Answer:**  
Using XOR-based encryption with an MD5-derived key and Base64 encoding before embedding the message.

---

### Q9. What techniques were used to detect steganography?
**Answer:**  
Chi-square statistical testing, entropy analysis, and LSB visualization techniques.

---

### Q10. Why are covert channels considered a security risk?
**Answer:**  
They allow hidden data exfiltration that can bypass traditional monitoring and security controls.

---
