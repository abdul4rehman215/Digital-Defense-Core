#!/bin/bash
# Network Cleanup Script

echo "Removing virtual interfaces"
ip link delete dmz0 2>/dev/null
ip link delete internal0 2>/dev/null
ip link delete mgmt0 2>/dev/null

echo "Resetting iptables"
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

echo "Cleanup completed successfully"
