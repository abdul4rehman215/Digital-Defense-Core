#!/bin/bash
BASE_DIR="$HOME/zerotrust-lab/resources"
LOG_FILE="$HOME/zerotrust-lab/logs/privilege_log.txt"

chmod 755 "$BASE_DIR/public"
chmod 644 "$BASE_DIR/public/"*

chmod 750 "$BASE_DIR/private"
chmod 640 "$BASE_DIR/private/"*

chmod 700 "$BASE_DIR/restricted"
chmod 600 "$BASE_DIR/restricted/"*

chmod 775 "$BASE_DIR/shared"
chmod 664 "$BASE_DIR/shared/"*

echo "$(date) - permissions_applied" >> "$LOG_FILE"
