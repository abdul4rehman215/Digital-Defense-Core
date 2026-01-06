#!/bin/bash
USER=$1

if [ -z "$USER" ]; then
 echo "Usage: $0 <username>"
 exit 1
fi

echo "Setting up MFA for $USER"
sudo -u "$USER" google-authenticator -t -d -f -r 3 -R 30 -W
echo "MFA enabled for $USER"
