#!/bin/bash
# Network Segmentation Testing Script

echo "Testing Network Segmentation Rules..."

echo "Test 1: HTTP traffic to DMZ"
iptables -I FORWARD 1 -d 192.168.10.0/24 -p tcp --dport 80 -j LOG --log-prefix "HTTP_TO_DMZ: "

echo "Test 2: DMZ to Internal traffic"
iptables -I FORWARD 1 -s 192.168.10.0/24 -d 192.168.20.0/24 -j LOG --log-prefix "DMZ_TO_INTERNAL: "

echo "Test 3: Management to DMZ SSH"
iptables -I FORWARD 1 -s 192.168.30.0/24 -d 192.168.10.0/24 -p tcp --dport 22 -j LOG --log-prefix "MGMT_TO_DMZ_SSH: "

echo "Test rules injected. Monitor logs using:"
echo "sudo tail -f /var/log/kern.log"
