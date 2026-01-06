#!/bin/bash
# Lab 13 – Windows Security Basics
# Full command history executed during the lab

########################################
# Task 1: Active Directory Simulation
########################################

# Update system
sudo apt update

# Install Samba and related tools
sudo apt install -y samba samba-common-bin smbclient winbind

# Backup original Samba configuration
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup

# Edit Samba configuration
sudo nano /etc/samba/smb.conf

# Clean previous Samba state (fresh DC setup)
sudo rm -rf /var/lib/samba/*
sudo rm -rf /etc/samba/smb.conf

# Provision Active Directory domain
sudo samba-tool domain provision --use-rfc2307 --interactive

########################################
# Task 1.2: OUs, Users, Groups
########################################

# Create Organizational Units
sudo samba-tool ou create "OU=IT,DC=labdomain,DC=local"
sudo samba-tool ou create "OU=HR,DC=labdomain,DC=local"
sudo samba-tool ou create "OU=SecurityGroups,DC=labdomain,DC=local"

# Create Security Groups
sudo samba-tool group add "IT_Administrators" --groupou="OU=SecurityGroups,DC=labdomain,DC=local"
sudo samba-tool group add "HR_Users" --groupou="OU=SecurityGroups,DC=labdomain,DC=local"
sudo samba-tool group add "Restricted_Users" --groupou="OU=SecurityGroups,DC=labdomain,DC=local"

# Create Users
sudo samba-tool user create itadmin SecurePass123! --userou="OU=IT,DC=labdomain,DC=local"
sudo samba-tool user create hruser SecurePass123! --userou="OU=HR,DC=labdomain,DC=local"
sudo samba-tool user create restricteduser SecurePass123! --userou="OU=HR,DC=labdomain,DC=local"

# Add users to groups
sudo samba-tool group addmembers "IT_Administrators" itadmin
sudo samba-tool group addmembers "HR_Users" hruser
sudo samba-tool group addmembers "Restricted_Users" restricteduser

# Verify AD objects
sudo samba-tool user list
sudo samba-tool group list

########################################
# Task 1.3: GPO Simulation
########################################

# Create SYSVOL policy structure
sudo mkdir -p /var/lib/samba/sysvol/labdomain.local/Policies/{IT_Security_Policy,HR_Security_Policy,Default_Security_Policy}

# Create password policy config
sudo nano /var/lib/samba/sysvol/labdomain.local/Policies/password_policy.conf

# Create password policy script
sudo nano /usr/local/bin/apply_password_policies.sh
sudo chmod +x /usr/local/bin/apply_password_policies.sh
sudo /usr/local/bin/apply_password_policies.sh

########################################
# Task 1.4: Audit & User Rights
########################################

# Create audit policy config
sudo nano /var/lib/samba/sysvol/labdomain.local/Policies/audit_policy.conf

# Create user rights script
sudo nano /usr/local/bin/configure_user_rights.sh
sudo chmod +x /usr/local/bin/configure_user_rights.sh
sudo /usr/local/bin/configure_user_rights.sh

# Verify security logs
sudo tail -5 /var/log/samba/security.log

########################################
# Task 2: Windows Firewall Simulation
########################################

# Install iptables
sudo apt install -y iptables iptables-persistent

# Flush existing rules
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X

# Default deny policy
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

# Allow loopback & established traffic
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow AD ports
sudo iptables -A INPUT -p tcp --dport 53 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 88 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 88 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 389 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 636 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 139 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 445 -j ACCEPT

# Allow application ports
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Block insecure ports
sudo iptables -A INPUT -p tcp --dport 23 -j DROP
sudo iptables -A INPUT -p tcp --dport 135 -j DROP
sudo iptables -A INPUT -p tcp --dport 1433 -j DROP

########################################
# Time & IP Based Firewall Controls
########################################

sudo nano /usr/local/bin/time_based_firewall.sh
sudo chmod +x /usr/local/bin/time_based_firewall.sh
sudo /usr/local/bin/time_based_firewall.sh

sudo nano /usr/local/bin/ip_based_firewall.sh
sudo chmod +x /usr/local/bin/ip_based_firewall.sh
sudo /usr/local/bin/ip_based_firewall.sh

########################################
# Firewall Monitoring & Testing
########################################

sudo nano /usr/local/bin/firewall_monitor.sh
sudo chmod +x /usr/local/bin/firewall_monitor.sh
sudo /usr/local/bin/firewall_monitor.sh

sudo nano /usr/local/bin/test_firewall.sh
sudo chmod +x /usr/local/bin/test_firewall.sh
sudo /usr/local/bin/test_firewall.sh

# Save firewall rules
sudo iptables-save > /etc/iptables/rules.v4

########################################
# Final Verification
########################################

sudo iptables -L -n -v
sudo tail -10 /var/log/syslog | grep FIREWALL
