#!/bin/bash
# Lab 02 - Zero Trust Commands Executed

mkdir -p ~/zerotrust-lab/{policies,scripts,logs,resources}
cd ~/zerotrust-lab

nano policies/access_policy.conf
nano scripts/policy_manager.sh
chmod +x scripts/policy_manager.sh

./scripts/policy_manager.sh add alice documents rw 3600 2
./scripts/policy_manager.sh add bob reports r 1800 1
./scripts/policy_manager.sh show

mkdir -p resources/{public,private,restricted,shared}
nano scripts/least_privilege.sh
chmod +x scripts/least_privilege.sh
./scripts/least_privilege.sh apply

nano scripts/access_monitor.sh
chmod +x scripts/access_monitor.sh
./scripts/access_monitor.sh baseline

nano scripts/integration_test.sh
chmod +x scripts/integration_test.sh
./scripts/integration_test.sh all

nano scripts/compliance_report.sh
chmod +x scripts/compliance_report.sh
./scripts/compliance_report.sh
