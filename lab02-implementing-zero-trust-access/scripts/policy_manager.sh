#!/bin/bash
# Zero Trust Policy Manager

BASE_DIR="$HOME/zerotrust-lab"
POLICY_FILE="$BASE_DIR/policies/access_policy.conf"
LOG_FILE="$BASE_DIR/logs/access_log.txt"

log_activity() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

validate_access() {
    local username="$1"
    local resource="$2"
    local permission="$3"

    policy=$(grep "^${username}:" "$POLICY_FILE")

    if [[ -z "$policy" ]]; then
        log_activity "DENIED | user=$username | reason=user_not_found"
        return 1
    fi

    IFS=":" read -r u r p t v <<< "$policy"

    [[ "$r" != "all" && "$r" != "$resource" ]] && log_activity "DENIED | resource_not_allowed" && return 1
    [[ "$p" != *"$permission"* ]] && log_activity "DENIED | permission_not_allowed" && return 1

    log_activity "GRANTED | user=$username | resource=$resource | permission=$permission"
    return 0
}

add_policy() {
    echo "$1:$2:$3:$4:$5" >> "$POLICY_FILE"
    log_activity "POLICY_ADDED | user=$1"
}

remove_policy() {
    sed -i "/^$1:/d" "$POLICY_FILE"
    log_activity "POLICY_REMOVED | user=$1"
}

show_policies() {
    column -t -s ":" "$POLICY_FILE"
}

case "$1" in
    validate) validate_access "$2" "$3" "$4" ;;
    add) add_policy "$2" "$3" "$4" "$5" "$6" ;;
    remove) remove_policy "$2" ;;
    show) show_policies ;;
    *) echo "Usage: $0 {validate|add|remove|show}" ;;
esac
