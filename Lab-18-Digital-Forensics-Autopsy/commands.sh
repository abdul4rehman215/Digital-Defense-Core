#!/bin/bash

# ===============================
# Lab 18: Digital Forensics
# ===============================

# Verify Autopsy
autopsy --version
which autopsy

# Install tools if required
sudo apt update
sudo apt install autopsy sleuthkit -y

# Create working directory
mkdir -p ~/forensics_lab
cd ~/forensics_lab

# Create disk image
dd if=/dev/zero of=evidence_usb.img bs=1M count=100

# Attach loop device
sudo losetup /dev/loop0 evidence_usb.img
losetup | grep loop0

# Format FAT32
sudo mkfs.fat -F 32 /dev/loop0

# Mount image
mkdir -p mount_point
sudo mount /dev/loop0 mount_point

# Populate artifacts
sudo mkdir mount_point/Documents mount_point/Pictures mount_point/System

echo "This is a confidential document created on $(date)" | sudo tee mount_point/Documents/confidential.txt
echo "Meeting notes: Project Alpha discussion" | sudo tee mount_point/Documents/meeting_notes.txt
echo "Password list: admin123, user456, guest789" | sudo tee mount_point/Documents/passwords.txt

echo "Hidden system configuration data" | sudo tee mount_point/.hidden_config
echo "JPEG image data would be here" | sudo tee mount_point/Pictures/photo1.jpg
echo "PNG image data would be here" | sudo tee mount_point/Pictures/screenshot.png
echo "System log entry: User login at $(date)" | sudo tee mount_point/System/system.log

# Deleted file simulation
echo "This file will be deleted for forensic recovery" | sudo tee mount_point/deleted_file.txt
sudo rm mount_point/deleted_file.txt

# Unmount & detach
sudo umount mount_point
sudo losetup -d /dev/loop0

# Hashing
md5sum evidence_usb.img > evidence_usb.img.md5
sha256sum evidence_usb.img > evidence_usb.img.sha256

# Timeline creation
fls -r -m / evidence_usb.img > timeline_body.txt
mactime -b timeline_body.txt -d > filesystem_timeline.txt

# Final integrity verification
md5sum evidence_usb.img > final_check.md5
sha256sum evidence_usb.img > final_check.sha256
