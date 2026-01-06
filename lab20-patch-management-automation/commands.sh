#!/bin/bash

# -------------------------------
# Task 1: Environment Setup
# -------------------------------

sudo apt update

sudo apt install -y python3-pip python3-venv unattended-upgrades apt-listchanges

pip3 install pyyaml schedule psutil requests

sudo apt install -y lynis

python3 --version
lynis --version

# -------------------------------
# Task 1: Project Structure
# -------------------------------

mkdir -p ~/patch-management-lab
cd ~/patch-management-lab

mkdir -p scripts configs logs reports
touch scripts/__init__.py
touch configs/patch_config.yaml

# -------------------------------
# Task 1: Configure Unattended Upgrades
# -------------------------------

sudo dpkg-reconfigure -plow unattended-upgrades

sudo tee /etc/apt/apt.conf.d/20auto-upgrades << 'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

# -------------------------------
# Task 2: Patch Manager Module
# -------------------------------

nano scripts/patch_manager.py

nano scripts/test_patch_manager.py
python3 scripts/test_patch_manager.py

# -------------------------------
# Task 3: Vulnerability Scanner
# -------------------------------

nano scripts/vulnerability_scanner.py

nano scripts/test_scanner.py
python3 scripts/test_scanner.py

# -------------------------------
# Task 4: Automated Patch Deployment
# -------------------------------

nano scripts/automated_patcher.py

nano scripts/run_patch_cycle.py

chmod +x scripts/*.py
python3 scripts/run_patch_cycle.py --security-only

# -------------------------------
# Task 5: Dashboard Generator
# -------------------------------

nano scripts/generate_dashboard.py
python3 scripts/generate_dashboard.py

# -------------------------------
# Verification
# -------------------------------

ls -lh reports/
ls -lh logs/

echo "Lab 20 command execution completed"
