#!/bin/bash
CMD="$1"
VM="$2"
SNAP="$3"

case "$CMD" in
 create) virsh snapshot-create-as "$VM" "$SNAP" --atomic ;;
 list) virsh snapshot-list "$VM" --tree ;;
 restore) virsh snapshot-revert "$VM" "$SNAP" ;;
 delete) virsh snapshot-delete "$VM" "$SNAP" ;;
 *) echo "Usage: $0 {create|list|restore|delete} <vm> <snapshot>" ;;
esac
