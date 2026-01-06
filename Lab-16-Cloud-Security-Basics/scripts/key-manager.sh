#!/bin/bash
KEY_DIR="/opt/cloud-security-lab/keys"
ACTIVE_DIR="$KEY_DIR/active"

generate_key() {
 local key_name=$1
 local key_file="$ACTIVE_DIR/${key_name}.key"
 openssl rand -hex 32 > "$key_file"
 chmod 600 "$key_file"
 echo "Generated key: $key_file"
}

encrypt_file() {
 local file=$1
 local key=$2
 openssl enc -aes-256-cbc -salt \
  -in "$file" \
  -out "$file.encrypted" \
  -pass file:"$ACTIVE_DIR/$key.key"
 echo "Encrypted: $file.encrypted"
}

decrypt_file() {
 local file=$1
 local key=$2
 openssl enc -aes-256-cbc -d \
  -in "$file" \
  -out "${file%.encrypted}.decrypted" \
  -pass file:"$ACTIVE_DIR/$key.key"
 echo "Decrypted: ${file%.encrypted}.decrypted"
}

generate_key "data-encryption"
generate_key "backup-encryption"
generate_key "log-encryption"

echo "Key management initialized"
