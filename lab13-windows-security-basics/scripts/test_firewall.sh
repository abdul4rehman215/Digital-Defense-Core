#!/bin/bash
# Firewall logging and monitoring script

LOG_FILE="/var/log/firewall_monitor.log"

DROPPED=$(grep "FIREWALL-DROPPED" /var/log/syslog | wc -l)

echo "=== Firewall Report $(date) ===" >> "$LOG_FILE"
echo "Dropped packets: $DROPPED" >> "$LOG_FILE"
iptables -L -n >> "$LOG_FILE"
ss -tuln >> "$LOG_FILE"
echo "=============================" >> "$LOG_FILE"

echo "Firewall Monitor Summary:"
echo "Dropped packets: $DROPPED"
echo "Log written to: $LOG_FILE"
