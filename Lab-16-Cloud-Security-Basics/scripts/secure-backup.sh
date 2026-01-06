#!/bin/bash
BACKUP_DIR="/opt/cloud-security-lab/backups"
SOURCE_DIR="/opt/cloud-security-lab"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_NAME="security-backup-$TIMESTAMP"

mkdir -p "$BACKUP_DIR"

create_backup() {
 echo "Creating encrypted backup: $BACKUP_NAME"

 tar -czf "/tmp/${BACKUP_NAME}.tar.gz" \
  -C "$SOURCE_DIR" \
  --exclude="backups" \
  --exclude="*.log" \
  policies users keys

 /opt/cloud-security-lab/key-manager.sh encrypt_file "/tmp/${BACKUP_NAME}.tar.gz" backup-encryption

 mv "/tmp/${BACKUP_NAME}.tar.gz.encrypted" "$BACKUP_DIR/"
 rm -f "/tmp/${BACKUP_NAME}.tar.gz"

 sha256sum "$BACKUP_DIR/${BACKUP_NAME}.tar.gz.encrypted" > \
 "$BACKUP_DIR/${BACKUP_NAME}.checksum"

 echo "Backup stored at $BACKUP_DIR"
}

restore_backup() {
 file="$1"
 mkdir -p /tmp/restore-$TIMESTAMP
 /opt/cloud-security-lab/key-manager.sh decrypt_file "$file" backup-encryption
 tar -xzf "${file%.encrypted}.decrypted" -C /tmp/restore-$TIMESTAMP
 echo "Backup restored to /tmp/restore-$TIMESTAMP"
}

list_backups() {
 ls -lh "$BACKUP_DIR"
}

case "$1" in
 create) create_backup ;;
 restore) restore_backup "$2" ;;
 list) list_backups ;;
 *) echo "Usage: $0 {create|restore <file>|list}" ;;
esac
