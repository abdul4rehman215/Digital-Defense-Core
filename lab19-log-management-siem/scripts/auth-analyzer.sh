#!/bin/bash

LOG="/var/log/auth.log"
OUT="$HOME/siem-analysis"
DATE=$(date +%F_%H%M%S)

mkdir -p "$OUT"

analyze_failed_logins() {
    grep "Failed password" "$LOG" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr \
    > "$OUT/failed_logins_$DATE.txt"
}

detect_brute_force() {
    grep "Failed password" "$LOG" | awk '{print $(NF-3)}' | sort | uniq -c | awk '$1>5' \
    > "$OUT/bruteforce_$DATE.txt"
}

analyze_sudo_usage() {
    grep "sudo:" "$LOG" > "$OUT/sudo_usage_$DATE.txt"
}

analyze_failed_logins
detect_brute_force
analyze_sudo_usage

echo "Auth analysis complete → $OUT"
