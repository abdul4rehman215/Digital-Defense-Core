#!/bin/bash

echo "Testing Fail2Ban - This will generate failed login attempts"

echo "Current banned IPs:"
sudo fail2ban-client status sshd

logger -p auth.info "sshd[12345]: Failed password for testuser from 192.168.100.100 port 22 ssh2"
logger -p auth.info "sshd[12346]: Failed password for testuser from 192.168.100.100 port 22 ssh2"
logger -p auth.info "sshd[12347]: Failed password for testuser from 192.168.100.100 port 22 ssh2"
logger -p auth.info "sshd[12348]: Failed password for testuser from 192.168.100.100 port 22 ssh2"

echo "Test entries added to auth.log"
sleep 5

echo "Updated banned IPs:"
sudo fail2ban-client status sshd
