#!/bin/bash
echo "=== CLOUD SECURITY LAB FINAL VERIFICATION ==="

echo -e "\n[1] USERS"
id cloud-admin cloud-developer cloud-readonly cloud-auditor

echo -e "\n[2] POLICY CHECK"
/opt/cloud-security-lab/policy-manager.sh check_permission cloud-admin "admin:full-access"

echo -e "\n[3] FIREWALL"
ufw status

echo -e "\n[4] ENCRYPTION KEYS"
ls -l /opt/cloud-security-lab/keys/active

echo -e "\n[5] FAIL2BAN"
systemctl is-active fail2ban

echo -e "\n[6] BACKUPS"
ls -lh /opt/cloud-security-lab/backups

echo -e "\n[7] LOGS"
ls -lh /opt/cloud-security-lab/logs

echo -e "\n=== VERIFICATION COMPLETE ==="
