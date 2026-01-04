#!/usr/bin/env python3
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding
import base64

def load_private_key(key_path):
    try:
        with open(key_path, "rb") as f:
            return serialization.load_pem_private_key(f.read(), password=None)
    except Exception as e:
        print("Key load error:", e)
        return None

def create_digital_signature(private_key, message):
    return private_key.sign(
        message.encode(),
        padding.PSS(
            mgf=padding.MGF1(hashes.SHA256()),
            salt_length=padding.PSS.MAX_LENGTH
        ),
        hashes.SHA256()
    )

def verify_digital_signature(public_key, message, signature):
    try:
        public_key.verify(
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
    print("Digital Signature Demonstration")
    print("=" * 40)

    private_key = load_private_key("server_private.key")
    public_key = private_key.public_key()

    message = "This message will be signed"
    signature = create_digital_signature(private_key, message)

    print("Signature (Base64):", base64.b64encode(signature).decode())
    print("Verification (original):",
          verify_digital_signature(public_key, message, signature))
    print("Verification (tampered):",
          verify_digital_signature(public_key, "tampered", signature))

if __name__ == "__main__":
    main()
