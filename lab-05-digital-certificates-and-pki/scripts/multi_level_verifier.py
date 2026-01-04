#!/usr/bin/env python3
from cryptography import x509
from cryptography.hazmat.backends import default_backend

def load_certificate(path):
    with open(path, "rb") as f:
        return x509.load_pem_x509_certificate(f.read(), default_backend())

def verify_chain_link(issuer_cert, subject_cert, name):
    print(f"Verifying {name} link...")
    if subject_cert.issuer == issuer_cert.subject:
        print("Issuer match: OK")
        return True
    print("Issuer mismatch: FAILED")
    return False

def main():
    print("Multi-Level Certificate Chain Verification")
    print("=" * 50)

    root = load_certificate("ca_cert.crt")
    intermediate = load_certificate("intermediate_ca.crt")
    end_entity = load_certificate("end_entity.crt")

    r1 = verify_chain_link(root, intermediate, "Root → Intermediate")
    r2 = verify_chain_link(intermediate, end_entity, "Intermediate → End Entity")

    print("\nOverall chain valid:", r1 and r2)

if __name__ == "__main__":
    main()
