#!/bin/bash

echo "=== Final Lab Verification ==="
echo ""

echo "Test 1: Fail2Ban Service Check"
if systemctl is-active --quiet fail2ban; then
    echo "✓ PASS: Fail2Ban is running"
else
    echo "✗ FAIL: Fail2Ban is not running"
fi
echo ""

echo "Test 2: UFW Firewall Check"
if sudo ufw status | grep -q "Status: active"; then
    echo "✓ PASS: UFW is active"
else
    echo "✗ FAIL: UFW is not active"
fi
echo ""

echo "Test 3: SSH Access Rule Check"
if sudo ufw status | grep -q "22/tcp"; then
    echo "✓ PASS: SSH rule exists"
else
    echo "✗ FAIL: SSH rule missing"
fi
echo ""

echo "Test 4: Fail2Ban Configuration File"
if [ -f "/etc/fail2ban/jail.local" ]; then
    echo "✓ PASS: jail.local exists"
else
    echo "✗ FAIL: jail.local missing"
fi
echo ""

echo "Test 5: Authentication Logs Access"
if [ -r "/var/log/auth.log" ]; then
    echo "✓ PASS: auth.log accessible"
else
    echo "✗ FAIL: auth.log not accessible"
fi
echo ""

echo "=== Verification Complete ==="
