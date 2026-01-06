#!/bin/bash

OUT="$HOME/siem-analysis/normalized"
mkdir -p "$OUT"

grep "Failed password" /var/log/auth.log | while read l; do
    echo "{\"event\":\"auth_failure\",\"raw\":\"$l\"}" >> "$OUT/auth.json"
done

awk '{print "{\"ip\":\""$1"\",\"status\":\""$9"\"}"}' \
/var/log/apache2/access.log >> "$OUT/web.json"

echo "Normalization complete"
