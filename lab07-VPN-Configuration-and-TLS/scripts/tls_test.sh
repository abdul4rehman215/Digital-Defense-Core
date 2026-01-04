#!/bin/bash
# TLS testing using curl

echo "Testing TLS 1.2"
curl -v --tlsv1.2 https://www.google.com 2>&1 | grep TLS

echo "Testing TLS 1.3"
curl -v --tlsv1.3 https://www.google.com 2>&1 | grep TLS

echo "Certificate verification"
curl -v --cacert /etc/ssl/certs/ca-certificates.crt https://www.google.com 2>&1 | grep verify
