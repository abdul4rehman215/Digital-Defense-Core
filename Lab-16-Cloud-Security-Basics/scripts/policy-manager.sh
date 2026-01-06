#!/bin/bash
POLICY_DIR="/opt/cloud-security-lab/policies"
LOG_FILE="/opt/cloud-security-lab/logs/access.log"

create_policy() {
 local role=$1
 local permissions=$2
 local policy_file="$POLICY_DIR/${role}-policy.json"

 cat > "$policy_file" << EOL
{
 "Version": "2023-01-01",
 "Statement": [
  {
   "Effect": "Allow",
   "Action": $permissions,
   "Resource": "*",
   "Principal": {
    "User": "$role"
   }
  }
 ]
}
EOL

 echo "Policy created for $role"
}

check_permission() {
 local user=$1
 local action=$2
 local time=$(date '+%Y-%m-%d %H:%M:%S')

 echo "$time | user=$user | action=$action" >> "$LOG_FILE"

 if groups "$user" | grep -q cloud-admins; then
  echo "ALLOW: admin access"
  return 0
 elif groups "$user" | grep -q cloud-developers && [[ "$action" == develop* ]]; then
  echo "ALLOW: developer access"
  return 0
 elif groups "$user" | grep -q cloud-users && [[ "$action" == read* ]]; then
  echo "ALLOW: read-only access"
  return 0
 elif groups "$user" | grep -q cloud-auditors && [[ "$action" == audit* ]]; then
  echo "ALLOW: audit access"
  return 0
 else
  echo "DENY: insufficient permissions"
  return 1
 fi
}

create_policy cloud-admin '["*"]'
create_policy cloud-developer '["develop:*","read:*"]'
create_policy cloud-readonly '["read:*"]'
create_policy cloud-auditor '["audit:*","read:logs"]'

echo "IAM policy system initialized"
