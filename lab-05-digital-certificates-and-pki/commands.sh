#!/bin/bash
# Lab 5: Digital Certificates and PKI
# commands.sh
# Environment: Ubuntu 24.04 LTS
# Shell: bash
# User: toor

# ================================
# Task 1: Generate Self-Signed Certificates
# ================================

# Step 1: Create Working Directory
mkdir ~/pki_lab
cd ~/pki_lab

# Step 2: Generate Private Key and Self-Signed Certificate
openssl genrsa -out server_private.key 2048

openssl req -new -key server_private.key -out server.csr

openssl x509 -req -days 365 \
-in server.csr \
-signkey server_private.key \
-out server_cert.crt

openssl x509 -in server_cert.crt -text -noout

# Step 3: Create Certificate Authority (CA)
openssl genrsa -out ca_private.key 4096

openssl req -new -x509 -days 3650 \
-key ca_private.key \
-out ca_cert.crt

# Step 4: Create CA-Signed Server Certificate
openssl genrsa -out ca_signed_server.key 2048

openssl req -new -key ca_signed_server.key -out ca_signed_server.csr

openssl x509 -req -days 365 \
-in ca_signed_server.csr \
-CA ca_cert.crt \
-CAkey ca_private.key \
-CAcreateserial \
-out ca_signed_server.crt

openssl verify -CAfile ca_cert.crt ca_signed_server.crt

# ================================
# Task 2: Certificate Verification with Python
# ================================

chmod +x certificate_verifier.py
python3 certificate_verifier.py

# ================================
# Task 3: Digital Signature Implementation
# ================================

chmod +x digital_signature_demo.py
python3 digital_signature_demo.py

# ================================
# Task 4: Certificate Expiration Monitoring
# ================================

chmod +x cert_expiration_monitor.py
python3 cert_expiration_monitor.py

# ================================
# Task 5: Multi-Level Certificate Chain
# ================================

openssl genrsa -out intermediate_ca.key 2048

openssl req -new -key intermediate_ca.key -out intermediate_ca.csr

openssl x509 -req -days 1825 \
-in intermediate_ca.csr \
-CA ca_cert.crt \
-CAkey ca_private.key \
-CAcreateserial \
-out intermediate_ca.crt

openssl genrsa -out end_entity.key 2048

openssl req -new -key end_entity.key -out end_entity.csr

openssl x509 -req -days 365 \
-in end_entity.csr \
-CA intermediate_ca.crt \
-CAkey intermediate_ca.key \
-CAcreateserial \
-out end_entity.crt

cat intermediate_ca.crt ca_cert.crt > chain.pem

openssl verify -CAfile chain.pem end_entity.crt

chmod +x multi_level_verifier.py
python3 multi_level_verifier.py
