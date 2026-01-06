#!/bin/bash
BACKUP_DIR="/var/backups/vm-backups"
LOG="/var/log/vm-backups.log"

mkdir -p "$BACKUP_DIR"
touch "$LOG"

disk=$(virsh dumpxml "$2" | grep source | awk -F"'" '{print $2}')
cp "$disk" "$BACKUP_DIR/backup-$(date +%F-%H%M%S).qcow2"

echo "$(date) Backup created for $2" >> "$LOG"
