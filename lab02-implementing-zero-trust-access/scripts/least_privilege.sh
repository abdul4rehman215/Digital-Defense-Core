#!/bin/bash
BASE_DIR="$HOME/zerotrust-lab/resources"
LOG_FILE="$HOME/zerotrust-lab/logs/privilege_log.txt"

apply_permissions() {
    chmod 755 "$BASE_DIR/public"
    chmod 644 "$BASE_DIR/public/"*

    chmod 750 "$BASE_DIR/private"
    chmod 640 "$BASE_DIR/private/"*

    chmod 700 "$BASE_DIR/restricted"
    chmod 600 "$BASE_DIR/restricted/"*

    chmod 775 "$BASE_DIR/shared"
    chmod 664 "$BASE_DIR/shared/"*

    echo "$(date) - permissions_applied" >> "$LOG_FILE"
}

verify_permissions() {
    stat -c "%n %a" "$BASE_DIR"/**/*
}

test_access() {
    case "$2" in
        r) test -r "$1" ;;
        w) test -w "$1" ;;
        x) test -x "$1" ;;
    esac
}

generate_report() {
    ls -lR "$BASE_DIR"
}

case "$1" in
    apply) apply_permissions ;;
    verify) verify_permissions ;;
    test) test_access "$2" "$3" ;;
    report) generate_report ;;
    *) echo "Usage: $0 {apply|verify|test|report}" ;;
esac
