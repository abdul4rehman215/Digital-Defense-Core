#!/bin/bash
# Lab 14: Virtualization Security - Commands Executed

# System update
sudo apt update && sudo apt upgrade -y

# Install KVM and libvirt
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients \
bridge-utils virt-manager virtinst

# Verify CPU virtualization support
egrep -c '(vmx|svm)' /proc/cpuinfo

# Verify KVM modules
lsmod | grep kvm

# Add user to libvirt group
sudo usermod -a -G libvirt $USER
newgrp libvirt

# Create secure virtual network
sudo mkdir -p /etc/libvirt/qemu/networks
sudo tee /etc/libvirt/qemu/networks/secure-net.xml > /dev/null

sudo virsh net-define /etc/libvirt/qemu/networks/secure-net.xml
sudo virsh net-start secure-net
sudo virsh net-autostart secure-net
virsh net-list --all

# Backup and harden libvirt configuration
sudo cp /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.backup
sudo systemctl restart libvirtd

# Create VM disk
sudo qemu-img create -f qcow2 /var/lib/libvirt/images/test-vm.qcow2 5G

# Define VM
sudo virsh define vm-configs/test-vm.xml

# Harden VM
~/vm-security/harden-vm.sh test-vm

# Snapshot operations
~/vm-security/snapshot-manager.sh create test-vm baseline
~/vm-security/snapshot-manager.sh list test-vm

# Backup operations
~/vm-security/backup-manager.sh backup test-vm
~/vm-security/backup-manager.sh list

# Cron automation
crontab -e
