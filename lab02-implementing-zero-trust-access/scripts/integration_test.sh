#!/bin/bash
LOG="$HOME/zerotrust-lab/logs/test_results.txt"

initialize_tests() {
    > "$LOG"
    echo "Test initialization complete" >> "$LOG"
}

test_policies() {
    ./scripts/policy_manager.sh validate admin all r && echo "Policy test passed" >> "$LOG"
}

test_permissions() {
    test -r resources/public/readme.txt && echo "Public access OK" >> "$LOG"
}

test_monitoring() {
    chmod 777 resources/public/readme.txt
    ./scripts/access_monitor.sh detect
    chmod 644 resources/public/readme.txt
}

summarize_results() {
    cat "$LOG"
}

case "$1" in
    init) initialize_tests ;;
    policies) test_policies ;;
    permissions) test_permissions ;;
    monitoring) test_monitoring ;;
    summary) summarize_results ;;
    all)
        initialize_tests
        test_policies
        test_permissions
        test_monitoring
        summarize_results ;;
    *) echo "Usage: $0 {init|policies|permissions|monitoring|summary|all}" ;;
esac
