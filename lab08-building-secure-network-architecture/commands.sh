#!/bin/bash
# Lab 8: Building a Secure Network Architecture
# Commands executed during the lab (verbatim)

# --------------------------------------------------
# Baseline Network Inspection
# --------------------------------------------------

ip addr show
ip route show
sudo iptables -L -v -n
netstat -tuln

# --------------------------------------------------
# Create Virtual Network Interfaces (Segmentation)
# --------------------------------------------------

# DMZ Interface
sudo ip link add name dmz0 type dummy
sudo ip addr add 192.168.10.1/24 dev dmz0
sudo ip link set dmz0 up

# Internal Interface
sudo ip link add name internal0 type dummy
sudo ip addr add 192.168.20.1/24 dev internal0
sudo ip link set internal0 up

# Management Interface
sudo ip link add name mgmt0 type dummy
sudo ip addr add 192.168.30.1/24 dev mgmt0
sudo ip link set mgmt0 up

# Verify Interfaces
ip addr show | grep -E "(dmz0|internal0|mgmt0)"

# --------------------------------------------------
# Enable IP Forwarding
# --------------------------------------------------

sudo sysctl net.ipv4.ip_forward=1
echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf
cat /proc/sys/net/ipv4/ip_forward

# --------------------------------------------------
# Reset iptables Configuration
# --------------------------------------------------

sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X

sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

# --------------------------------------------------
# Apply Network Segmentation Rules
# --------------------------------------------------

sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# DMZ Access (HTTP/HTTPS)
sudo iptables -A FORWARD -d 192.168.10.0/24 -p tcp --dport 80 -j ACCEPT
sudo iptables -A FORWARD -d 192.168.10.0/24 -p tcp --dport 443 -j ACCEPT

# Management SSH Access to DMZ
sudo iptables -A FORWARD -s 192.168.30.0/24 -d 192.168.10.0/24 -p tcp --dport 22 -j ACCEPT

# Internal Network Access to DMZ
sudo iptables -A FORWARD -s 192.168.20.0/24 -d 192.168.10.0/24 -p tcp --dport 80 -j ACCEPT
sudo iptables -A FORWARD -s 192.168.20.0/24 -d 192.168.10.0/24 -p tcp --dport 443 -j ACCEPT

# Block DMZ to Internal
sudo iptables -A FORWARD -s 192.168.10.0/24 -d 192.168.20.0/24 -j DROP

# Management Network Full Access
sudo iptables -A FORWARD -s 192.168.30.0/24 -j ACCEPT
sudo iptables -A FORWARD -d 192.168.30.0/24 ! -s 192.168.30.0/24 -j DROP

# Logging & Default Drop
sudo iptables -A FORWARD -j LOG --log-prefix "DROPPED: " --log-level 4
sudo iptables -A FORWARD -j DROP

# --------------------------------------------------
# Verify Firewall Rules
# --------------------------------------------------

sudo iptables -L FORWARD -v -n

# --------------------------------------------------
# Log Monitoring
# --------------------------------------------------

sudo tail -f /var/log/kern.log | grep -E "DROPPED"

# --------------------------------------------------
# Cleanup (Optional)
# --------------------------------------------------

sudo ip link delete dmz0 2>/dev/null
sudo ip link delete internal0 2>/dev/null
sudo ip link delete mgmt0 2>/dev/null

sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X

sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
