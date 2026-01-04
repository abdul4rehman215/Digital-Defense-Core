#!/usr/bin/env python3
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives import hashes

def hybrid_encrypt(message: str, rsa_public_key):
    """
    Encrypt large message using hybrid cryptography.
    """
    aes_key = Fernet.generate_key()
    aes_cipher = Fernet(aes_key)

    encrypted_message = aes_cipher.encrypt(message.encode())

    encrypted_aes_key = rsa_public_key.encrypt(
        aes_key,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )

    return encrypted_aes_key, encrypted_message

def hybrid_decrypt(encrypted_aes_key: bytes, encrypted_message: bytes,
                   rsa_private_key) -> str:
    """
    Decrypt hybrid encrypted message.
    """
    aes_key = rsa_private_key.decrypt(
        encrypted_aes_key,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )

    aes_cipher = Fernet(aes_key)
    return aes_cipher.decrypt(encrypted_message).decode()

def main():
    print("=== Hybrid Encryption Demo ===\n")

    private_key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=2048
    )
    public_key = private_key.public_key()

    message = "HYBRID_ENCRYPTION_" * 200

    encrypted_key, encrypted_message = hybrid_encrypt(message, public_key)
    decrypted_message = hybrid_decrypt(
        encrypted_key, encrypted_message, private_key
    )

    print("Original message length :", len(message))
    print("Encrypted message length:", len(encrypted_message))
    print("Decryption successful  :", message == decrypted_message)

    print("\nAdvantages of Hybrid Encryption:")
    print("- RSA secures AES key")
    print("- AES encrypts large data efficiently")
    print("- Used in TLS/SSL and secure messaging")

    print("\n=== Demo Complete ===")

if __name__ == "__main__":
    main()
