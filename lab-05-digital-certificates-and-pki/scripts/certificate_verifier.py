#!/usr/bin/env python3
from cryptography import x509
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives import hashes
from cryptography.x509.oid import NameOID
import datetime

def load_certificate(cert_path):
    try:
        with open(cert_path, "rb") as f:
            return x509.load_pem_x509_certificate(f.read(), default_backend())
    except Exception as e:
        print(f"Error loading {cert_path}: {e}")
        return None

def display_certificate_info(certificate, cert_name):
    print(f"\n=== {cert_name} Certificate Information ===")
    subject = certificate.subject.rfc4514_string()
    issuer = certificate.issuer.rfc4514_string()

    print("Subject:", subject)
    print("Issuer :", issuer)
    print("Valid From:", certificate.not_valid_before)
    print("Valid Until:", certificate.not_valid_after)

    now = datetime.datetime.utcnow()
    if certificate.not_valid_before <= now <= certificate.not_valid_after:
        print("Status: VALID")
    else:
        print("Status: INVALID")

    print("Serial Number:", certificate.serial_number)
    print("Public Key Type:", type(certificate.public_key()).__name__)

def verify_certificate_chain(ca_cert, server_cert):
    print("\n=== Certificate Chain Verification ===")
    if server_cert.issuer != ca_cert.subject:
        print("Issuer mismatch – verification failed")
        return False

    try:
        ca_cert.public_key().verify(
            server_cert.signature,
            server_cert.tbs_certificate_bytes,
            padding.PKCS1v15(),
            server_cert.signature_hash_algorithm,
        )
        print("Certificate successfully verified by CA")
        return True
    except Exception as e:
        print("Verification failed:", e)
        return False

def main():
    print("PKI Certificate Verification Tool")
    print("=" * 50)

    ca_cert = load_certificate("ca_cert.crt")
    ca_signed = load_certificate("ca_signed_server.crt")
    self_signed = load_certificate("server_cert.crt")

    if ca_cert:
        display_certificate_info(ca_cert, "CA")
    if ca_signed:
        display_certificate_info(ca_signed, "CA-Signed Server")
    if self_signed:
        display_certificate_info(self_signed, "Self-Signed Server")

    if ca_cert and ca_signed:
        verify_certificate_chain(ca_cert, ca_signed)

    if ca_cert and self_signed:
        print("\nTesting self-signed cert against CA (expected failure)")
        verify_certificate_chain(ca_cert, self_signed)

if __name__ == "__main__":
    main()
