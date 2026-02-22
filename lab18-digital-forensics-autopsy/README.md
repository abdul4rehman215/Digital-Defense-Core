# 🧪 Lab 18: Digital Forensics with Autopsy

## 🎯 Objectives
By the end of this lab, I was able to:

• Install and configure Autopsy digital forensics platform on Linux  
• Create and analyze disk images for forensic investigation  
• Extract digital evidence from file systems using Autopsy  
• Identify and analyze file system artifacts including deleted files, metadata, and timeline events  
• Generate forensic reports documenting findings  
• Understand digital forensics methodology and chain of custody  

---

## 🖥️ Lab Environment
• OS: Ubuntu 22.04 LTS  
• Tools: Autopsy, SleuthKit  
• Privileges: sudo access  

---

## 🧩 Lab Tasks Overview
This lab performs a **complete forensic investigation workflow**:
1. Evidence creation (USB disk image simulation)
2. Artifact population (documents, passwords, hidden files)
3. Deleted file simulation
4. Hash-based integrity preservation
5. Autopsy case creation and evidence ingestion
6. File system, hidden file, deleted file analysis
7. Keyword search and timeline reconstruction
8. Report generation and integrity re-verification

---

## 🔍 Evidence Creation Summary
A FAT32 disk image simulating a USB drive was created and populated with:
• Confidential documents  
• Plaintext password file  
• Hidden configuration file  
• Deleted file for recovery testing  
• System log artifacts  

---

## 🔐 Evidence Integrity & Chain of Custody
Before analysis:
• MD5 hash generated  
• SHA256 hash generated  

After analysis:
• Hashes re-verified  
• No integrity violations detected  

This ensures **legal admissibility** and **forensic soundness**.

---

## 🧠 Forensic Findings Summary
• Sensitive documents identified  
• Plaintext credentials discovered  
• Hidden file recovered  
• Deleted file successfully restored  
• Timeline reconstruction confirms manual user activity  
• No malware signatures detected  

---

## 🏁 Final Conclusion
This lab demonstrated a **full digital forensics lifecycle** using Autopsy and SleuthKit.
Evidence was handled according to industry best practices, maintaining integrity,
traceability, and defensibility.

The skills practiced here directly apply to:
• Digital Forensics & Incident Response (DFIR)
• SOC investigations
• Law enforcement digital analysis
• Compliance and audit cases
