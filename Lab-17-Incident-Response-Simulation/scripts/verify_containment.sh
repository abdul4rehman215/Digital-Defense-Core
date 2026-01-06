#!/bin/bash
echo "=== CONTAINMENT VERIFICATION TEST ==="
echo "Test Time: $(date)"

echo "Testing blocked port 8080:"
timeout 3 curl http://localhost:8080 2>&1 | head -2

echo "Testing blocked port 9999:"
timeout 3 nc -zv localhost 9999 2>&1

BLOCKED=$(sudo iptables -L | grep -c DROP)
echo "DROP rules active: $BLOCKED"

SUSPICIOUS=$(ps aux | grep -E "(suspicious_server|nc.*9999)" | grep -v grep | wc -l)
if [ "$SUSPICIOUS" -eq 0 ]; then
  echo "No suspicious processes running"
else
  echo "Suspicious processes still detected"
fi

echo "Verification complete"
