#!/bin/bash
# Lab 01 - Commands Executed

mkdir ~/defense-lab
cd ~/defense-lab

sudo ufw status
cat /etc/passwd | grep -E "(root|ubuntu|daemon)"
ls -la /etc/passwd /etc/shadow /etc/sudoers

sudo groupadd security-admins
sudo groupadd security-analysts
sudo groupadd security-users

sudo useradd -m -s /bin/bash -G security-admins sec-admin
sudo useradd -m -s /bin/bash -G security-analysts sec-analyst
sudo useradd -m -s /bin/bash -G security-users sec-user

sudo mkdir -p /opt/security/{admin,analyst,shared,logs}
sudo chown root:security-admins /opt/security/admin
sudo chmod 750 /opt/security/admin
