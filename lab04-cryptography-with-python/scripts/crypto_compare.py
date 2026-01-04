#!/usr/bin/env python3
import time
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives import hashes

def benchmark_aes():
    """
    Benchmark AES encryption/decryption speed.
    Test with a large message (1000+ characters).
    """
    key = Fernet.generate_key()
    cipher = Fernet(key)

    message = "A" * 5000
    start_enc = time.time()
    encrypted = cipher.encrypt(message.encode())
    end_enc = time.time()

    start_dec = time.time()
    decrypted = cipher.decrypt(encrypted)
    end_dec = time.time()

    return (end_enc - start_enc,
            end_dec - start_dec,
            len(encrypted))

def benchmark_rsa():
    """
    Benchmark RSA encryption/decryption speed.
    Test with a small message (<190 bytes).
    """
    private_key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=2048
    )
    public_key = private_key.public_key()

    message = "RSA test message"
    start_enc = time.time()
    encrypted = public_key.encrypt(
        message.encode(),
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )
    end_enc = time.time()

    start_dec = time.time()
    decrypted = private_key.decrypt(
        encrypted,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )
    end_dec = time.time()

    return (end_enc - start_enc,
            end_dec - start_dec,
            len(encrypted))

def compare_methods():
    print("=== Encryption Method Comparison ===\n")

    aes_enc, aes_dec, aes_size = benchmark_aes()
    rsa_enc, rsa_dec, rsa_size = benchmark_rsa()

    print("AES Results:")
    print(f"Encryption time: {aes_enc:.6f}s")
    print(f"Decryption time: {aes_dec:.6f}s")
    print(f"Ciphertext size: {aes_size} bytes\n")

    print("RSA Results:")
    print(f"Encryption time: {rsa_enc:.6f}s")
    print(f"Decryption time: {rsa_dec:.6f}s")
    print(f"Ciphertext size: {rsa_size} bytes\n")

    print("Use Case Recommendations:")
    print("- AES: Large data, fast performance")
    print("- RSA: Small data, key exchange, signatures")
    print("- Hybrid: Real-world secure communication")

if __name__ == "__main__":
    compare_methods()
