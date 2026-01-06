#!/bin/bash
echo "=== IMPLEMENTING NETWORK SEGMENTATION ==="
echo "Segmentation Start Time: $(date)"

# Quarantine zone
sudo iptables -N QUARANTINE_ZONE
sudo iptables -A QUARANTINE_ZONE -p tcp --dport 22 -j ACCEPT
sudo iptables -A QUARANTINE_ZONE -p udp --dport 53 -j ACCEPT
sudo iptables -A QUARANTINE_ZONE -p tcp --dport 53 -j ACCEPT
sudo iptables -A QUARANTINE_ZONE -j DROP

# Secure zone
sudo iptables -N SECURE_ZONE
sudo iptables -A SECURE_ZONE -p tcp --dport 80 -j ACCEPT
sudo iptables -A SECURE_ZONE -p tcp --dport 443 -j ACCEPT
sudo iptables -A SECURE_ZONE -p tcp --dport 22 -j ACCEPT
sudo iptables -A SECURE_ZONE -p udp --dport 53 -j ACCEPT
sudo iptables -A SECURE_ZONE -p tcp --dport 53 -j ACCEPT
sudo iptables -A SECURE_ZONE -j DROP

# Apply segmentation
sudo iptables -A INPUT -s 127.0.0.1 -j SECURE_ZONE

echo "Network segmentation implemented"
echo "Segmentation End Time: $(date)"
