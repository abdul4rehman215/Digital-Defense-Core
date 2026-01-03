#!/bin/bash
BASE_DIR="$HOME/zerotrust-lab/resources"
BASELINE="$HOME/zerotrust-lab/logs/baseline.txt"
MONITOR_LOG="$HOME/zerotrust-lab/logs/monitor_log.txt"

create_baseline() {
    find "$BASE_DIR" -type f -exec stat -c "%n %a %U" {} \; > "$BASELINE"
}

detect_changes() {
    tmp=$(mktemp)
    find "$BASE_DIR" -type f -exec stat -c "%n %a %U" {} \; > "$tmp"
    diff "$BASELINE" "$tmp" >> "$MONITOR_LOG"
    rm "$tmp"
}

log_access_attempt() {
    echo "$(date) | user=$1 | resource=$2 | action=$3 | result=$4" >> "$MONITOR_LOG"
}

generate_audit_report() {
    cat "$MONITOR_LOG"
}

case "$1" in
    baseline) create_baseline ;;
    detect) detect_changes ;;
    log) log_access_attempt "$2" "$3" "$4" "$5" ;;
    audit) generate_audit_report ;;
    *) echo "Usage: $0 {baseline|detect|log|audit}" ;;
esac
