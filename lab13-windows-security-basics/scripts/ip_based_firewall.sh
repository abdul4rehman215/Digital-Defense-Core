#!/bin/bash
# IP-based firewall rules simulating role-based access

ADMIN_NETWORK="192.168.1.0/24"
HR_NETWORK="192.168.2.0/24"
GUEST_NETWORK="192.168.100.0/24"

# Admin network access
sudo iptables -A INPUT -s $ADMIN_NETWORK -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -s $ADMIN_NETWORK -p tcp --dport 3389 -j ACCEPT

# HR network access
sudo iptables -A INPUT -s $HR_NETWORK -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -s $HR_NETWORK -p tcp --dport 443 -j ACCEPT

# Guest network restrictions
sudo iptables -A INPUT -s $GUEST_NETWORK -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -s $GUEST_NETWORK -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -s $GUEST_NETWORK -j DROP

# Block private ranges explicitly
sudo iptables -A INPUT -s 10.0.0.0/8 -j DROP
sudo iptables -A INPUT -s 172.16.0.0/12 -j DROP
