#!/bin/bash
for vm in $(virsh list --name --all); do
 ~/vm-security/backup-manager.sh backup "$vm"
done
