#!/bin/bash
# Network Validation Script

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

test_ok() { echo -e "${GREEN}[PASS]${NC} $1"; }
test_fail() { echo -e "${RED}[FAIL]${NC} $1"; }
test_info() { echo -e "${YELLOW}[TEST]${NC} $1"; }

test_info "Checking interfaces"
ip addr show dmz0 &>/dev/null && ip addr show internal0 &>/dev/null && ip addr show mgmt0 &>/dev/null \
&& test_ok "Interfaces present" || test_fail "Interfaces missing"

test_info "Checking IP forwarding"
[[ "$(cat /proc/sys/net/ipv4/ip_forward)" == "1" ]] \
&& test_ok "IP forwarding enabled" || test_fail "IP forwarding disabled"

test_info "Checking iptables rules"
iptables -L FORWARD -n | grep -q 192.168.10.0/24 \
&& test_ok "Segmentation rules detected" || test_fail "Rules missing"

test_info "Checking logging"
iptables -L | grep -q LOG \
&& test_ok "Logging enabled" || test_fail "Logging missing"
