#!/bin/bash
# Cleanup VPN session

sudo pkill -f "openvpn.*client.ovpn"
sleep 3
ip addr show | grep tun || echo "VPN tunnel disconnected successfully"

ls -la /tmp/*.pcap
