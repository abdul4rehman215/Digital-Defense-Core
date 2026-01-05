#!/bin/bash
# Network Segmentation Script using iptables
# Lab 8: Building a Secure Network Architecture

echo "Implementing Network Segmentation Rules..."

# Define network segments
DMZ_NET="192.168.10.0/24"
INTERNAL_NET="192.168.20.0/24"
MGMT_NET="192.168.30.0/24"

# Allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established and related traffic
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# DMZ Rules
iptables -A FORWARD -d $DMZ_NET -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -d $DMZ_NET -p tcp --dport 443 -j ACCEPT

# SSH access from Management to DMZ
iptables -A FORWARD -s $MGMT_NET -d $DMZ_NET -p tcp --dport 22 -j ACCEPT

# Internal Network Rules
iptables -A FORWARD -s $INTERNAL_NET -d $DMZ_NET -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -s $INTERNAL_NET -d $DMZ_NET -p tcp --dport 443 -j ACCEPT

# Block DMZ to Internal
iptables -A FORWARD -s $DMZ_NET -d $INTERNAL_NET -j DROP

# Management Network Rules
iptables -A FORWARD -s $MGMT_NET -j ACCEPT
iptables -A FORWARD -d $MGMT_NET ! -s $MGMT_NET -j DROP

# Logging and final drop
iptables -A FORWARD -j LOG --log-prefix "DROPPED: " --log-level 4
iptables -A FORWARD -j DROP

echo "Network segmentation rules applied successfully."
