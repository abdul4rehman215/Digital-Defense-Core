#!/usr/bin/env python3
from cryptography import x509
from cryptography.hazmat.backends import default_backend
from cryptography.x509.oid import NameOID
import datetime
import os

def check_certificate_expiration(cert_path, warning_days=30):
    with open(cert_path, "rb") as f:
        cert = x509.load_pem_x509_certificate(f.read(), default_backend())

    expiry = cert.not_valid_after
    days_left = (expiry - datetime.datetime.utcnow()).days

    cn = cert.subject.get_attributes_for_oid(NameOID.COMMON_NAME)[0].value

    if days_left < 0:
        status = "EXPIRED"
    elif days_left <= warning_days:
        status = "WARNING"
    else:
        status = "OK"

    return {
        "file": cert_path,
        "cn": cn,
        "expires": expiry,
        "days_left": days_left,
        "status": status
    }

def main():
    print("Certificate Expiration Monitor")
    print("=" * 40)

    certs = [f for f in os.listdir(".") if f.endswith(".crt")]

    expired = warning = ok = 0

    for cert in certs:
        info = check_certificate_expiration(cert)
        print(info)
        if info["status"] == "EXPIRED":
            expired += 1
        elif info["status"] == "WARNING":
            warning += 1
        else:
            ok += 1

    print("\nSummary:")
    print("Total:", len(certs))
    print("Expired:", expired)
    print("Warning:", warning)
    print("OK:", ok)

if __name__ == "__main__":
    main()
