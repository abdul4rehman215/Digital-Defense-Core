#!/usr/bin/env python3
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives import serialization, hashes

class RSACrypto:
    """RSA encryption/decryption and digital signatures"""

    def __init__(self):
        self.private_key = None
        self.public_key = None

    def generate_keypair(self, key_size: int = 2048):
        self.private_key = rsa.generate_private_key(
            public_exponent=65537,
            key_size=key_size
        )
        self.public_key = self.private_key.public_key()

    def save_keys(self, private_file="private.pem", public_file="public.pem"):
        with open(private_file, "wb") as f:
            f.write(
                self.private_key.private_bytes(
                    encoding=serialization.Encoding.PEM,
                    format=serialization.PrivateFormat.PKCS8,
                    encryption_algorithm=serialization.NoEncryption()
                )
            )

        with open(public_file, "wb") as f:
            f.write(
                self.public_key.public_bytes(
                    encoding=serialization.Encoding.PEM,
                    format=serialization.PublicFormat.SubjectPublicKeyInfo
                )
            )

    def load_keys(self, private_file="private.pem", public_file="public.pem"):
        with open(private_file, "rb") as f:
            self.private_key = serialization.load_pem_private_key(
                f.read(), password=None
            )

        with open(public_file, "rb") as f:
            self.public_key = serialization.load_pem_public_key(
                f.read()
            )

    def encrypt(self, plaintext: str) -> bytes:
        if len(plaintext.encode()) > 190:
            raise ValueError("Message too large for RSA encryption")

        return self.public_key.encrypt(
            plaintext.encode(),
            padding.OAEP(
                mgf=padding.MGF1(algorithm=hashes.SHA256()),
                algorithm=hashes.SHA256(),
                label=None
            )
        )

    def decrypt(self, ciphertext: bytes) -> str:
        return self.private_key.decrypt(
            ciphertext,
            padding.OAEP(
                mgf=padding.MGF1(algorithm=hashes.SHA256()),
                algorithm=hashes.SHA256(),
                label=None
            )
        ).decode()

    def sign(self, message: str) -> bytes:
        return self.private_key.sign(
            message.encode(),
            padding.PSS(
                mgf=padding.MGF1(hashes.SHA256()),
                salt_length=padding.PSS.MAX_LENGTH
            ),
            hashes.SHA256()
        )

    def verify(self, message: str, signature: bytes) -> bool:
        try:
            self.public_key.verify(
                signature,
                message.encode(),
                padding.PSS(
                    mgf=padding.MGF1(hashes.SHA256()),
                    salt_length=padding.PSS.MAX_LENGTH
                ),
                hashes.SHA256()
            )
            return True
        except Exception:
            return False

def main():
    print("=== RSA Encryption Demo ===\n")

    rsa_crypto = RSACrypto()
    rsa_crypto.generate_keypair()
    rsa_crypto.save_keys()

    message = "RSA secret message"
    encrypted = rsa_crypto.encrypt(message)
    decrypted = rsa_crypto.decrypt(encrypted)

    print("Original :", message)
    print("Decrypted:", decrypted)

    signature = rsa_crypto.sign(message)
    print("Signature valid:", rsa_crypto.verify(message, signature))

    print("Tampered signature valid:",
          rsa_crypto.verify("tampered", signature))

    rsa_crypto.load_keys()
    print("\nKeys loaded successfully")

    print("\n=== Demo Complete ===")

if __name__ == "__main__":
    main()
