#!/bin/bash
# Automated Secure Network Architecture Setup Script
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

if [[ $EUID -ne 0 ]]; then
  error "Run as root or with sudo"
  exit 1
fi

info "Backing up iptables rules"
iptables-save > /tmp/iptables_backup_$(date +%F_%T).rules

info "Creating virtual interfaces"
ip link delete dmz0 2>/dev/null || true
ip link delete internal0 2>/dev/null || true
ip link delete mgmt0 2>/dev/null || true

ip link add dmz0 type dummy
ip addr add 192.168.10.1/24 dev dmz0
ip link set dmz0 up

ip link add internal0 type dummy
ip addr add 192.168.20.1/24 dev internal0
ip link set internal0 up

ip link add mgmt0 type dummy
ip addr add 192.168.30.1/24 dev mgmt0
ip link set mgmt0 up

info "Enabling IP forwarding"
sysctl net.ipv4.ip_forward=1
grep -q "net.ipv4.ip_forward=1" /etc/sysctl.conf || echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

info "Resetting iptables"
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

DMZ="192.168.10.0/24"
INT="192.168.20.0/24"
MGMT="192.168.30.0/24"

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -s $MGMT -p tcp --dport 22 -j ACCEPT

iptables -A FORWARD -d $DMZ -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -d $DMZ -p tcp --dport 443 -j ACCEPT
iptables -A FORWARD -s $MGMT -d $DMZ -p tcp --dport 22 -j ACCEPT

iptables -A FORWARD -s $INT -d $DMZ -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A FORWARD -s $DMZ -d $INT -j DROP

iptables -A FORWARD -s $MGMT -j ACCEPT
iptables -A FORWARD -d $MGMT ! -s $MGMT -j DROP

iptables -A INPUT -j LOG --log-prefix "INPUT_DROP: "
iptables -A FORWARD -j LOG --log-prefix "FORWARD_DROP: "

info "Secure network architecture applied successfully"
