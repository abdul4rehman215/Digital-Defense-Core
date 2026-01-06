#!/bin/bash
# File Integrity Monitoring Script

MONITOR_DIRS="/etc/ssh /etc/passwd /etc/shadow /etc/sudoers"
BASELINE_FILE="$HOME/security-scripts/file-baseline.txt"
ALERT_FILE="$HOME/security-scripts/integrity-alerts.log"

log_alert() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$ALERT_FILE"
}

if [ ! -f "$BASELINE_FILE" ]; then
  echo "Creating file integrity baseline..."
  for dir in $MONITOR_DIRS; do
    if [ -e "$dir" ]; then
      find "$dir" -type f -exec md5sum {} \; >> "$BASELINE_FILE"
    fi
  done
  echo "Baseline created at $BASELINE_FILE"
  log_alert "File integrity baseline created"
  exit 0
fi

echo "Checking file integrity..."
TEMP_FILE="/tmp/current-hashes.txt"

for dir in $MONITOR_DIRS; do
  if [ -e "$dir" ]; then
    find "$dir" -type f -exec md5sum {} \; >> "$TEMP_FILE"
  fi
done

if ! diff -q "$BASELINE_FILE" "$TEMP_FILE" > /dev/null; then
  ALERT_MSG="WARNING: File integrity changes detected!"
  echo "$ALERT_MSG"
  log_alert "$ALERT_MSG"
  diff "$BASELINE_FILE" "$TEMP_FILE" >> "$ALERT_FILE"
else
  echo "File integrity check passed - no changes detected"
fi

rm -f "$TEMP_FILE"
