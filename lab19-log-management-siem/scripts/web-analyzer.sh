#!/bin/bash

LOG="/var/log/apache2/access.log"
OUT="$HOME/siem-analysis"
DATE=$(date +%F_%H%M%S)

mkdir -p "$OUT"

analyze_top_ips() {
    awk '{print $1}' "$LOG" | sort | uniq -c | sort -nr | head -20 \
    > "$OUT/top_ips_$DATE.txt"
}

analyze_status_codes() {
    awk '{print $9}' "$LOG" | sort | uniq -c | sort -nr \
    > "$OUT/status_codes_$DATE.txt"
}

detect_web_attacks() {
    grep -Ei "union|select|../|<script>" "$LOG" \
    > "$OUT/web_attacks_$DATE.txt"
}

analyze_top_ips
analyze_status_codes
detect_web_attacks

echo "Web analysis complete"
