#!/bin/bash
# Secure Network Architecture Dashboard

clear
while true; do
  clear
  echo "=============================================="
  echo " SECURE NETWORK ARCHITECTURE DASHBOARD"
  echo "=============================================="
  date
  echo

  echo "Interfaces:"
  ip addr show | grep -E "(dmz0|internal0|mgmt0)" -A 2
  echo

  echo "Firewall Summary:"
  iptables -L INPUT -n | head -10
  iptables -L FORWARD -n | head -15
  echo

  echo "Recent Drops:"
  tail -20 /var/log/kern.log | grep DROP | tail -5
  echo

  echo "Press Ctrl+C to exit – refresh in 30s"
  sleep 30
done
