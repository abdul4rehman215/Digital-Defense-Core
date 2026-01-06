#!/bin/bash
# Apply password policies using samba-tool
# Simulates Group Policy password enforcement

echo "Applying password policies..."

sudo samba-tool domain passwordsettings set --complexity=on
sudo samba-tool domain passwordsettings set --history-length=12
sudo samba-tool domain passwordsettings set --min-pwd-length=12
sudo samba-tool domain passwordsettings set --min-pwd-age=1
sudo samba-tool domain passwordsettings set --max-pwd-age=90

sudo samba-tool domain passwordsettings set --account-lockout-threshold=5
sudo samba-tool domain passwordsettings set --account-lockout-duration=30

echo "Password policies applied successfully!"
echo "Current password policy settings:"
sudo samba-tool domain passwordsettings show
