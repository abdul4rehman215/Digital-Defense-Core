#!/bin/bash
set -e
VM_NAME="$1"

if [ -z "$VM_NAME" ]; then
 echo "Usage: $0 <vm-name>"
 exit 1
fi

if ! virsh list --all | grep -qw "$VM_NAME"; then
 echo "VM not found: $VM_NAME"
 exit 1
fi

virsh shutdown "$VM_NAME" || true
sleep 10

virsh dumpxml "$VM_NAME" > /tmp/${VM_NAME}.xml
sed -i '/<cpu /a\  <feature policy="require" name="spec-ctrl"/>\n  <feature policy="require" name="ssbd"/>' /tmp/${VM_NAME}.xml
sed -i 's/cache=.*/cache="none"/' /tmp/${VM_NAME}.xml
sed -i '/<\/devices>/i\<seclabel type="dynamic" model="apparmor" relabel="yes"/>' /tmp/${VM_NAME}.xml

virsh define /tmp/${VM_NAME}.xml
echo "Hardening completed for VM: $VM_NAME"
