#!/bin/bash
LOG_FILE="/opt/cloud-security-lab/logs/network-monitor.log"
ALERT_FILE="/opt/cloud-security-lab/logs/security-alerts.log"

monitor_connections() {
 echo "=== Network Connection Monitor - $(date) ===" >> "$LOG_FILE"
 netstat -tuln >> "$LOG_FILE"

 SUSPICIOUS_PORTS=(23 135 139 445 1433 3389)

 for port in "${SUSPICIOUS_PORTS[@]}"; do
  if netstat -tuln | grep -q ":$port "; then
   echo "ALERT: Suspicious port $port open at $(date)" >> "$ALERT_FILE"
  fi
 done

 FAILED_LOGINS=$(grep "Failed password" /var/log/auth.log | tail -10)
 if [ ! -z "$FAILED_LOGINS" ]; then
  echo "=== Failed Login Attempts ===" >> "$LOG_FILE"
  echo "$FAILED_LOGINS" >> "$LOG_FILE"
 fi
}

check_security() {
 echo "=== Security Check - $(date) ===" >> "$LOG_FILE"

 awk -F: '($2 == "") {print "WARNING: Empty password for user " $1}' /etc/shadow >> "$LOG_FILE"

 find /etc -type f -perm -002 -exec echo "World-writable file: {}" \; >> "$LOG_FILE" 2>/dev/null

 systemctl list-units --type=service --state=running >> "$LOG_FILE"
}

monitor_connections
check_security

echo "Network monitoring completed"
