# 📘 Interview Q&A – Lab 7: VPN Configuration and TLS

---

### Q1. What problem does a VPN solve in network security?
**A:** A VPN encrypts network traffic and provides secure remote access over untrusted networks such as the internet, protecting data confidentiality and integrity.

---

### Q2. Which VPN technology did you configure in this lab?
**A:** OpenVPN using TLS-based encryption and certificate-based authentication.

---

### Q3. Why was Easy-RSA used in the OpenVPN setup?
**A:** Easy-RSA was used to create and manage the Public Key Infrastructure (PKI), including the Certificate Authority (CA), server certificates, and client certificates.

---

### Q4. What is the purpose of the TLS authentication key (ta.key)?
**A:** The TLS authentication key adds an additional layer of security by protecting the TLS handshake from DoS attacks and unauthorized connection attempts.

---

### Q5. Which encryption and authentication algorithms were used for OpenVPN?
**A:** AES-256-GCM was used for encryption and SHA-256 was used for authentication.

---

### Q6. Why is IP forwarding required on the VPN server?
**A:** IP forwarding allows the VPN server to route traffic from VPN clients to external networks such as the internet.

---

### Q7. How did you verify that the VPN tunnel was successfully created?
**A:** By checking the presence of the `tun0` interface, verifying assigned VPN IP addresses, and successfully pinging the VPN gateway.

---

### Q8. How did Wireshark confirm that VPN traffic was encrypted?
**A:** Captured packets showed OpenVPN protocol data with unreadable encrypted payloads, indicating that traffic was securely encrypted.

---

### Q9. How did you validate TLS versions using curl?
**A:** By testing HTTPS connections using `curl` with `--tlsv1.2` and `--tlsv1.3` flags and confirming successful TLS handshakes.

---

### Q10. Why are certificates important in VPN and TLS security?
**A:** Certificates provide authentication, prevent impersonation, establish trust between endpoints, and enable secure encrypted communication channels.

---
