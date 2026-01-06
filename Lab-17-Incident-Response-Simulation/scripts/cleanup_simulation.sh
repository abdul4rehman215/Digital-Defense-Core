#!/bin/bash
echo "=== CLEANING UP SIMULATION ENVIRONMENT ==="

if [ -f server_pid.txt ]; then
  PID=$(cat server_pid.txt | grep -o '[0-9]*')
  kill $PID 2>/dev/null || true
fi

if [ -f nc_pid.txt ]; then
  PID=$(cat nc_pid.txt)
  kill $PID 2>/dev/null || true
fi

pkill -f suspicious_server.py 2>/dev/null || true
pkill -f "nc.*9999" 2>/dev/null || true

echo "Cleanup completed"
