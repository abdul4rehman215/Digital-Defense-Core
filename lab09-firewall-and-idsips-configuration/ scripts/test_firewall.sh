#!/bin/bash

echo "=== UFW Firewall Status ==="
sudo ufw status numbered

echo ""
echo "=== Testing Network Connectivity ==="

echo "Testing outgoing HTTP connection:"
curl -I --connect-timeout 5 http://www.google.com 2>/dev/null | head -1

echo "Testing outgoing HTTPS connection:"
curl -I --connect-timeout 5 https://www.google.com 2>/dev/null | head -1

echo ""
echo "=== Current Network Connections ==="
netstat -tuln | head -10

echo ""
echo "=== UFW Application Profiles ==="
sudo ufw app list
