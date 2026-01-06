#!/bin/bash
# Lab 12 – Endpoint Security & Hardening
# Complete command history executed during the lab

############################
# Task 1: Secure SSH Access
############################

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -C "lab-user@endpoint-security"

# Verify SSH keys
ls -la ~/.ssh/

# Copy public key to authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Set secure permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

# Backup SSH configuration
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Edit SSH configuration
sudo nano /etc/ssh/sshd_config

# Validate SSH configuration syntax
sudo sshd -t

# Restart SSH service
sudo systemctl restart ssh

# Verify SSH service status
sudo systemctl status ssh


############################
# Task 2: Install fail2ban
############################

# Update system packages
sudo apt update

# Install fail2ban
sudo apt install fail2ban -y

# Verify fail2ban status
sudo systemctl status fail2ban

# Configure fail2ban SSH jail
sudo nano /etc/fail2ban/jail.local

# Restart and enable fail2ban
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban

# Verify fail2ban jails
sudo fail2ban-client status
sudo fail2ban-client status sshd

# View fail2ban logs
sudo tail -f /var/log/fail2ban.log


############################################
# Task 3: Monitoring Scripts & Automation
############################################

# Create scripts directory
mkdir ~/security-scripts
cd ~/security-scripts

# Create SSH monitoring script
nano ssh-monitor.sh
chmod +x ssh-monitor.sh

# Create system monitoring script
nano system-monitor.sh
chmod +x system-monitor.sh

# Create master security script
nano security-check.sh
chmod +x security-check.sh

# Configure cron job for hourly execution
crontab -e

# Verify cron job
crontab -l


############################################
# Task 4: Verification & Testing
############################################

# Test SSH access on custom port
ssh -p 2222 cloud-lab-user@localhost

# Run monitoring scripts manually
./ssh-monitor.sh
./system-monitor.sh

# Generate test SSH log entry
logger -p auth.info "Failed password for testuser from 192.168.1.100 port 22 ssh2"

# Re-run SSH monitor
./ssh-monitor.sh


############################################
# Task 5: Additional Hardening Measures
############################################

# Enable firewall
sudo ufw enable

# Set default firewall policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH on custom port
sudo ufw allow 2222/tcp

# Verify firewall status
sudo ufw status verbose

# Create file integrity monitoring script
nano ~/security-scripts/file-integrity.sh
chmod +x ~/security-scripts/file-integrity.sh

# Create integrity baseline
~/security-scripts/file-integrity.sh

# Run integrity check
~/security-scripts/file-integrity.sh


############################################
# Final Verification
############################################

# Verify services
sudo systemctl status ssh
sudo systemctl status fail2ban
sudo ufw status

# Verify scripts directory
ls -la ~/security-scripts/

# Run master security script
~/security-scripts/security-check.sh

# Verify cron job
crontab -l
