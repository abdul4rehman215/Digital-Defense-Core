#!/bin/bash
# Capture OpenVPN and TLS traffic

echo "[*] Capturing OpenVPN traffic"
sudo tshark -i any -f "port 1194" -w /tmp/openvpn_encrypted.pcap &
sleep 5
ping -c 5 8.8.8.8 > /dev/null
sudo pkill tshark

echo "[*] Capturing TLS traffic"
sudo tshark -i any -f "port 443" -w /tmp/tls_traffic.pcap &
curl -s https://www.example.com > /dev/null
sleep 3
sudo pkill tshark
