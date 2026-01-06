#!/bin/bash
echo "=== IMPLEMENTING CONTAINMENT MEASURES ==="
echo "Containment Start Time: $(date)"

# Backup firewall rules
sudo iptables-save > iptables_backup.txt
echo "Firewall rules backed up"

# Block suspicious ports
sudo iptables -A INPUT -p tcp --dport 8080 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8080 -j DROP

sudo iptables -A INPUT -p tcp --dport 9999 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 9999 -j DROP

# Block suspicious IP range
sudo iptables -A INPUT -s 192.168.100.0/24 -j DROP
sudo iptables -A OUTPUT -d 192.168.100.0/24 -j DROP

# Enable logging
sudo iptables -A INPUT -j LOG --log-prefix "INCIDENT_BLOCKED: "
sudo iptables -A OUTPUT -j LOG --log-prefix "INCIDENT_BLOCKED: "

echo "Containment measures applied"
echo "Containment End Time: $(date)"
