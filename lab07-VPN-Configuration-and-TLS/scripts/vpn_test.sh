#!/bin/bash
# VPN connectivity test

echo "[*] Checking tun interface"
ip addr show tun0

echo "[*] Pinging VPN gateway"
ping -c 3 10.8.0.1

echo "[*] Checking routing table"
ip route | grep tun

echo "[*] External IP"
curl -s https://ipinfo.io/ip
