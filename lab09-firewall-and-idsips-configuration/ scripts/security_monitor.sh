#!/bin/bash

echo "=== Security Monitoring Dashboard ==="
echo "Generated on: $(date)"
echo ""

echo "=== Fail2Ban Status ==="
sudo fail2ban-client status
echo ""

echo "=== Currently Banned IPs (SSH Jail) ==="
sudo fail2ban-client status sshd
echo ""

echo "=== Recent Authentication Failures ==="
sudo tail -20 /var/log/auth.log | grep "Failed password" || echo "No recent failures"
echo ""

echo "=== UFW Firewall Status ==="
sudo ufw status numbered
echo ""

echo "=== Recent UFW Blocks ==="
if [ -f /var/log/ufw.log ]; then
    sudo tail -20 /var/log/ufw.log
else
    echo "UFW logging file not found"
fi
echo ""

echo "=== System Resource Usage ==="
echo "Memory:"
free -h
echo ""
echo "Disk:"
df -h / | tail -1
echo ""

echo "=== Active Listening Services ==="
netstat -tuln | grep LISTEN | head -10
