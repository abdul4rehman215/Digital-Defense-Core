#!/usr/bin/env python3
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
import base64
import os

class AESCrypto:
    """AES encryption/decryption handler using Fernet"""

    def __init__(self):
        self.key = None
        self.cipher = None

    def generate_key(self):
        self.key = Fernet.generate_key()
        self.cipher = Fernet(self.key)
        return self.key

    def generate_key_from_password(self, password: str, salt: bytes = None):
        if salt is None:
            salt = os.urandom(16)

        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=salt,
            iterations=100000,
        )

        self.key = base64.urlsafe_b64encode(kdf.derive(password.encode()))
        self.cipher = Fernet(self.key)
        return self.key, salt

    def encrypt(self, plaintext: str) -> bytes:
        if not self.cipher:
            raise ValueError("Cipher not initialized")
        return self.cipher.encrypt(plaintext.encode())

    def decrypt(self, ciphertext: bytes) -> str:
        if not self.cipher:
            raise ValueError("Cipher not initialized")
        return self.cipher.decrypt(ciphertext).decode()

    def save_key(self, filename: str):
        with open(filename, "wb") as f:
            f.write(self.key)

    def load_key(self, filename: str):
        with open(filename, "rb") as f:
            self.key = f.read()
        self.cipher = Fernet(self.key)

def main():
    print("=== AES Encryption Demo ===\n")

    aes = AESCrypto()
    aes.generate_key()

    message = "This is a secret AES message"
    encrypted = aes.encrypt(message)
    decrypted = aes.decrypt(encrypted)

    print("Original :", message)
    print("Encrypted:", encrypted)
    print("Decrypted:", decrypted)

    password = "StrongPassword123!"
    aes.generate_key_from_password(password)

    encrypted_pw = aes.encrypt(message)
    print("Password-based encryption successful")

    aes.save_key("aes.key")
    aes2 = AESCrypto()
    aes2.load_key("aes.key")

    print("Decrypted with loaded key:", aes2.decrypt(encrypted))

if __name__ == "__main__":
    main()
