#!/bin/bash
# Container Image Security Scan Script using Trivy
# Blocks deployment if HIGH or CRITICAL vulnerabilities exceed thresholds

IMAGE_NAME=$1
SEVERITY_THRESHOLD="HIGH,CRITICAL"
SCAN_OUTPUT="scan-results.json"

if [ -z "$IMAGE_NAME" ]; then
 echo "Usage: $0 <image_name>"
 exit 1
fi

echo "======================================"
echo "Container Security Scan"
echo "Image: $IMAGE_NAME"
echo "Severity Threshold: $SEVERITY_THRESHOLD"
echo "======================================"

trivy image \
 --severity $SEVERITY_THRESHOLD \
 --format json \
 --output $SCAN_OUTPUT \
 $IMAGE_NAME

CRITICAL_COUNT=$(cat $SCAN_OUTPUT | jq '[.Results[]?.Vulnerabilities[]? | select(.Severity=="CRITICAL")] | length')
HIGH_COUNT=$(cat $SCAN_OUTPUT | jq '[.Results[]?.Vulnerabilities[]? | select(.Severity=="HIGH")] | length')

echo "Critical vulnerabilities found: $CRITICAL_COUNT"
echo "High severity vulnerabilities found: $HIGH_COUNT"

if [ "$CRITICAL_COUNT" -gt 0 ]; then
 echo "FAIL: Critical vulnerabilities detected. Deployment blocked."
 exit 1
elif [ "$HIGH_COUNT" -gt 5 ]; then
 echo "WARNING: High number of high-severity vulnerabilities detected."
 exit 1
else
 echo "PASS: Image security scan completed successfully."
 exit 0
fi
