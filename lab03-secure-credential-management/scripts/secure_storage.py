#!/usr/bin/env python3
import os, json, base64, getpass
from datetime import datetime
import bcrypt
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes

class SecureCredentialManager:
    def __init__(self, storage_file="credentials.enc"):
        self.storage_file = storage_file
        self.salt_file = "salt.key"
        self.credentials = {}

    def generate_key_from_password(self, password, salt):
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=salt,
            iterations=100000,
        )
        return base64.urlsafe_b64encode(kdf.derive(password.encode()))

    def load_or_create_salt(self):
        if os.path.exists(self.salt_file):
            return open(self.salt_file, "rb").read()
        salt = os.urandom(16)
        open(self.salt_file, "wb").write(salt)
        return salt

    def hash_password(self, password):
        return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

    def verify_password(self, password, hashed):
        return bcrypt.checkpw(password.encode(), hashed.encode())

    def encrypt_data(self, data, key):
        return Fernet(key).encrypt(json.dumps(data).encode())

    def decrypt_data(self, data, key):
        return json.loads(Fernet(key).decrypt(data).decode())

    def load_credentials(self, master_password):
        if not os.path.exists(self.storage_file):
            return
        salt = self.load_or_create_salt()
        key = self.generate_key_from_password(master_password, salt)
        encrypted = open(self.storage_file, "rb").read()
        self.credentials = self.decrypt_data(encrypted, key)

    def save_credentials(self, master_password):
        salt = self.load_or_create_salt()
        key = self.generate_key_from_password(master_password, salt)
        encrypted = self.encrypt_data(self.credentials, key)
        open(self.storage_file, "wb").write(encrypted)

    def add_credential(self, service, username, password):
        self.credentials[service] = {
            "username": username,
            "password": self.hash_password(password),
            "created": datetime.now().isoformat(),
            "last_modified": datetime.now().isoformat()
        }

    def list_services(self):
        return list(self.credentials.keys())

def main():
    manager = SecureCredentialManager()
    master = getpass.getpass("Master password: ")
    manager.load_credentials(master)

    while True:
        print("\n1. Add credential")
        print("2. List services")
        print("3. Save and exit")
        print("4. Exit without saving")

        c = input("Choice: ")

        if c == "1":
            svc = input("Service: ")
            usr = input("Username: ")
            pwd = getpass.getpass("Password: ")
            manager.add_credential(svc, usr, pwd)
        elif c == "2":
            print(manager.list_services())
        elif c == "3":
            manager.save_credentials(master)
            break
        elif c == "4":
            break

if __name__ == "__main__":
    main()
