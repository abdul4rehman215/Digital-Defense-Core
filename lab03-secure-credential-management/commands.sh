#!/bin/bash
# Lab 03 - Secure Credential Management Commands

mkdir ~/secure_credentials_lab
cd ~/secure_credentials_lab

pip3 install --user cryptography bcrypt

nano password_policy.py
chmod +x password_policy.py
python3 password_policy.py

nano password_generator.py
python3 password_generator.py

nano secure_storage.py
python3 secure_storage.py

nano credential_audit.py
python3 credential_audit.py
