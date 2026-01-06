#!/bin/bash

# -------------------------------
# Task 1: IAM-Like Security Controls
# -------------------------------

# Create lab directory structure
sudo mkdir -p /opt/cloud-security-lab/{users,policies,logs,keys}
cd /opt/cloud-security-lab
ls -l /opt/cloud-security-lab

# Create IAM-style users
sudo useradd -m -s /bin/bash cloud-admin
sudo useradd -m -s /bin/bash cloud-developer
sudo useradd -m -s /bin/bash cloud-readonly
sudo useradd -m -s /bin/bash cloud-auditor

# Set user passwords
echo "cloud-admin:SecureAdmin123!" | sudo chpasswd
echo "cloud-developer:DevSecure456!" | sudo chpasswd
echo "cloud-readonly:ReadOnly789!" | sudo chpasswd
echo "cloud-auditor:AuditSecure012!" | sudo chpasswd

# Verify users
id cloud-admin cloud-developer cloud-readonly cloud-auditor

# Create IAM-style groups
sudo groupadd cloud-admins
sudo groupadd cloud-developers
sudo groupadd cloud-users
sudo groupadd cloud-auditors

# Assign users to groups
sudo usermod -a -G cloud-admins cloud-admin
sudo usermod -a -G cloud-developers cloud-developer
sudo usermod -a -G cloud-users cloud-readonly
sudo usermod -a -G cloud-auditors cloud-auditor

# Verify group membership
groups cloud-admin

# Create policy manager script
nano /opt/cloud-security-lab/policy-manager.sh
sudo chmod +x /opt/cloud-security-lab/policy-manager.sh

# Initialize IAM policies
sudo /opt/cloud-security-lab/policy-manager.sh

# Test policy enforcement
sudo -u cloud-admin /opt/cloud-security-lab/policy-manager.sh check_permission cloud-admin "admin:create-instance"
sudo -u cloud-developer /opt/cloud-security-lab/policy-manager.sh check_permission cloud-developer "develop:deploy-app"
sudo -u cloud-readonly /opt/cloud-security-lab/policy-manager.sh check_permission cloud-readonly "admin:delete"

# -------------------------------
# Task 1.3: MFA Simulation
# -------------------------------

# Install MFA dependencies
sudo apt update
sudo apt install -y libpam-google-authenticator qrencode

# Create MFA setup script
nano /opt/cloud-security-lab/setup-mfa.sh
sudo chmod +x /opt/cloud-security-lab/setup-mfa.sh

# Enable MFA for cloud-admin
sudo /opt/cloud-security-lab/setup-mfa.sh cloud-admin

# -------------------------------
# Task 2: Network Security Controls
# -------------------------------

# Reset and configure UFW
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH from private networks
sudo ufw allow from 10.0.0.0/8 to any port 22
sudo ufw allow from 172.16.0.0/12 to any port 22
sudo ufw allow from 192.168.0.0/16 to any port 22

# Allow web traffic
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Enable firewall
sudo ufw --force enable
sudo ufw status verbose

# Create network monitoring script
nano /opt/cloud-security-lab/network-monitor.sh
sudo chmod +x /opt/cloud-security-lab/network-monitor.sh

# Run network monitoring
sudo /opt/cloud-security-lab/network-monitor.sh

# -------------------------------
# Task 2.2: Encryption & Key Management
# -------------------------------

# Create key directories
sudo mkdir -p /opt/cloud-security-lab/keys/{active,backup,revoked}

# Create key manager script
nano /opt/cloud-security-lab/key-manager.sh
sudo chmod +x /opt/cloud-security-lab/key-manager.sh

# Initialize key management
sudo /opt/cloud-security-lab/key-manager.sh

# Test encryption
echo "Sensitive cloud data" > /tmp/sensitive-data.txt
sudo /opt/cloud-security-lab/key-manager.sh encrypt_file /tmp/sensitive-data.txt data-encryption
sudo /opt/cloud-security-lab/key-manager.sh decrypt_file /tmp/sensitive-data.txt.encrypted data-encryption
cat /tmp/sensitive-data.txt.decrypted

# -------------------------------
# Task 2.3: Security Monitoring
# -------------------------------

# Install monitoring tools
sudo apt install -y fail2ban logwatch rkhunter chkrootkit

# Configure Fail2Ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
nano /etc/fail2ban/jail.d/custom.conf

sudo systemctl start fail2ban
sudo systemctl enable fail2ban
sudo fail2ban-client status sshd

# -------------------------------
# Task 2.4: Secure Backup & Recovery
# -------------------------------

# Create secure backup script
nano /opt/cloud-security-lab/secure-backup.sh
sudo chmod +x /opt/cloud-security-lab/secure-backup.sh

# Test backup and restore
sudo /opt/cloud-security-lab/secure-backup.sh create
sudo /opt/cloud-security-lab/secure-backup.sh list
BACKUP_FILE=$(sudo ls /opt/cloud-security-lab/backups/*.encrypted | head -1)
sudo /opt/cloud-security-lab/secure-backup.sh restore "$BACKUP_FILE"

# -------------------------------
# Task 3: Security Auditing & Compliance
# -------------------------------

# Create security audit script
nano /opt/cloud-security-lab/security-audit.sh
sudo chmod +x /opt/cloud-security-lab/security-audit.sh

# Run security audit
sudo /opt/cloud-security-lab/security-audit.sh

# -------------------------------
# Final Verification
# -------------------------------

# Create final verification script
nano /opt/cloud-security-lab/final-verification.sh
sudo chmod +x /opt/cloud-security-lab/final-verification.sh

# Run final verification
sudo /opt/cloud-security-lab/final-verification.sh
