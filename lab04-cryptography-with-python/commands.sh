#!/bin/bash
# Lab 04 - Cryptography with Python

sudo apt update
sudo apt install python3-pip -y
pip3 install --user cryptography

mkdir ~/crypto_lab
cd ~/crypto_lab

nano aes_crypto.py
chmod +x aes_crypto.py
python3 aes_crypto.py

nano rsa_crypto.py
chmod +x rsa_crypto.py
python3 rsa_crypto.py

nano crypto_compare.py
chmod +x crypto_compare.py
python3 crypto_compare.py

nano hybrid_crypto.py
chmod +x hybrid_crypto.py
python3 hybrid_crypto.py
