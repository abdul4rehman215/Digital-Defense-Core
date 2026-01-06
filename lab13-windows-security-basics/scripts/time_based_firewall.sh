#!/bin/bash
# Time-based firewall rules simulating business-hour RDP access

CURRENT_HOUR=$(date +%H)
CURRENT_DAY=$(date +%u)

sudo iptables -D INPUT -p tcp --dport 3389 -j ACCEPT 2>/dev/null || true
sudo iptables -D INPUT -p tcp --dport 3389 -j DROP 2>/dev/null || true

if [ "$CURRENT_DAY" -ge 1 ] && [ "$CURRENT_DAY" -le 5 ]; then
  if [ "$CURRENT_HOUR" -ge 8 ] && [ "$CURRENT_HOUR" -lt 18 ]; then
    sudo iptables -A INPUT -p tcp --dport 3389 -j ACCEPT
    echo "RDP ALLOWED (Business Hours)"
  else
    sudo iptables -A INPUT -p tcp --dport 3389 -j DROP
    echo "RDP BLOCKED (After Hours)"
  fi
else
  sudo iptables -A INPUT -p tcp --dport 3389 -j DROP
  echo "RDP BLOCKED (Weekend)"
fi
