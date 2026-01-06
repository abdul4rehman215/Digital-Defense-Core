#!/bin/bash

AUTH="/var/log/auth.log"
WEB="/var/log/apache2/access.log"
OUT="$HOME/siem-analysis"

mkdir -p "$OUT"

send_alert() {
    echo "[$(date)] $1" | tee -a "$OUT/alerts.log"
}

tail -F "$AUTH" | while read line; do
    echo "$line" | grep -q "Failed password" && send_alert "AUTH FAIL: $line"
    echo "$line" | grep -q "sudo:" && send_alert "SUDO: $line"
done &

tail -F "$WEB" | while read line; do
    echo "$line" | grep -Eq "404|union|select" && send_alert "WEB ALERT: $line"
done &

wait
