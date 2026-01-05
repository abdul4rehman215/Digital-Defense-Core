#!/bin/bash

echo "=== Comprehensive Security Check ==="
echo "Timestamp: $(date)"
echo ""

echo "1. Checking Fail2Ban Service:"
if systemctl is-active --quiet fail2ban; then
    echo " ✓ Fail2Ban is running"
    echo " Active jails: $(sudo fail2ban-client status | grep 'Jail list' | cut -d: -f2 | tr -d ' ')"
else
    echo " ✗ Fail2Ban is not running"
fi
echo ""

echo "2. Checking UFW Status:"
if sudo ufw status | grep -q "Status: active"; then
    echo " ✓ UFW is active"
    rule_count=$(sudo ufw status numbered | grep -c "^\[")
    echo " Active rules: $rule_count"
else
    echo " ✗ UFW is inactive"
fi
echo ""

echo "3. Recent Security Events:"
failed_logins=$(sudo grep "Failed password" /var/log/auth.log | tail -5 | wc -l)
echo " Recent failed login attempts: $failed_logins"
echo ""

echo "4. Open Network Ports:"
netstat -tuln | grep LISTEN | awk '{print $4}' | sort | uniq
echo ""

echo "5. System Update Status:"
updates_available=$(apt list --upgradable 2>/dev/null | grep -c upgradable)
echo " Available updates: $updates_available"
echo ""

echo "=== Security Check Complete ==="
