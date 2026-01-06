#!/bin/bash
echo "=== COLLECTING INCIDENT EVIDENCE ==="

EVIDENCE_DIR="incident_evidence_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$EVIDENCE_DIR"

sudo cp /var/log/syslog "$EVIDENCE_DIR/" 2>/dev/null || true
sudo cp /var/log/auth.log "$EVIDENCE_DIR/" 2>/dev/null || true

cp suspicious_traffic.pcap "$EVIDENCE_DIR/" 2>/dev/null || true
cp initial_assessment.txt incident_detection.txt containment_verification.txt segmentation_config.txt "$EVIDENCE_DIR/" 2>/dev/null || true

echo "=== SYSTEM STATE ===" > "$EVIDENCE_DIR/system_state.txt"
date >> "$EVIDENCE_DIR/system_state.txt"
ps aux >> "$EVIDENCE_DIR/system_state.txt"
ss -tuln >> "$EVIDENCE_DIR/system_state.txt"
sudo iptables -L -n -v >> "$EVIDENCE_DIR/system_state.txt"

echo "$EVIDENCE_DIR" > evidence_dir.txt
echo "Evidence collected in: $EVIDENCE_DIR"
