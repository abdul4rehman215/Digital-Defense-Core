#!/bin/bash
# Restore iptables rules on boot

/sbin/iptables-restore < /etc/iptables.rules
