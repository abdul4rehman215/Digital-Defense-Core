#!/bin/bash
# Master Security Check Script

SCRIPT_DIR="$HOME/security-scripts"
LOG_FILE="$SCRIPT_DIR/security-master.log"

echo "=== Security Check Started at $(date) ===" >> "$LOG_FILE"

echo "Running SSH Monitor..." >> "$LOG_FILE"
"$SCRIPT_DIR/ssh-monitor.sh" >> "$LOG_FILE" 2>&1

echo "" >> "$LOG_FILE"

echo "Running System Monitor..." >> "$LOG_FILE"
"$SCRIPT_DIR/system-monitor.sh" >> "$LOG_FILE" 2>&1

echo "=== Security Check Completed at $(date) ===" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

tail -1000 "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
